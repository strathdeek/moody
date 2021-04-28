import 'package:flutter/material.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Delete User Data'),
            subtitle: Text('Permanently deletes all saved mood entries.'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Export CSV'),
            subtitle: Text('Coming soon: export your entries to a CSV file'),
          ),
          SwitchListTile(
            title: Text('Dark Mode'),
            subtitle: Text('Override the system theme.'),
            // to be changed in DarkMode ticket.
            value: true,
            onChanged: (bool value) {},
          ),
        ],
      ),
    );
  }
}
