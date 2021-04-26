part of 'mood_bloc.dart';

abstract class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object> get props => [];
}

class MoodLoadInProgress extends MoodState {}

class MoodLoadSuccess extends MoodState {
  final List<Mood> moodEntries;

  MoodLoadSuccess(this.moodEntries);

  @override
  List<Object> get props => [moodEntries];
}

class MoodLoadFail extends MoodState {
  final String error;

  MoodLoadFail(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
