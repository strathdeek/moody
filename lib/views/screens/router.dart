import 'package:flutter/material.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/data/models/user.dart';
import 'package:moody/views/screens/dashboard_page.dart';
import 'package:moody/views/screens/entry_list_page.dart';
import 'package:moody/views/screens/new_entry_page.dart';
import 'package:moody/views/screens/profile_page.dart';
import 'package:moody/views/screens/settings_page.dart';
import 'package:moody/views/screens/statistics_page.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashboardPageRoute:
      return _buildPageWithNoTransition(() => DashboardPage(), settings);
    case StatisticsPageRoute:
      return _buildPageWithNoTransition(() => StatisticsPage(), settings);
    case ProfilePageRoute:
      return _buildPageWithNoTransition(
          () => ProfilePage(user: settings.arguments as User?), settings);
    case SettingsPageRoute:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case NewEntryPageRoute:
      return MaterialPageRoute(builder: (context) => NewEntryPage());
    case EntryListPageRoute:
      return MaterialPageRoute(builder: (context) => EntryListPage());
    default:
      return _buildPageWithNoTransition(() => DashboardPage(), settings);
  }
}

Route _buildPageWithNoTransition<T>(
  Widget Function() builder,
  RouteSettings settings,
) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 0),
    pageBuilder: (_, __, ___) => builder(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
