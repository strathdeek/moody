import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:moody/data/repositories/preferences_repository.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final PreferencesRepository _preferencesRepository;
  ThemeCubit(
    this._preferencesRepository,
  ) : super(ThemeState(_preferencesRepository.theme));

  void setTheme(ThemeMode theme) {
    _preferencesRepository.setTheme(theme);
    emit(ThemeState(theme));
  }
}
