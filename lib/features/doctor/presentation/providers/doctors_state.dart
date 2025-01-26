// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';

enum DoctorsStatus{
  initial,
  loading,
  success,
  error,
  empty
}

extension DoctorsStateExtension on DoctorsState{
  bool get isLoading => status == DoctorsStatus.loading;
  bool get isSuccess => status == DoctorsStatus.success;
  bool get isError => status == DoctorsStatus.error;
  bool get isEmpty => status == DoctorsStatus.empty;
  bool get isInitial => status == DoctorsStatus.initial;
}
class DoctorsState {
  final DoctorsStatus status;
  final List<Doctor>? doctors;
  final String? errorMessage;
  DoctorsState({
    required this.status,
     this.doctors,
     this.errorMessage,
  });

  DoctorsState copyWith({
    DoctorsStatus? status,
    List<Doctor>? doctors,
    String? errorMessage,
  }) {
    return DoctorsState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
