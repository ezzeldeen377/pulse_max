import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/core/errors/failures/failure.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
import 'package:pulse_max/features/doctor/domain/repository/doctor_repository.dart';
@injectable
class UpdateDoctor {
  final DoctorRepository doctorRepository;

  UpdateDoctor({required this.doctorRepository});

  Future<Either<Failure, Unit>> call(Doctor doctor) async {
    return await doctorRepository.updateDoctor(doctor);
  }
}
