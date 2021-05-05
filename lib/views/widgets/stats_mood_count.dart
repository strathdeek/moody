import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/constants/enums/mood_type.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/title_card.dart';
import 'package:moody/data/extensions.dart';

class StatsMoodCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TitleCard(
      title: S.of(context).pageStatisticsType,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoodBloc, MoodState>(
          builder: (context, state) {
            if (state is MoodLoadSuccess) {
              return SizedBox(
                height: 220,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PieChart(
                          PieChartData(
                            sections: List.generate(
                              MoodType.values.length,
                              (index) {
                                var mood = MoodType.values[index];
                                var count = state.moodEntries
                                    .where((element) =>
                                        element.score.toMoodType() == mood)
                                    .length;
                                return PieChartSectionData(
                                  value: count.toDouble(),
                                  color: mood.toColor(),
                                  title:
                                      (count / state.moodEntries.length * 100)
                                              .roundToDigits(1)
                                              .toString() +
                                          '%',
                                  radius: 50,
                                );
                              },
                            ),
                            sectionsSpace: 4,
                            startDegreeOffset: -90,
                            centerSpaceRadius: 50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            MoodType.values.length,
                            (index) => Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: MoodType.values[index].toColor(),
                                    ),
                                    SizedBox(width: 10),
                                    Text(MoodType.values[index].getTypeName()),
                                  ],
                                )),
                      ),
                    ),
                  ],
                ),
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
