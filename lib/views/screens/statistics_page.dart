import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/extensions.dart';
import 'package:moody/data/constants/enums/mood_type.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/views/widgets/navigation_tray.dart';
import 'package:moody/views/widgets/title_card.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  DateTime _date = DateTime.now();

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
      body: BlocBuilder<MoodBloc, MoodState>(
        builder: (context, state) {
          if (state is MoodLoadSuccess) {
            return ListView(
              children: [
                TitleCard(
                  title: 'By Type',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 220,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PieChart(
                          PieChartData(
                            sections: prepareMoodCounts(state.moodEntries),
                            sectionsSpace: 4,
                            startDegreeOffset: -90,
                            centerSpaceRadius: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TitleCard(
                  title: 'Monthly',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                            height: 220,
                            child:
                                prepareMonthlyGraph(state.moodEntries, _date)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.color,
                              ),
                              onPressed: () {
                                setState(() {
                                  _date = DateTime(_date.year, _date.month - 1);
                                });
                              },
                            ),
                            Text(
                              DateFormat.yMMMM('en_US').format(_date),
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.color ??
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
                      ],
                    ),
                  ),
                ),
                TitleCard(
                  title: 'Streak',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: prepareStreakCounter(state.moodEntries),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Text('Data could not be loaded');
        },
      ),
      bottomNavigationBar: NavigationTray(),
    );
  }

  List<PieChartSectionData> prepareMoodCounts(List<Mood> moodEntries) {
    return List.generate(
      MoodType.values.length,
      (index) {
        var mood = MoodType.values[index];
        var count = moodEntries
            .where((element) => element.score.toMoodType() == mood)
            .length;
        return PieChartSectionData(
          value: count.toDouble(),
          color: mood.toColor(),
          title: mood.getTypeName(),
          radius: 50,
        );
      },
    );
  }

  Widget prepareMonthlyGraph(List<Mood> moodEntries, DateTime month) {
    var moods = moodEntries
        .where((element) => element.date.month == month.month)
        .toList();

    if (moods.isEmpty) {
      return Center(child: Text('No Data for this month available.'));
    }

    moods.sort((a, b) => a.date.compareTo(b.date));

    return LineChart(
      LineChartData(
        maxX: DateTime(month.year, month.month + 1, 0).day.toDouble(),
        maxY: 100.0,
        minX: 1,
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              moods.length,
              (index) => FlSpot(
                moods[index].date.day.toDouble(),
                moods[index].score,
              ),
            ),
            colors: List.generate(
              MoodType.values.length,
              (index) => MoodType.values[index].toColor(),
            ),
            preventCurveOverShooting: true,
            gradientFrom: Offset(0, 0),
            gradientTo: Offset(0, 1),
            colorStops: [.2, .4, .6, .8, 1],
            isStepLineChart: true,
            barWidth: 3.5,
            dotData: FlDotData(
              show: false,
            ),
          ),
        ],
        titlesData: FlTitlesData(
            leftTitles: SideTitles(interval: 20, showTitles: true)),
        gridData: FlGridData(
          horizontalInterval: 10,
        ),
      ),
    );
  }

  Widget prepareStreakCounter(List<Mood> moodEntries) {
    moodEntries.sort((a, b) => b.date.compareTo(a.date));
    var currentStreak = 0;
    var longestStreak = 0;
    var newestStreak;
    var i;
    for (i = 0; i < moodEntries.length - 1; i++) {
      var diff = moodEntries[i].date.difference(moodEntries[i + 1].date);
      currentStreak++;
      if (diff.inDays >= 2) {
        longestStreak =
            longestStreak < currentStreak ? currentStreak : longestStreak;
        newestStreak = newestStreak ?? currentStreak;
        currentStreak = 0;
      }
    }

    return Column(
      children: [
        Text(
          newestStreak.toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          'Your Record: ' + longestStreak.toString(),
        ),
      ],
    );
  }
}
