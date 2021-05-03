import 'package:flutter/material.dart';
import 'package:moody/generated/l10n.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).PageSettingsTitle),
      ),
      body: Center(
        child: Text(S.of(context).PageSettingsTitle),
      ),
    );
  }
}
