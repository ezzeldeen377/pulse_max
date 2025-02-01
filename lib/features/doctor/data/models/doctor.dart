// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

import 'package:pulse_max/core/common/entities/user_model.dart';

class DoctorModel extends UserModel {
  final String? specialization;
  final String? qualification;
  final String? licenseNumber;
  final String? hospitalOrClinicName;
  final int? yearsOfExperience;
  final String? bio;
  final Map<String, String>? availability;
  final double? rating;
  final int? reviews;
  final double? consultationFee;

  DoctorModel(
      {this.specialization,
      this.qualification,
      this.licenseNumber,
      this.hospitalOrClinicName,
      this.yearsOfExperience,
      this.bio,
      this.availability,
      this.rating,
      this.reviews,
      this.consultationFee,
      required super.uid,
      required super.email,
      required super.name,
      required super.createdAt,
      required super.type,
      super.gender,
      super.phoneNumber,
      super.profileImage});

  factory DoctorModel.faker() {
    var faker = Faker();
    return DoctorModel(
      uid: faker.guid.guid(),
      email: faker.internet.email(),
      name: faker.person.name(),
      createdAt: faker.date.dateTime(),
      gender: faker.randomGenerator.element(['Male', 'Female']),
      type: 'doctor',
      profileImage: faker.image.loremPicsum(
          random: faker.randomGenerator.integer(
        400,
        min: 100,
      )),
      phoneNumber: faker.phoneNumber.us(),
      specialization: faker.randomGenerator.element([
        
        "General",
        "Neurology",
        "Nutrition",
        "Dentist",
        "Pediatric",
        "Radiology",
        "Ophthalmology"
      ]),
      qualification: faker.guid.guid(),
      licenseNumber: faker.guid.guid(),
      hospitalOrClinicName: faker.company.name(),
yearsOfExperience: faker.randomGenerator.integer(10, min: 1),
      bio: faker.lorem.sentences(15).join(' '),
      availability: {'Monday': '9:00-17:00', 'Tuesday': '9:00-17:00'},
      rating: faker.randomGenerator.decimal(min: 1, scale: 5),
      reviews: faker.randomGenerator.integer(100, min: 1),
      consultationFee: faker.randomGenerator.decimal(min: 20, scale: 300),
    );
  }

  @override
  DoctorModel copyWith({
    String? uid,
    String? email,
    String? name,
    DateTime? createdAt,
    String? type,
    String? gender,
    String? profileImage,
    String? phoneNumber,
    String? specialization,
    String? qualification,
    String? licenseNumber,
    String? hospitalOrClinicName,
    int? yearsOfExperience,
    String? bio,
    Map<String, String>? availability,
    double? rating,
    int? reviews,
    double? consultationFee,
  }) {
    return DoctorModel(
      uid: uid ?? super.uid,
      email: email ?? super.email,
      createdAt: createdAt ?? super.createdAt,
      name: name ?? super.name,
      type: type ?? super.type,
      phoneNumber: phoneNumber ?? super.phoneNumber,
      profileImage: profileImage ?? super.profileImage,
      gender: gender ?? super.gender,
      specialization: specialization ?? this.specialization,
      qualification: qualification ?? this.qualification,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      hospitalOrClinicName: hospitalOrClinicName ?? this.hospitalOrClinicName,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      bio: bio ?? this.bio,
      availability: availability ?? this.availability,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      consultationFee: consultationFee ?? this.consultationFee,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'specialization': specialization,
      'qualification': qualification,
      'licenseNumber': licenseNumber,
      'hospitalOrClinicName': hospitalOrClinicName,
      'yearsOfExperience': yearsOfExperience,
      'bio': bio,
      'availability': availability,
      'rating': rating,
      'reviews': reviews,
      'consultationFee': consultationFee,
    });
    return map;
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      type: map['type'] != null ? map['type'] as String : null,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      specialization: map['specialization'] as String?,
      qualification: map['qualification'] as String?,
      licenseNumber: map['licenseNumber'] as String?,
      hospitalOrClinicName: map['hospitalOrClinicName'] as String?,
      yearsOfExperience: map['yearsOfExperience'] as int?,
      bio: map['bio'] as String?,
      availability: map['availability'] != null
          ? Map<String, String>.from(map['availability'])
          : null,
      rating: map['rating'] as double?,
      reviews: map['reviews'] as int?,
      consultationFee: map['consultationFee'] as double?,
    );
  }

  // @override
  // String toJson() => json.encode(toMap());

  // factory DoctorModel.fromJson(String source) =>
  //     DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(specialization: $specialization, qualification: $qualification, licenseNumber: $licenseNumber, hospitalOrClinicName: $hospitalOrClinicName, yearsOfExperience: $yearsOfExperience, bio: $bio, availability: $availability, rating: $rating, reviews: $reviews, consultationFee: $consultationFee)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return other.specialization == specialization &&
        other.qualification == qualification &&
        other.licenseNumber == licenseNumber &&
        other.hospitalOrClinicName == hospitalOrClinicName &&
        other.yearsOfExperience == yearsOfExperience &&
        other.bio == bio &&
        mapEquals(other.availability, availability) &&
        other.rating == rating &&
        other.reviews == reviews &&
        other.consultationFee == consultationFee;
  }

  @override
  int get hashCode {
    return specialization.hashCode ^
        qualification.hashCode ^
        licenseNumber.hashCode ^
        hospitalOrClinicName.hashCode ^
        yearsOfExperience.hashCode ^
        bio.hashCode ^
        availability.hashCode ^
        rating.hashCode ^
        reviews.hashCode ^
        consultationFee.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
