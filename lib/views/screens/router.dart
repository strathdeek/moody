import 'package:flutter/material.dart';
import 'package:moody/data/constants/navigation.dart';
import 'package:moody/views/screens/dashboard_page.dart';

Route generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashboardPageRoute:
      return MaterialPageRoute(builder: (context) => DashboardPage());
    default:
      return MaterialPageRoute(builder: (context) => DashboardPage());
  }
}
