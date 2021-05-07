import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moody/data/constants/enums/mood_type.dart';
import 'package:moody/views/widgets/emote_banner.dart';

import '../../bloc/mood/mood_bloc.dart';
import '../../data/models/mood.dart';

class NewEntryPage extends StatefulWidget {
  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  double _moodValue = 50;
  DateTime _date = DateTime.now();

  late final TextEditingController _dateController = TextEditingController(
      text: (DateFormat.yMMMMEEEEd('en_US').format(_date)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: _moodValue.toMoodType().toColor(),
        title: Text('How do you feel today?'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EmoteBanner(
                height: 400,
                showBanner: true,
                moodType: _moodValue.toMoodType(),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Date'),
                    Stack(
                      children: [
                        TextFormField(
                          textAlign: TextAlign.center,
                          controller: _dateController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              prefixIcon: Icon(Icons.calendar_today)),
                        ),
                        // GestureController prevents TextFormField from opening the Keyboard on Android.
                        GestureDetector(
                          onTap: () async {
                            var date = await showDatePicker(
                              context: context,
                              initialDate: (_date),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            setState(() {
                              _date = date ?? _date;
                            });

                            _dateController.text =
                                DateFormat.yMMMMEEEEd('en_US').format(_date);
                          },
                          child: Container(
                            height: 70,
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slider.adaptive(
                    min: 0,
                    max: 100,
                    label: _moodValue.round().toString(),
                    value: _moodValue,
                    onChanged: (newValue) {
                      setState(() {
                        _moodValue = newValue;
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
