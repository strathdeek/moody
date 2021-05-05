import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/data/notifications.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/navigation_tray.dart';

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
        body: Center(
          child: Column(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return (state is UserLoadSuccess)
                      ? Text(S.of(context).pageDashboardHello + state.user.name)
                      : Text(S.of(context).pageDashboardHello +
                          S.of(context).pageDashboardGuest);
                },
              ),
              Text(S.of(context).pageDashboardGreeting),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(NewEntryPageRoute),
                child: Text(S.of(context).pageDashboardAddMoodButton),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(EntryListPageRoute),
                child: Text('See all entries'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationTray(),
      ),
    );
  }
}
