import 'package:flutter/material.dart';
import 'package:moody/data/providers/hive.dart';
import 'package:moody/views/screens/dashboard_page.dart';
import 'package:moody/views/screens/router.dart';

void main() async {
  await initializeHiveDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoute,
      home: DashboardPage(),
    );
  }
}
