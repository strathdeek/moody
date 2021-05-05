import 'dart:io';

import 'package:csv/csv.dart';
import 'package:hive/hive.dart';
import 'package:moody/data/constants/hive.dart';
import 'package:moody/data/models/mood.dart';
import 'package:path_provider/path_provider.dart';

class MoodProvider {
  final Box<Mood> _moodBox = Hive.box(MoodBoxKey);

  void add(Mood mood) {
    _moodBox.put(mood.id, mood);
  }

  void update(Mood mood) {
    _moodBox.put(mood.id, mood);
  }

  void delete(Mood mood) {
    _moodBox.delete(mood.id);
  }

  List<Mood> get() {
    var moodEntries = _moodBox.values.toList();
    return moodEntries;
  }

  void export() async {
    var entries = get();
    var rows = List.generate(
      entries.length,
      (index) {
        return entries[index].toValueList();
      },
    );
    var csv = ListToCsvConverter().convert(rows);

    final directory = await getApplicationDocumentsDirectory();
    var file = File(
        '${directory.path}/moody_export_${DateTime.now().millisecondsSinceEpoch.toString()}.csv');
    await file.writeAsString(csv);
  }
}
