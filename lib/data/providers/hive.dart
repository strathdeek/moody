import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moody/data/constants/hive.dart';
import 'package:moody/data/models/mood.dart';
import 'package:moody/data/models/user.dart';

Future<void> initializeHiveDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoodAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<Mood>(MoodBoxKey);
  await Hive.openBox<User>(UserBoxKey);
}
