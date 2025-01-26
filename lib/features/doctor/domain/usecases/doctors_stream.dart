import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
import 'package:pulse_max/features/doctor/domain/repository/doctor_repository.dart';
@injectable
class DoctorsStream {
  final DoctorRepository doctorRepository;

  DoctorsStream({required this.doctorRepository});

  void listen(Function(List<Doctor>) callback) {
    return doctorRepository.listen(callback);
  }
}
