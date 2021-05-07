import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/data/notifications.dart';
import 'package:moody/generated/l10n.dart';
import 'package:moody/views/widgets/navigation_tray.dart';

class DashboardPage extends StatelessWidget {
  Future<void> _navigateToCamera(BuildContext context) async {
    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.front);
    await Navigator.of(context)
        .pushNamed(CameraPageRoute, arguments: frontCamera);
  }

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
              Center(
                child: ElevatedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(NewEntryPageRoute),
                    child: Text('child')),
              )
            ],
          ),
        ),
        bottomNavigationBar: NavigationTray(),
      ),
    );
  }
}
