import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiwi/kiwi.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/bloc/navigation/navigation_cubit.dart';
import 'package:moody/bloc/reminder/reminder_cubit.dart';
import 'package:moody/bloc/theme/theme_cubit.dart';
import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/providers/hive.dart';
import 'package:moody/data/providers/mood_provider.dart';
import 'package:moody/data/providers/preferences_provider.dart';
import 'package:moody/data/providers/user_provider.dart';
import 'package:moody/data/repositories/mood_repository.dart';
import 'package:moody/data/repositories/preferences_repository.dart';
import 'package:moody/data/repositories/user_repository.dart';
import 'package:moody/platforms/platform.dart';
import 'package:moody/platforms/platform_android.dart';
import 'package:moody/platforms/platform_ios.dart';
import 'package:moody/views/screens/router.dart';
import 'generated/l10n.dart';

void main() async {
  await initializeHiveDatabase();

  if (io.Platform.isAndroid) {
    KiwiContainer().registerSingleton<Platform>((container) => Android());
  } else if (io.Platform.isIOS) {
    KiwiContainer().registerSingleton<Platform>((container) => IOS());
  }

  var moodProvider = MoodProvider();
  var moodRepository = MoodRepository(moodProvider);

  var userProvider = UserProvider();
  var userRepository = UserRepository(userProvider);

  var preferencesProvider = PreferencesProvider();
  var preferencesRepository = PreferencesRepository(preferencesProvider);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => MoodBloc(moodRepository)..add(AppStart()),
    ),
    BlocProvider(
      create: (context) => UserBloc(userRepository)..add(UserAppStart()),
    ),
    BlocProvider(
      create: (context) => NavigationCubit(),
    ),
    BlocProvider(create: (context) => ReminderCubit(preferencesRepository)),
    BlocProvider(create: (context) => ThemeCubit(preferencesRepository)),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.indigo, brightness: Brightness.light),
          darkTheme: ThemeData(
              primarySwatch: Colors.deepPurple,
              brightness: Brightness.dark,
              primaryColor: Colors.deepPurple,
              accentColor: Colors.deepPurpleAccent,
              radioTheme: RadioThemeData(
                  fillColor:
                      MaterialStateProperty.all(Colors.deepPurpleAccent)),
              switchTheme: SwitchThemeData(
                  thumbColor: MaterialStateProperty.all(Colors.deepPurple),
                  trackColor:
                      MaterialStateProperty.all(Colors.deepPurpleAccent))),
          themeMode: state.themeMode,
          onGenerateRoute: generateRoute,
          initialRoute: '/',
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
