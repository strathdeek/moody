import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'mood.g.dart';

@HiveType(typeId: 0)
class Mood extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final double score;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final String? imagePath;

  Mood({id, required this.score, date, imagePath})
      : id = id ?? Uuid().v4(),
        date = date ?? DateTime.now(),
        imagePath = imagePath;

  Mood copyWith({
    String? id,
    double? score,
    DateTime? date,
  }) {
    return Mood(
      id: id ?? this.id,
      score: score ?? this.score,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'date': date.millisecondsSinceEpoch,
      'imagePath': imagePath
    };
  }

  factory Mood.fromMap(Map<String, dynamic> map) {
    return Mood(
        id: map['id'],
        score: map['score'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        imagePath: map['imagePath']);
  }

  String toJson() => json.encode(toMap());

  factory Mood.fromJson(String source) => Mood.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, score, date, imagePath!];
}
