// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorModel _$DoctorModelFromJson(Map<String, dynamic> json) => DoctorModel(
      name: json['name'] as String?,
      specialization: json['specialization'] as String?,
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$DoctorModelToJson(DoctorModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'specialization': instance.specialization,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'phoneNumber': instance.phoneNumber,
      'gender': _$GenderEnumMap[instance.gender],
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'email': instance.email,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
