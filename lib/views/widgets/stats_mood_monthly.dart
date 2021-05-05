import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/constants/enums/mood_type.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/title_card.dart';

class StatsMoodMonthly extends StatefulWidget {
  @override
  _StatsMoodMonthlyState createState() => _StatsMoodMonthlyState();
}

class _StatsMoodMonthlyState extends State<StatsMoodMonthly> {
  DateTime _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return TitleCard(
      title: S.of(context).pageStatisticsMonthly,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoodBloc, MoodState>(
          builder: (context, state) {
            if (state is MoodLoadSuccess) {
              var moods = state.moodEntries
                  .where((element) => element.date.month == _date.month)
                  .toList();
              moods.sort((a, b) => a.date.compareTo(b.date));

              return Column(
                children: [
                  SizedBox(
                    height: 220,
                    child: moods.isEmpty
                        ? Center(
                            child:
                                Text(S.of(context).pageStatisticsMonthlyNoData))
                        : LineChart(
                            LineChartData(
                              maxX: DateTime(_date.year, _date.month + 1, 0)
                                  .day
                                  .toDouble(),
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
                                  leftTitles: SideTitles(
                                      interval: 20, showTitles: true)),
                              gridData: FlGridData(
                                horizontalInterval: 10,
                              ),
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).textTheme.headline5?.color,
                        ),
                        onPressed: () {
                          setState(() {
                            _date = DateTime(_date.year, _date.month - 1);
                          });
                        },
                      ),
                      Text(
                        DateFormat.yMMMM(S.of(context).localeKey).format(_date),
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).textTheme.headline5?.color ??
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
              );
            } else {
              return Text(S.of(context).pageStatisticsLoadingError);
            }
          },
        ),
      ),
    );
  }
}
