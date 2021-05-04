// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `MOODY`
  String get appTitle {
    return Intl.message(
      'MOODY',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `en_US`
  String get localeKey {
    return Intl.message(
      'en_US',
      name: 'localeKey',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Moody`
  String get pageDashboardGreeting {
    return Intl.message(
      'Welcome to Moody',
      name: 'pageDashboardGreeting',
      desc: '',
      args: [],
    );
  }

  /// `Hello, `
  String get pageDashboardHello {
    return Intl.message(
      'Hello, ',
      name: 'pageDashboardHello',
      desc: '',
      args: [],
    );
  }

  /// `Guest User.`
  String get pageDashboardGuest {
    return Intl.message(
      'Guest User.',
      name: 'pageDashboardGuest',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get pageDashboardTitle {
    return Intl.message(
      'Home',
      name: 'pageDashboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add today's mood now!`
  String get pageDashboardAddMoodButton {
    return Intl.message(
      'Add today\'s mood now!',
      name: 'pageDashboardAddMoodButton',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get PageSettingsTitle {
    return Intl.message(
      'Settings',
      name: 'PageSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get pageStatisticsTitle {
    return Intl.message(
      'Statistics',
      name: 'pageStatisticsTitle',
      desc: '',
      args: [],
    );
  }

  /// `By Type`
  String get pageStatisticsType {
    return Intl.message(
      'By Type',
      name: 'pageStatisticsType',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get pageStatisticsMonthly {
    return Intl.message(
      'Monthly',
      name: 'pageStatisticsMonthly',
      desc: '',
      args: [],
    );
  }

  /// `No Data for this month available.`
  String get pageStatisticsMonthlyNoData {
    return Intl.message(
      'No Data for this month available.',
      name: 'pageStatisticsMonthlyNoData',
      desc: '',
      args: [],
    );
  }

  /// `Your Record: `
  String get pageStatisticsStreakRecord {
    return Intl.message(
      'Your Record: ',
      name: 'pageStatisticsStreakRecord',
      desc: '',
      args: [],
    );
  }

  /// `Streak`
  String get pageStatisticsStreak {
    return Intl.message(
      'Streak',
      name: 'pageStatisticsStreak',
      desc: '',
      args: [],
    );
  }

  /// `Data could not be loaded`
  String get pageStatisticsLoadingError {
    return Intl.message(
      'Data could not be loaded',
      name: 'pageStatisticsLoadingError',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get pageProfileTitle {
    return Intl.message(
      'Profile',
      name: 'pageProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Guest User`
  String get pageProfileHeaderGuest {
    return Intl.message(
      'Guest User',
      name: 'pageProfileHeaderGuest',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get pageProfileHeader {
    return Intl.message(
      'My Profile',
      name: 'pageProfileHeader',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get pageProfileNameLabel {
    return Intl.message(
      'Name',
      name: 'pageProfileNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get pageProfileLocationLabel {
    return Intl.message(
      'Location',
      name: 'pageProfileLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get pageProfileDateOfBirthLabel {
    return Intl.message(
      'Date of Birth',
      name: 'pageProfileDateOfBirthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Create profile`
  String get pageProfileCreateButton {
    return Intl.message(
      'Create profile',
      name: 'pageProfileCreateButton',
      desc: '',
      args: [],
    );
  }

  /// `Save profile`
  String get pageProfileSaveButton {
    return Intl.message(
      'Save profile',
      name: 'pageProfileSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `Terrible`
  String get moodTypeTerrible {
    return Intl.message(
      'Terrible',
      name: 'moodTypeTerrible',
      desc: '',
      args: [],
    );
  }

  /// `Bad`
  String get moodTypeBad {
    return Intl.message(
      'Bad',
      name: 'moodTypeBad',
      desc: '',
      args: [],
    );
  }

  /// `Meh`
  String get moodTypeMeh {
    return Intl.message(
      'Meh',
      name: 'moodTypeMeh',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get moodTypeGood {
    return Intl.message(
      'Good',
      name: 'moodTypeGood',
      desc: '',
      args: [],
    );
  }

  /// `Awesome`
  String get moodTypeAwesome {
    return Intl.message(
      'Awesome',
      name: 'moodTypeAwesome',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
