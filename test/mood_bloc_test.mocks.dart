// Mocks generated by Mockito 5.0.5 from annotations
// in moody/test/mood_bloc_test.dart.
// Do not manually edit this file.

import 'package:mockito/mockito.dart' as _i1;
import 'package:moody/data/models/mood.dart' as _i3;
import 'package:moody/data/repositories/mood_repository.dart' as _i2;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [MoodRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoodRepository extends _i1.Mock implements _i2.MoodRepository {
  MockMoodRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void add(_i3.Mood? mood) =>
      super.noSuchMethod(Invocation.method(#add, [mood]),
          returnValueForMissingStub: null);
  @override
  void update(_i3.Mood? mood) =>
      super.noSuchMethod(Invocation.method(#update, [mood]),
          returnValueForMissingStub: null);
  @override
  void delete(_i3.Mood? mood) =>
      super.noSuchMethod(Invocation.method(#delete, [mood]),
          returnValueForMissingStub: null);
  @override
  List<_i3.Mood> get() => (super.noSuchMethod(Invocation.method(#get, []),
      returnValue: <_i3.Mood>[]) as List<_i3.Mood>);
}
