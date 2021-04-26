part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoadInProgress extends UserState {}

class UserLoadNoUser extends UserState {}

class UserLoadSuccess extends UserState {
  final User user;

  const UserLoadSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoadFail extends UserState {
  final String error;

  const UserLoadFail(this.error);

  @override
  List<Object> get props => [error];
}
