import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final DateTime? birthDate;
  @HiveField(2)
  final String? location;

  User({
    required this.name,
    this.birthDate,
    this.location,
  });

  User copyWith({
    String? name,
    DateTime? birthDate,
    String? location,
  }) {
    return User(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birthDate': birthDate?.millisecondsSinceEpoch ?? '',
      'location': location ?? '',
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      birthDate: DateTime.fromMillisecondsSinceEpoch(map['birthDate']),
      location: map['location'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, birthDate, location];
}
