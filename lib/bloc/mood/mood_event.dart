part of 'mood_bloc.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object> get props => [];
}

class MoodAdded extends MoodEvent {
  final Mood mood;

  MoodAdded(this.mood);

  @override
  List<Object> get props => [mood];
}

class MoodDeleted extends MoodEvent {
  final Mood mood;

  MoodDeleted(this.mood);

  @override
  List<Object> get props => [mood];
}

class MoodUpdated extends MoodEvent {
  final Mood mood;

  MoodUpdated(this.mood);

  @override
  List<Object> get props => [mood];
}

class AppStart extends MoodEvent {}

class ExportEntries extends MoodEvent {}
