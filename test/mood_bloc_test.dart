import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moody/bloc/mood/mood_bloc.dart';
import 'package:moody/data/exceptions.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/data/repositories/mood_repository.dart';
import 'mood_bloc_test.mocks.dart';

@GenerateMocks([MoodRepository])
void main() {
  group('mood bloc', () {
    late MoodBloc moodBloc;
    late MoodRepository moodRepository;

    setUp(() {
      moodRepository = MockMoodRepository();
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
  });
}
