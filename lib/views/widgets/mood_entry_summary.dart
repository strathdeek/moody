import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/emote_banner.dart';
import 'package:moody/data/constants/enums/mood_type.dart';
import 'package:moody/views/widgets/mood_image.dart';

class MoodEntrySummary extends StatelessWidget {
  final Mood mood;

  const MoodEntrySummary({Key? key, required this.mood}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.solid, width: .1),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yMMMMd').format(mood.date),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  DateFormat('jm').format(mood.date),
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                color: mood.score.toMoodType().toColor(),
                child: Container(
                  padding: EdgeInsets.all(8),
                  height: 70,
                  width: 70,
                  child: EmoteBanner(
                      height: 100,
                      showBanner: false,
                      moodType: mood.score.toMoodType()),
                ),
              ),
              MoodImage(
                imagePath: mood.imagePath,
                height: 100,
              ),
              Text(
                  S.of(context).pageDashboardEntryCardScore(mood.score.round()),
                  style: Theme.of(context).textTheme.subtitle1),
            ]),
          ],
        ),
      ),
    );
  }
}
