import 'package:flutter/material.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/navigation_tray.dart';

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
      body: Center(
        child: Text(S.of(context).pageStatisticsTitle),
      ),
      bottomNavigationBar: NavigationTray(),
    );
  }
}
