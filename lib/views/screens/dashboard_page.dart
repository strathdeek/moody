import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/data/notifications.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/emote_banner.dart';
import 'package:moody/views/widgets/mood_entry_summary.dart';
import 'package:moody/views/widgets/navigation_tray.dart';
import 'package:moody/data/constants/enums/mood_type.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeNotifications(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appTitle),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>
                  Navigator.of(context).pushNamed(SettingsPageRoute),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return Text(
                          (state is UserLoadSuccess)
                              ? '${S.of(context).pageDashboardHello}\n${state.user.name}'
                              : '${S.of(context).pageDashboardHello}\n${S.of(context).pageDashboardGuest}',
                          style: Theme.of(context).textTheme.headline4,
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).pageDashboardGreeting,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 10, top: 10),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              S.of(context).pageDashboardEntryCardTitle,
                              style: Theme.of(context).textTheme.headline6,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<MoodBloc, MoodState>(
                          builder: (context, state) {
                            if (state is MoodLoadSuccess &&
                                state.moodEntries.isNotEmpty) {
                              // Layout for entries
                              state.moodEntries
                                  .sort((a, b) => a.date.compareTo(b.date));
                              var latest = state.moodEntries.last;
                              return Column(
                                children: [
                                  MoodEntrySummary(mood: latest),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () {
                                          //TODO: navigate to mood entry list page
                                        },
                                        child: Text(
                                          S
                                              .of(context)
                                              .pageDashboardEntryCardShowMore,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      )),
                                ],
                              );
                            }
                            // Layout for no entries
                            else {
                              return Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  S.of(context).pageDashboardEntryNoEntriesText,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              S.of(context).pageDashboardEntryAverageCardTitle,
                              style: Theme.of(context).textTheme.headline6,
                            )),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              S
                                  .of(context)
                                  .pageDashboardEntryAverageCardDescription,
                              style: Theme.of(context).textTheme.subtitle1,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<MoodBloc, MoodState>(
                          builder: (context, state) {
                            if (state is MoodLoadSuccess &&
                                state.moodEntries.isNotEmpty) {
                              // Layout for entries
                              state.moodEntries
                                  .sort((a, b) => a.date.compareTo(b.date));
                              var latest = state.moodEntries
                                  .where((element) => element.date.isAfter(
                                      (DateTime.now()
                                          .subtract(Duration(days: 7)))))
                                  .toList();
                              var sumScore = latest
                                  .map<double>((e) => e.score)
                                  .reduce((a, b) => a + b);
                              var avgScore = sumScore / latest.length;
                              return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      color: avgScore.toMoodType().toColor(),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        height: 80,
                                        width: 80,
                                        child: EmoteBanner(
                                            height: 80,
                                            showBanner: false,
                                            moodType: avgScore.toMoodType()),
                                      ),
                                    ),
                                    Text(
                                        S
                                            .of(context)
                                            .pageDashboardEntryCardScore(
                                                avgScore.round()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ]);
                            }
                            // Layout for no entries
                            else {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 15),
                                child: Text(
                                  S.of(context).pageDashboardEntryNoEntriesText,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(NewEntryPageRoute),
                      child: Text(S.of(context).pageDashboardNewEntryButton),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: NavigationTray(),
      ),
    );
  }
}
