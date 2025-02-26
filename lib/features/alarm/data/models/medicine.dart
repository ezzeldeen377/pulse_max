// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'medicine.g.dart';
@HiveType(typeId: 0)
class Medicine {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String dosage;

  @HiveField(3)
  String instructions;

  @HiveField(4)
  DateTime time;

  @HiveField(5)
  String frequency;

  @HiveField(6)
  bool isEnabled;
  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.instructions,
    required this.time,
    required this.frequency,
    required this.isEnabled,
  });

  Medicine copyWith({
    int? id,
    String? name,
    String? dosage,
    String? instructions,
    DateTime? time,
    String? frequency,
    bool? isEnabled,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      instructions: instructions ?? this.instructions,
      time: time ?? this.time,
      frequency: frequency ?? this.frequency,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'dosage': dosage,
      'instructions': instructions,
      'time': time.millisecondsSinceEpoch,
      'frequency': frequency,
      'isEnabled': isEnabled,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'] as int,
      name: map['name'] as String,
      dosage: map['dosage'] as String,
      instructions: map['instructions'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      frequency: map['frequency'] as String,
      isEnabled: map['isEnabled'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Medicine.fromJson(String source) => Medicine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Medicine(id: $id, name: $name, dosage: $dosage, instructions: $instructions, time: $time, frequency: $frequency, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(covariant Medicine other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.dosage == dosage &&
      other.instructions == instructions &&
      other.time == time &&
      other.frequency == frequency &&
      other.isEnabled == isEnabled;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      dosage.hashCode ^
      instructions.hashCode ^
      time.hashCode ^
      frequency.hashCode ^
      isEnabled.hashCode;
  }
}
