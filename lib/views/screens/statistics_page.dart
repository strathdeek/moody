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
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: prepareMoodCounts(state.moodEntries),
                        sectionsSpace: 5,
                        startDegreeOffset: -90,
                      ),
                    ),
                  ),
                ),
                TitleCard(
                  title: 'Monthly',
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: LineChart(
                            prepareMonthlyGraph(state.moodEntries, _date)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color:
                                  Theme.of(context).textTheme.headline5?.color,
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
    return List.generate(MoodType.values.length, (index) {
      var mood = MoodType.values[index];
      var count = moodEntries
          .where((element) => element.score.toMoodType() == mood)
          .length;
      return PieChartSectionData(
          value: count.toDouble(),
          color: mood.toColor(),
          title: mood.getTypeName());
    });
  }

  LineChartData prepareMonthlyGraph(List<Mood> moodEntries, DateTime month) {
    var moods = moodEntries
        .where((element) => element.date.month == month.month)
        .toList();
    moods.sort((a, b) => a.date.compareTo(b.date));

    return LineChartData(
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
      titlesData:
          FlTitlesData(leftTitles: SideTitles(interval: 20, showTitles: true)),
      gridData: FlGridData(horizontalInterval: 10),
    );
  }
}
