import 'package:dartz/dartz.dart';
import 'package:pulse_max/core/errors/failures/failure.dart';
import 'package:pulse_max/features/doctor/data/models/appointment_model.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorModel>>> getDoctorList(String? category);
  Future<Either<Failure, Unit>> createDoctor(DoctorModel doctor);
  Future<Either<Failure, Unit>> updateDoctor(DoctorModel doctor);
  Future<Either<Failure, Unit>> createAppointment(AppointmentModel app);
}
