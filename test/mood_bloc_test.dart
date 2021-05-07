import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/exceptions.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/data/repositories/mood_repository.dart';
import 'mood_bloc_test.mocks.dart';

var mood1 = Mood(score: 1);
var mood2 = Mood(score: 2);
var mood3 = Mood(score: 3);
var mood4 = Mood(score: 4);
var mood5 = Mood(score: 5);
var mood6 = Mood(score: 6);
var mood7 = Mood(score: 7);
var mood8 = Mood(score: 8);
var mood9 = Mood(score: 9);
var mood10 = Mood(score: 10);

@GenerateMocks([MoodRepository])
void main() {
  group('mood bloc', () {
    late MoodBloc moodBloc;
    late MoodRepository moodRepository;

    setUp(() {
      moodRepository = MockMoodRepository();
      when(moodRepository.get()).thenReturn(<Mood>[]);

      moodBloc = MoodBloc(moodRepository);
    });

    blocTest<MoodBloc, MoodState>(
      'Should emit MoodLoadFail when repository throws',
      build: () {
        when(moodRepository.get()).thenThrow(RepositoryException('oops'));

        return moodBloc;
      },
      act: (MoodBloc bloc) async => bloc.add(AppStart()),
      expect: () => <MoodState>[
        MoodLoadInProgress(),
        MoodLoadFail('oops'),
      ],
    );

    blocTest<MoodBloc, MoodState>(
      'Should emit MoodLoadSuccess when repository loads',
      build: () {
        return moodBloc;
      },
      act: (MoodBloc bloc) async => bloc.add(AppStart()),
      expect: () => <MoodState>[
        MoodLoadInProgress(),
        MoodLoadSuccess([]),
      ],
    );

    blocTest<MoodBloc, MoodState>(
      'add a mood entry',
      build: () {
        return moodBloc;
      },
      act: (MoodBloc bloc) async {
        bloc.add(AppStart());
        bloc.add(MoodAdded(mood10));
      },
      expect: () => <MoodState>[
        MoodLoadInProgress(),
        MoodLoadSuccess([]),
        MoodLoadSuccess([mood10]),
      ],
    );

    blocTest<MoodBloc, MoodState>(
      'add multiple mood entries',
      build: () {
        return moodBloc;
      },
      act: (MoodBloc bloc) async {
        bloc.add(AppStart());
        bloc.add(MoodAdded(mood1));
        bloc.add(MoodAdded(mood2));
        bloc.add(MoodAdded(mood3));
        bloc.add(MoodAdded(mood4));
        bloc.add(MoodAdded(mood5));
      },
      expect: () => <MoodState>[
        MoodLoadInProgress(),
        MoodLoadSuccess([]),
        MoodLoadSuccess([mood1]),
        MoodLoadSuccess([mood1, mood2]),
        MoodLoadSuccess([mood1, mood2, mood3]),
        MoodLoadSuccess([mood1, mood2, mood3, mood4]),
        MoodLoadSuccess([mood1, mood2, mood3, mood4, mood5]),
      ],
    );

    blocTest<MoodBloc, MoodState>(
      'delete multiple mood entries',
      build: () {
        return moodBloc;
      },
      act: (MoodBloc bloc) async {
        bloc.add(AppStart());
        bloc.add(MoodAdded(mood1));
        bloc.add(MoodAdded(mood2));
        bloc.add(MoodAdded(mood3));
        bloc.add(MoodDeleted(mood3));
        bloc.add(MoodDeleted(mood2));
      },
      expect: () => <MoodState>[
        MoodLoadInProgress(),
        MoodLoadSuccess([]),
        MoodLoadSuccess([mood1]),
        MoodLoadSuccess([mood1, mood2]),
        MoodLoadSuccess([mood1, mood2, mood3]),
        MoodLoadSuccess([mood1, mood2]),
        MoodLoadSuccess([mood1]),
      ],
    );
    blocTest<MoodBloc, MoodState>(
      'delete all mood entries',
      build: () {
        return moodBloc;
      },
      act: (MoodBloc bloc) async {
        bloc.add(AppStart());
        bloc.add(MoodAdded(mood1));
        bloc.add(MoodAdded(mood2));
        bloc.add(MoodAdded(mood3));
        bloc.add(MoodAllDeleted());
      },
      expect: () => <MoodState>[
        MoodLoadInProgress(),
        MoodLoadSuccess([]),
        MoodLoadSuccess([mood1]),
        MoodLoadSuccess([mood1, mood2]),
        MoodLoadSuccess([mood1, mood2, mood3]),
        MoodLoadSuccess([]),
      ],
    );

    blocTest<MoodBloc, MoodState>(
      'delete mood entry',
      build: () {
        return moodBloc;
      },
      act: (MoodBloc bloc) async {
        bloc.add(AppStart());
        bloc.add(MoodAdded(mood1));
        bloc.add(MoodAdded(mood2));
        bloc.add(MoodDeleted(mood2));
      },
      expect: () => <MoodState>[
        MoodLoadInProgress(),
        MoodLoadSuccess([]),
        MoodLoadSuccess([mood1]),
        MoodLoadSuccess([mood1, mood2]),
        MoodLoadSuccess([mood1]),
      ],
    );

    blocTest<MoodBloc, MoodState>(
      'update mood entry',
      build: () {
        return moodBloc;
      },
      act: (MoodBloc bloc) async {
        bloc.add(AppStart());
        bloc.add(MoodAdded(mood1));
        bloc.add(MoodUpdated(mood1.copyWith(score: 7)));
      },
      expect: () => <MoodState>[
        MoodLoadInProgress(),
        MoodLoadSuccess([]),
        MoodLoadSuccess([mood1]),
        MoodLoadSuccess([mood1.copyWith(score: 7)]),
      ],
    );
  });
}
