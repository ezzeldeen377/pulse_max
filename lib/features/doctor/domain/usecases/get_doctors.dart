import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/core/errors/failures/failure.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/domain/repository/doctor_repository.dart';
@injectable
class GetDoctors {
  final DoctorRepository doctorRepository;

  GetDoctors({required this.doctorRepository});

  Future<Either<Failure, List<DoctorModel>>> call() async {
    return await doctorRepository.getDoctorList();
  }
}
