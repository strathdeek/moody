import 'package:flutter/material.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/navigation_tray.dart';
import 'package:moody/views/widgets/stats_mood_count.dart';
import 'package:moody/views/widgets/stats_mood_monthly.dart';
import 'package:moody/views/widgets/stats_mood_streak.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>
                  Navigator.of(context).pushNamed(SettingsPageRoute))
        ],
      ),
      body: ListView(
        children: [
          StatsMoodCount(),
          StatsMoodMonthly(),
          StatsMoodStreak(),
        ],
      ),
      bottomNavigationBar: NavigationTray(),
    );
  }
}
