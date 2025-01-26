import 'package:faker/faker.dart';

class Doctor {
  String? name;
  String? specialization;
  String? id;
  String? imageUrl;
  String? phoneNumber;
  Gender? gender;
  DateTime? dateOfBirth;
  String? email;

   Doctor({
    required this.name,
    required this.specialization,
    required this.id,
    required this.imageUrl,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
    required this.email,
  });

  @override
  String toString() {
    return 'Doctor(name: $name, specialization: $specialization, id: $id, imageUrl: $imageUrl, phoneNumber: $phoneNumber, gender: $gender)';
  }

  factory Doctor.fake() {
    final faker = Faker();

    return Doctor(
      name: faker.person.name(),
      specialization: faker.job.title(),
      id: faker.guid.guid(),
      imageUrl: faker.image.loremPicsum(
          random: faker.randomGenerator.integer(
        400,
        min: 100,
      )),
      phoneNumber: faker.phoneNumber.us(),
      gender: faker.randomGenerator.element(Gender.values),
      dateOfBirth: DateTime.now(),
      email: faker.internet.email(),
    );
  }
}

enum Gender { male, female }
