import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/reminder/reminder_cubit.dart';
import 'package:moody/generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Expanding SliverAppBar to enable one handed use on big smartphones.
          SliverAppBar(
            stretch: true,
            expandedHeight: 300,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
                color: Theme.of(context).textTheme.headline4?.color),
            snap: false,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.fadeTitle,
              ],
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: Text('Delete User Data'),
                  subtitle: Text('Permanently deletes all saved mood entries.'),
                  onTap: () {},
                ),
                ListTile(
                  enabled: false,
                  title: Text('Export CSV'),
                  subtitle:
                      Text('Coming soon: export your entries to a CSV file'),
                ),
                SwitchListTile(
                  title: Text('Dark Mode'),
                  subtitle: Text('Override the system theme.'),
                  // to be changed in DarkMode ticket.
                  value: true,
                  onChanged: (bool value) {},
                ),
                BlocBuilder<ReminderCubit, ReminderState>(
                  builder: (context, state) {
                    return SwitchListTile(
                      title:
                          Text(S.of(context).pageSettingsRemindersToggleLabel),
                      subtitle: Text(
                          S.of(context).pageSettingsRemindersToggleDescription),
                      // to be changed in DarkMode ticket.
                      value: state is ReminderEnabled,
                      onChanged: (bool value) {
                        context
                            .read<ReminderCubit>()
                            .setRemindersEnabled(value, context);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
