import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/user/user_bloc.dart';
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
          child: Column(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return (state is UserLoadSuccess)
                      ? Text('Hello, ${state.user.name}')
                      : Text('Hello, Guest User');
                },
              ),
              Text('Welcome to Moody'),
            ],
          ),
        ),
        bottomNavigationBar: NavigationTray(),
      ),
    );
  }
}
