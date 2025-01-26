import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable()
class DoctorModel extends Doctor {
   DoctorModel({
    required super.name,
    required super.specialization,
    required super.id,
    required super.imageUrl,
    required super.phoneNumber,
    required super.gender,
    required super.dateOfBirth,
    required super.email,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) =>
      _$DoctorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorModelToJson(this);

  factory DoctorModel.fromEntity(Doctor doctor) {
    return DoctorModel(
      name: doctor.name,
      specialization: doctor.specialization,
      id: doctor.id,
      imageUrl: doctor.imageUrl,
      phoneNumber: doctor.phoneNumber,
      gender: doctor.gender,
      dateOfBirth: doctor.dateOfBirth,
      email: doctor.email,
    );
  }
}
