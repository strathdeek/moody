import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/data/extensions.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/views/widgets/navigation_tray.dart';
import 'package:moody/data/constants/enums/mood_type.dart';

class EntryListPage extends StatefulWidget {
  @override
  _EntryListPageState createState() => _EntryListPageState();
}

class _EntryListPageState extends State<EntryListPage> {
  var _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MOODY'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>
                  Navigator.of(context).pushNamed(SettingsPageRoute))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Expanding SliverAppBar to enable one handed use on big smartphones.
          SliverAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            snap: false,
            pinned: true,
            floating: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).textTheme.headline4?.color,
                  ),
                  onPressed: () {
                    setState(() {
                      _date = DateTime(_date.year, _date.month - 1);
                    });
                  },
                ),
                Text(
                  DateFormat.yMMMM('en_US').format(_date),
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).textTheme.headline4?.color ??
                        Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _date = DateTime(_date.year, _date.month + 1);
                    });
                  },
                ),
              ],
            ),
          ),

          BlocBuilder<MoodBloc, MoodState>(
            builder: (context, state) {
              if (state is MoodLoadSuccess) {
                var tiles = <Widget>[];
                state.moodEntries.sort((a, b) => a.date.compareTo(b.date));
                for (var mood in state.moodEntries.where((element) =>
                    element.date.month == _date.month &&
                    element.date.year == _date.year)) {
                  tiles.add(
                    ListTile(
                      title: visualizeMood(mood),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildListDelegate(tiles),
                );
              } else {
                return Text('No entries available.');
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationTray(),
    );
  }

  Widget visualizeMood(Mood mood) {
    return Card(
      // color: mood.score.toMoodType().toColor().shade400,
      shadowColor: mood.score.toMoodType().toColor().shade600,
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.2),
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        children: [
          Card(
            color: mood.score.toMoodType().toColor().shade400,
            shadowColor: mood.score.toMoodType().toColor().shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(0),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: TextEditingController(
                  text: (DateFormat.yMMMMEEEEd('en_US').format(mood.date))),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              enabled: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  mood.score.roundToDigits(1).toString(),
                  style: TextStyle(
                    // color: mood.score.toMoodType().toColor(),
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
