import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/navigation/navigation_cubit.dart';
import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/generated/l10n.dart';

class NavigationTray extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationCubit, NavigationState>(
      listener: (context, state) {
        switch (state.selectedIndex) {
          case 0:
            Navigator.of(context)
                .pushNamedAndRemoveUntil(DashboardPageRoute, (route) => false);
            break;
          case 1:
            Navigator.of(context)
                .pushNamedAndRemoveUntil(StatisticsPageRoute, (route) => false);
            break;
          case 2:
            var user = (context.read<UserBloc>().state is UserLoadSuccess)
                ? (context.read<UserBloc>().state as UserLoadSuccess).user
                : null;
            Navigator.of(context).pushNamedAndRemoveUntil(
                ProfilePageRoute, (route) => false,
                arguments: user);
            break;
        }
      },
      builder: (context, state) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: S.of(context).pageDashboardTitle,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: S.of(context).pageStatisticsTitle,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: S.of(context).pageProfileTitle,
            ),
          ],
          onTap: (value) =>
              context.read<NavigationCubit>().setSelectedTab(value),
          currentIndex: state.selectedIndex,
        );
      },
    );
  }
}
