// ignore_for_file: public_member_api_docs, sort_constructors_first




import 'package:pulse_max/features/doctor/data/models/doctor.dart';
 enum DoctorStatus { initial, loading, success, error,update }
 
extension DoctorStateExtension on DoctorState {
  bool get isLoading => status == DoctorStatus.loading;
  bool get isSuccess => status == DoctorStatus.success;
  bool get isError => status == DoctorStatus.error;
  bool get isInitial => status == DoctorStatus.initial;
  bool get isUpdate=> status ==DoctorStatus.update;
}
class DoctorState {
  final DoctorStatus status;
  final DoctorModel? doctor;
  DoctorState({
    required this.status,
    this.doctor,
});

  DoctorState copyWith({
    DoctorStatus? status,
    DoctorModel? doctor,
  }) {
    return DoctorState(
      status: status ?? this.status,
      doctor: doctor ?? this.doctor,
    );
  }
}
