import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moody/data/constants/hive.dart';
import 'package:moody/data/models/mood.dart';

Future<void> initializeHiveDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoodAdapter());
  await Hive.openBox<Mood>(MoodBoxKey);
}
