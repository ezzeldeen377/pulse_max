import 'dart:convert';

import 'package:faker/faker.dart';
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
  final List<Map<String, dynamic>>? reviews;
  final List<String>? languagesSpoken;
  final double? consultationFee;
  final List<String>? servicesOffered;
  final List<String>? awardsAndCertifications;
  final Map<String, String>? socialMediaLinks;

  DoctorModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.createdAt,
    super.gender,
    super.type,
    super.profileImage,
    super.phoneNumber,
    this.specialization,
    this.qualification,
    this.licenseNumber,
    this.hospitalOrClinicName,
    this.yearsOfExperience,
    this.bio,
    this.availability,
    this.rating,
    this.reviews,
    this.languagesSpoken,
    this.consultationFee,
    this.servicesOffered,
    this.awardsAndCertifications,
    this.socialMediaLinks,
  });

factory DoctorModel.faker() {
  var faker = Faker();
  return DoctorModel(
    uid: faker.guid.guid(),
    email: faker.internet.email(),
    name: faker.person.name(),
    createdAt: faker.date.dateTime(),
    gender: faker.randomGenerator.element(['Male', 'Female']),
    type: faker.randomGenerator.element(['General Practitioner', 'Specialist']),
    profileImage: faker.image.loremPicsum(
          random: faker.randomGenerator.integer(
        400,
        min: 100,
      )),
    phoneNumber: faker.phoneNumber.us(),
    specialization: faker.job.title(),
    qualification: faker.guid.guid(),
    licenseNumber: faker.guid.guid(),
    hospitalOrClinicName: faker.company.name(),
    yearsOfExperience: faker.randomGenerator.integer(40, min: 1),
    bio: faker.lorem.sentence(),
    availability: {'Monday': '9:00-17:00', 'Tuesday': '9:00-17:00'},
    rating: faker.randomGenerator.decimal(min: 1, scale: 5),
    reviews: [
      {'reviewer': faker.person.name(), 'comment': faker.lorem.sentence()}
    ],
    languagesSpoken: faker.lorem.words(3).map((e) => e.toString()).toList(),
    consultationFee: faker.randomGenerator.decimal(min: 20, scale: 300),
    servicesOffered: faker.lorem.words(5).map((e) => e.toString()).toList(),
    awardsAndCertifications: faker.lorem.words(3).map((e) => e.toString()).toList(),
    socialMediaLinks: {'LinkedIn': faker.internet.httpsUrl()},
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
    List<Map<String, dynamic>>? reviews,
    List<String>? languagesSpoken,
    double? consultationFee,
    List<String>? servicesOffered,
    List<String>? awardsAndCertifications,
    Map<String, String>? socialMediaLinks,
  }) {
    return DoctorModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      specialization: specialization ?? this.specialization,
      qualification: qualification ?? this.qualification,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      hospitalOrClinicName: hospitalOrClinicName ?? this.hospitalOrClinicName,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      bio: bio ?? this.bio,
      availability: availability ?? this.availability,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      languagesSpoken: languagesSpoken ?? this.languagesSpoken,
      consultationFee: consultationFee ?? this.consultationFee,
      servicesOffered: servicesOffered ?? this.servicesOffered,
      awardsAndCertifications: awardsAndCertifications ?? this.awardsAndCertifications,
      socialMediaLinks: socialMediaLinks ?? this.socialMediaLinks,
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
      'languagesSpoken': languagesSpoken,
      'consultationFee': consultationFee,
      'servicesOffered': servicesOffered,
      'awardsAndCertifications': awardsAndCertifications,
      'socialMediaLinks': socialMediaLinks,
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
      profileImage: map['profileImage'] != null ? map['profileImage'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
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
      reviews: map['reviews'] != null
          ? List<Map<String, dynamic>>.from(map['reviews'])
          : null,
      languagesSpoken: map['languagesSpoken'] != null
          ? List<String>.from(map['languagesSpoken'])
          : null,
      consultationFee: map['consultationFee'] as double?,
      servicesOffered: map['servicesOffered'] != null
          ? List<String>.from(map['servicesOffered'])
          : null,
      awardsAndCertifications: map['awardsAndCertifications'] != null
          ? List<String>.from(map['awardsAndCertifications'])
          : null,
      socialMediaLinks: map['socialMediaLinks'] != null
          ? Map<String, String>.from(map['socialMediaLinks'])
          : null,
    );
  }

  // @override
  // String toJson() => json.encode(toMap());

  // factory DoctorModel.fromJson(String source) =>
  //     DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Doctor('
        'uid: $uid, email: $email, name: $name, createdAt: $createdAt, type: $type, '
        'specialization: $specialization, qualification: $qualification, licenseNumber: $licenseNumber, '
        'hospitalOrClinicName: $hospitalOrClinicName, yearsOfExperience: $yearsOfExperience, bio: $bio, '
        'rating: $rating, languagesSpoken: $languagesSpoken, consultationFee: $consultationFee, '
        'servicesOffered: $servicesOffered, awardsAndCertifications: $awardsAndCertifications, '
        'socialMediaLinks: $socialMediaLinks)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return super == other &&
        other.specialization == specialization &&
        other.qualification == qualification &&
        other.licenseNumber == licenseNumber &&
        other.hospitalOrClinicName == hospitalOrClinicName &&
        other.yearsOfExperience == yearsOfExperience &&
        other.bio == bio &&
        other.availability == availability &&
        other.rating == rating &&
        other.reviews == reviews &&
        other.languagesSpoken == languagesSpoken &&
        other.consultationFee == consultationFee &&
        other.servicesOffered == servicesOffered &&
        other.awardsAndCertifications == awardsAndCertifications &&
        other.socialMediaLinks == socialMediaLinks;
  }

  @override
  int get hashCode {
    return super.hashCode ^
        specialization.hashCode ^
        qualification.hashCode ^
        licenseNumber.hashCode ^
        hospitalOrClinicName.hashCode ^
        yearsOfExperience.hashCode ^
        bio.hashCode ^
        availability.hashCode ^
        rating.hashCode ^
        reviews.hashCode ^
        languagesSpoken.hashCode ^
        consultationFee.hashCode ^
        servicesOffered.hashCode ^
        awardsAndCertifications.hashCode ^
        socialMediaLinks.hashCode;
  }
}
