import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moody/data/exceptions.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/data/repositories/mood_repository.dart';

part 'mood_event.dart';
part 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final MoodRepository _moodRepository;
  MoodBloc(this._moodRepository) : super(MoodLoadInProgress());

  @override
  Stream<MoodState> mapEventToState(
    MoodEvent event,
  ) async* {
    if (event is AppStart) {
      yield MoodLoadInProgress();
      try {
        var moodEntries = _moodRepository.get();
        yield MoodLoadSuccess(moodEntries);
      } on RepositoryException catch (e) {
        yield MoodLoadFail(e.error);
      }
    }
    if (state is MoodLoadSuccess) {
      var moodEntries = (state as MoodLoadSuccess).moodEntries;
      if (event is MoodAdded) {
        try {
          _moodRepository.add(event.mood);
          var updatedEntries = List<Mood>.from(moodEntries)..add(event.mood);
          yield MoodLoadSuccess(updatedEntries);
        } on RepositoryException catch (e) {
          yield MoodLoadFail(e.error);
        }
      }

      if (event is MoodDeleted) {
        try {
          _moodRepository.delete(event.mood);
          var updatedEntries = List<Mood>.from(moodEntries)..remove(event.mood);
          yield MoodLoadSuccess(updatedEntries);
        } on RepositoryException catch (e) {
          yield MoodLoadFail(e.error);
        }
      }

      if (event is MoodUpdated) {
        try {
          _moodRepository.update(event.mood);
          var updatedEntries = moodEntries
              .map<Mood>((e) => e.id == event.mood.id ? event.mood : e)
              .toList();
          yield MoodLoadSuccess(updatedEntries);
        } on RepositoryException catch (e) {
          yield MoodLoadFail(e.error);
        }
      }
    }
  }
}
