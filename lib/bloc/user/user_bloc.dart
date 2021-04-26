import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moody/data/exceptions.dart';
import 'package:moody/data/models/user.dart';
import 'package:moody/data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserLoadInProgress());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserAppStart) {
      yield UserLoadInProgress();
      try {
        var user = _userRepository.get();
        yield UserLoadSuccess(user);
      } on RepositoryException catch (_) {
        yield UserLoadNoUser();
      }
    }
    if (event is UserCreated) {
      try {
        var user = User(
            name: event.name,
            location: event.location,
            birthDate: event.birthdate);
        _userRepository.add(user);
        yield UserLoadSuccess(user);
      } on RepositoryException catch (e) {
        yield UserLoadFail(e.error);
      }
    }
    if (state is UserLoadSuccess) {
      var user = (state as UserLoadSuccess).user;
      if (event is UserUpdated) {
        try {
          var updatedUser = user.copyWith(
              name: event.name,
              location: event.location,
              birthDate: event.birthdate);
          _userRepository.update(updatedUser);
          yield UserLoadSuccess(updatedUser);
        } on RepositoryException catch (e) {
          yield UserLoadFail(e.error);
        }
      }
      if (event is UserNameUpdated) {
        try {
          var updatedUser = user.copyWith(name: event.name);
          _userRepository.update(updatedUser);
          yield UserLoadSuccess(updatedUser);
        } on RepositoryException catch (e) {
          yield UserLoadFail(e.error);
        }
      }
      if (event is UserBirthDateUpdated) {
        try {
          var updatedUser = user.copyWith(birthDate: event.birthdate);
          _userRepository.update(updatedUser);
          yield UserLoadSuccess(updatedUser);
        } on RepositoryException catch (e) {
          yield UserLoadFail(e.error);
        }
      }
      if (event is UserLocationUpdated) {
        try {
          var updatedUser = user.copyWith(location: event.location);
          _userRepository.update(updatedUser);
          yield UserLoadSuccess(updatedUser);
        } on RepositoryException catch (e) {
          yield UserLoadFail(e.error);
        }
      }
      if (event is UserDeleted) {
        try {
          _userRepository.delete(user);
          yield UserLoadNoUser();
        } on RepositoryException catch (e) {
          yield UserLoadFail(e.error);
        }
      }
    }
  }
}
