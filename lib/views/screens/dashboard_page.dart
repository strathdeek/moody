import 'package:flutter/material.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/views/widgets/navigation_tray.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Moody'),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () =>
                    Navigator.of(context).pushNamed(SettingsPageRoute))
          ],
        ),
        body: Center(
          child: Text('Welcome to Moody'),
        ),
        bottomNavigationBar: NavigationTray(),
      ),
    );
  }
}
