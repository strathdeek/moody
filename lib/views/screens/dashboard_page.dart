import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Moody'),
        ),
        body: Center(
          child: Text('Welcome to Moody'),
        ),
      ),
    );
  }
}
