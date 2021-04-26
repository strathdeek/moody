import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/navigation/navigation_cubit.dart';
import 'package:moody/data/constants/navigation.dart';

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
            Navigator.of(context)
                .pushNamedAndRemoveUntil(ProfilePageRoute, (route) => false);
            break;
        }
      },
      builder: (context, state) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Statistics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
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
