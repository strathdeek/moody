import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/providers/hive.dart';
import 'package:moody/data/providers/mood_provider.dart';
import 'package:moody/data/repositories/mood_repository.dart';
import 'package:moody/views/screens/dashboard_page.dart';
import 'package:moody/views/screens/router.dart';

import 'bloc/mood/cubit/navigation_cubit.dart';

void main() async {
  await initializeHiveDatabase();

  var moodProvider = MoodProvider();
  var moodRepository = MoodRepository(moodProvider);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => MoodBloc(moodRepository),
    ),
    BlocProvider(
      create: (context) => NavigationCubit(),
    )
  ], child: MyApp()));
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
      initialRoute: '/',
    );
  }
}
