part of 'reminder_cubit.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

class ReminderDisabled extends ReminderState {}

class ReminderEnabled extends ReminderState {}
