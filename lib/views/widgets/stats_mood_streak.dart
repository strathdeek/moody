import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/title_card.dart';

class StatsMoodStreak extends StatelessWidget {
  late final int _longestStreak;
  late final int _newestStreak;

  @override
  Widget build(BuildContext context) {
    return TitleCard(
      title: S.of(context).pageStatisticsStreak,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoodBloc, MoodState>(
          builder: (context, state) {
            if (state is MoodLoadSuccess) {
              prepareStreakCounter(state.moodEntries);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Column(
                        children: [
                          Text(
                            _newestStreak.toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            S.of(context).pageStatisticsStreakRecord +
                                _longestStreak.toString(),
                          ),
                        ],
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

  void prepareStreakCounter(List<Mood> moodEntries) {
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

    _longestStreak = longestStreak == 0 ? currentStreak : longestStreak;
    _newestStreak = newestStreak ?? _longestStreak;
  }
}
