import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/data/extensions.dart';
import 'package:moody/data/constants/enums/mood_type.dart';
import 'package:moody/generated/l10n.dart';

class MoodListEntry extends StatelessWidget {
  final Mood mood;

  const MoodListEntry({Key? key, required this.mood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: mood.score.toMoodType().toColor().shade600,
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              color: mood.score.toMoodType().toColor().shade400,
              shadowColor: mood.score.toMoodType().toColor().shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Text(DateFormat.yMMMMEEEEd(S.of(context).localeKey)
                        .format(mood.date)),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  mood.score.roundToDigits(1).toString(),
                  style: TextStyle(
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
