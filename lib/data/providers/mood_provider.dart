import 'dart:io';

import 'package:csv/csv.dart';
import 'package:hive/hive.dart';
import 'package:moody/data/constants/hive.dart';
import 'package:moody/data/models/mood.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
    rows.insert(0, ['Time', 'Mood']);
    var csv = ListToCsvConverter().convert(rows);

    if (!await Permission.storage.request().isGranted) {
      return;
    }

    final directory = await getExternalStorageDirectory();
    if (directory == null) return;
    var file = File(
        '${directory.path}/moody_export_${DateTime.now().millisecondsSinceEpoch.toString()}.csv');
    await file.create(recursive: true);
    await file.writeAsString(csv);
  }
}

mixin PermissionGroup {}
