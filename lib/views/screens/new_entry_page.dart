import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/mood/mood_bloc.dart';
import '../../data/models/mood.dart';

class NewEntryPage extends StatefulWidget {
  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  double _moodValue = .5;
  Widget _moodDisplay = Text('Fill this uninitialized space');
  Color _moodColor = Colors.amber;
  DateTime _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    _moodDisplay = buildMoodDisplay();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: _moodColor,
        title: Text('How do you feel today?'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _moodDisplay,
              TextButton(
                onPressed: () async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    _date = date ?? _date;
                  });
                },
                child: Text(
                  'Date: ' + _date.toString(),
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slider(
                    value: _moodValue,
                    onChanged: (newValue) {
                      setState(() {
                        _moodValue = newValue;
                        _moodDisplay = buildMoodDisplay();
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: save,
                    child: Text('Save'),
                  ),
                  TextButton(
                    onPressed: navigateBack,
                    child: Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMoodDisplay() {
    var color;
    var mood;
    if (_moodValue > .8) {
      color = Colors.green;
      mood = MoodClass.awesome;
    } else if (_moodValue > .6) {
      color = Colors.lime;
      mood = MoodClass.good;
    } else if (_moodValue > .4) {
      color = Colors.amber;
      mood = MoodClass.meh;
    } else if (_moodValue > .2) {
      color = Colors.orange;
      mood = MoodClass.bad;
    } else {
      color = Colors.red;
      mood = MoodClass.terrible;
    }
    setState(() {
      _moodColor = color.shade400;
    });
    return Stack(
      children: [
        CustomPaint(
          size: Size.fromHeight(460),
          painter: CurvedPainter(color: color.shade400),
        ),
        CustomPaint(
          size: Size.fromHeight(400),
          painter: EmotePainter(emotion: mood),
        )
      ],
    );
  }

  void save() {
    context.read<MoodBloc>().add(
          MoodAdded(
            Mood(
              score: _moodValue,
              date: _date,
            ),
          ),
        );
    navigateBack();
  }

  void navigateBack() {
    Navigator.pop(context);
  }
}

class CurvedPainter extends CustomPainter {
  final Color color;
  CurvedPainter({
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.95);
    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height * 0.925);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.85,
        size.width * 1.0, size.height * 0.9);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class EmotePainter extends CustomPainter {
  final MoodClass emotion;
  final double _y_offset = 10;
  EmotePainter({
    required this.emotion,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    switch (emotion) {
      case MoodClass.awesome:
        canvas.drawLine(
            Offset(150, _y_offset + 50), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 50), Offset(250, _y_offset + 150), paint);
        canvas.drawArc(
            Rect.fromPoints(
                Offset(100, _y_offset + 150), Offset(300, _y_offset + 250)),
            0,
            pi,
            true,
            paint);
        break;
      case MoodClass.good:
        canvas.drawLine(
            Offset(150, _y_offset + 50), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 50), Offset(250, _y_offset + 150), paint);
        canvas.drawArc(
            Rect.fromPoints(
                Offset(100, _y_offset + 150), Offset(300, _y_offset + 250)),
            0,
            pi,
            false,
            paint);
        break;
      case MoodClass.meh:
        canvas.drawLine(
            Offset(150, _y_offset + 50), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 50), Offset(250, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(100, _y_offset + 250), Offset(300, _y_offset + 250), paint);
        break;
      case MoodClass.bad:
        canvas.drawLine(
            Offset(150, _y_offset + 50), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 50), Offset(250, _y_offset + 150), paint);
        canvas.drawArc(
            Rect.fromPoints(
                Offset(100, _y_offset + 300), Offset(300, _y_offset + 200)),
            pi,
            pi,
            false,
            paint);
        break;
      case MoodClass.terrible:
        canvas.drawLine(
            Offset(150, _y_offset + 100), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(125, _y_offset + 25), Offset(175, _y_offset + 75), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 100), Offset(250, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(225, _y_offset + 75), Offset(275, _y_offset + 25), paint);
        canvas.drawArc(
            Rect.fromPoints(
                Offset(100, _y_offset + 300), Offset(300, _y_offset + 200)),
            pi,
            pi,
            false,
            paint);
        break;
      default:
        break;
    }

    var pb = ParagraphBuilder(
      ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: 36.0,
      ),
    );
    var emotionName =
        emotion.toString().substring(emotion.toString().lastIndexOf('.') + 1);
    emotionName = emotionName.replaceRange(0, 1, emotionName[0].toUpperCase());

    pb.addText(emotionName);
    var paragraph = pb.build();
    paragraph.layout(ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, Offset(50, _y_offset + 325));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum MoodClass {
  awesome,
  good,
  meh,
  bad,
  terrible,
}
