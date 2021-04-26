part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserAppStart extends UserEvent {}

class UserCreated extends UserEvent {
  final String name;
  final String? location;
  final DateTime? birthdate;

  UserCreated({required this.name, this.location, this.birthdate});

  @override
  List<Object?> get props => [name, location, birthdate];
}

class UserUpdated extends UserEvent {
  final String? name;
  final String? location;
  final DateTime? birthdate;

  UserUpdated({this.name, this.location, this.birthdate});

  @override
  List<Object?> get props => [name, location, birthdate];
}

class UserLocationUpdated extends UserEvent {
  final String location;

  UserLocationUpdated(this.location);

  @override
  List<Object> get props => [location];
}

class UserNameUpdated extends UserEvent {
  final String name;

  UserNameUpdated(this.name);

  @override
  List<Object> get props => [name];
}

class UserBirthDateUpdated extends UserEvent {
  final DateTime birthdate;

  UserBirthDateUpdated(this.birthdate);

  @override
  List<Object> get props => [birthdate];
}

class UserDeleted extends UserEvent {}
