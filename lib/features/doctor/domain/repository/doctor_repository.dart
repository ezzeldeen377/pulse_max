import 'package:dartz/dartz.dart';
import 'package:pulse_max/core/errors/failures/failure.dart';
import 'package:pulse_max/features/doctor/data/models/doctor_model.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorModel>>> getDoctorList();
  Future<Either<Failure, Unit>> createDoctor(Doctor doctor);
  Future<Either<Failure, Unit>> updateDoctor(Doctor doctor);
}
