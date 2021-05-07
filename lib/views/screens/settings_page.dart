import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/bloc/reminder/reminder_cubit.dart';
import 'package:moody/bloc/theme/theme_cubit.dart';
import 'package:moody/generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
                    title: Text(S.of(context).pageSettingsDeleteUserDataLabel),
                    subtitle: Text(
                        S.of(context).pageSettingsDeleteUserDataDescription),
                    onTap: () {
                      context.read<MoodBloc>().add(MoodAllDeleted());
                    },
                  ),
                  Divider(),
                  ListTile(
                    enabled: false,
                    title: Text('Export CSV'),
                    subtitle:
                        Text('Coming soon: export your entries to a CSV file'),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(S.of(context).pageSettingsThemeLabel),
                    subtitle: Text(S.of(context).pageSettingsThemeDescription),
                  ),
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            RadioListTile(
                              groupValue: state.themeMode,
                              title: Text(S
                                  .of(context)
                                  .pageSettingsDarkModeToggleLabel),
                              subtitle: Text(S
                                  .of(context)
                                  .pageSettingsDarkModeToggleDescription),
                              value: ThemeMode.dark,
                              onChanged: (value) {
                                if (value is ThemeMode) {
                                  context.read<ThemeCubit>().setTheme(value);
                                }
                              },
                            ),
                            RadioListTile(
                              groupValue: state.themeMode,
                              title: Text(S
                                  .of(context)
                                  .pageSettingsLightModeToggleLabel),
                              subtitle: Text(S
                                  .of(context)
                                  .pageSettingsLightModeToggleDescription),
                              value: ThemeMode.light,
                              onChanged: (value) {
                                if (value is ThemeMode) {
                                  context.read<ThemeCubit>().setTheme(value);
                                }
                              },
                            ),
                            RadioListTile(
                              groupValue: state.themeMode,
                              title: Text(S
                                  .of(context)
                                  .pageSettingsSystemModeToggleLabel),
                              subtitle: Text(S
                                  .of(context)
                                  .pageSettingsSystemModeToggleDescription),
                              value: ThemeMode.system,
                              onChanged: (value) {
                                if (value is ThemeMode) {
                                  context.read<ThemeCubit>().setTheme(value);
                                }
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(),
                  BlocBuilder<ReminderCubit, ReminderState>(
                    builder: (context, state) {
                      return SwitchListTile(
                        title: Text(
                            S.of(context).pageSettingsRemindersToggleLabel),
                        subtitle: Text(S
                            .of(context)
                            .pageSettingsRemindersToggleDescription),
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
      ),
    );
  }
}
