import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  final String title;
  final Widget child;

  const TitleCard({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
