import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/bloc/navigation/navigation_cubit.dart';
import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/providers/hive.dart';
import 'package:moody/data/providers/mood_provider.dart';
import 'package:moody/data/providers/user_provider.dart';
import 'package:moody/data/repositories/mood_repository.dart';
import 'package:moody/data/repositories/user_repository.dart';
import 'package:moody/views/screens/router.dart';

import 'generated/l10n.dart';

void main() async {
  await initializeHiveDatabase();

  var moodProvider = MoodProvider();
  var moodRepository = MoodRepository(moodProvider);

  var userProvider = UserProvider();
  var userRepository = UserRepository(userProvider);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => MoodBloc(moodRepository)..add(AppStart()),
    ),
    BlocProvider(
      create: (context) => UserBloc(userRepository)..add(UserAppStart()),
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
      // darkTheme: ThemeData.dark(),
      onGenerateRoute: generateRoute,
      initialRoute: '/',
      localizationsDelegates: [S.delegate],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
