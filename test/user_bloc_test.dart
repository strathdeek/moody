import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moody/bloc/user/user_bloc.dart';
import 'package:moody/data/exceptions.dart';
import 'package:moody/data/models/user.dart';
import 'package:moody/data/repositories/user_repository.dart';

import 'user_bloc_test.mocks.dart';

var userOnlyName = User(name: 'John');
var userNameAndBirthday = User(name: 'Steve', birthDate: DateTime(1992));
var userNameAndLocation = User(name: 'Ralph', location: 'Montana');
var userComplete =
    User(name: 'Billy', location: 'Seattle', birthDate: DateTime(1970));
@GenerateMocks([UserRepository])
void main() {
  group('User Bloc', () {
    late UserBloc userBloc;
    late UserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      when(userRepository.get()).thenReturn(userComplete);
      userBloc = UserBloc(userRepository);
    });

    blocTest<UserBloc, UserState>(
        'enter NoUserFound state when repository throws',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) => bloc.add(UserAppStart()),
        expect: () => [UserLoadInProgress(), UserLoadNoUser()]);

    blocTest<UserBloc, UserState>('add user with only name',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(name: userOnlyName.name));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userOnlyName)
            ]);
    blocTest<UserBloc, UserState>('add user with name and location',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(
              name: userNameAndLocation.name,
              location: userNameAndLocation.location));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userNameAndLocation)
            ]);
    blocTest<UserBloc, UserState>('add user with name and birthdate',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(
              name: userNameAndBirthday.name,
              birthdate: userNameAndBirthday.birthDate));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userNameAndBirthday)
            ]);
    blocTest<UserBloc, UserState>('add user with name, birthday, location',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(
              name: userComplete.name,
              location: userComplete.location,
              birthdate: userComplete.birthDate));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userComplete)
            ]);
    blocTest<UserBloc, UserState>(
        'add user with only name, then update location',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(name: userOnlyName.name));
          bloc.add(UserLocationUpdated('Munich'));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userOnlyName),
              UserLoadSuccess(userOnlyName.copyWith(location: 'Munich'))
            ]);
    blocTest<UserBloc, UserState>(
        'add user with only name, then update birthdate',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(name: userOnlyName.name));
          bloc.add(UserBirthDateUpdated(DateTime(1776)));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userOnlyName),
              UserLoadSuccess(userOnlyName.copyWith(birthDate: DateTime(1776))),
            ]);
    blocTest<UserBloc, UserState>('add user with only name, then update name',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(name: userOnlyName.name));
          bloc.add(UserNameUpdated('Paul'));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userOnlyName),
              UserLoadSuccess(User(name: 'Paul'))
            ]);

    blocTest<UserBloc, UserState>('add complete user, update location',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(
              name: userComplete.name,
              location: userComplete.location,
              birthdate: userComplete.birthDate));
          bloc.add(UserLocationUpdated('Utah'));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userComplete),
              UserLoadSuccess(userComplete.copyWith(location: 'Utah')),
            ]);
    blocTest<UserBloc, UserState>('add complete user, update birthdate',
        build: () {
          when(userRepository.get()).thenThrow(RepositoryException('no user'));
          return userBloc;
        },
        act: (bloc) {
          bloc.add(UserAppStart());
          bloc.add(UserCreated(
              name: userComplete.name,
              location: userComplete.location,
              birthdate: userComplete.birthDate));
          bloc.add(UserBirthDateUpdated(DateTime(1980)));
        },
        expect: () => [
              UserLoadInProgress(),
              UserLoadNoUser(),
              UserLoadSuccess(userComplete),
              UserLoadSuccess(userComplete.copyWith(birthDate: DateTime(1980))),
            ]);
  });
}
