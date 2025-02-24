// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'measurement_cubit.dart';

enum MeasurementStatus {
  initial,
  loading,
  error,
  success
}

extension MeasurementStateX on MeasurementStatus {
  bool get isInitial => this == MeasurementStatus.initial;
  bool get isLoading => this == MeasurementStatus.loading;
  bool get isError => this == MeasurementStatus.error;
  bool get isSuccess => this == MeasurementStatus.success;
}

class MeasurementState {
  final MeasurementStatus status;
  final String? errorMessage;
  final MeasurementModel? measurement;

  const MeasurementState({
    required this.status,
    this.errorMessage,
    this.measurement,
  });

  factory MeasurementState.initial() => const MeasurementState(status: MeasurementStatus.initial);
  
  factory MeasurementState.loading() => const MeasurementState(status: MeasurementStatus.loading);
  
  factory MeasurementState.error(String message) => MeasurementState(
    status: MeasurementStatus.error,
    errorMessage: message
  );
  
  factory MeasurementState.success(MeasurementModel measurement) => MeasurementState(
    status: MeasurementStatus.success,
    measurement: measurement
  );

  MeasurementState copyWith({
    MeasurementStatus? status,
    String? errorMessage,
    MeasurementModel? measurement,
  }) {
    return MeasurementState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      measurement: measurement ?? this.measurement,
    );
  }

  @override
  String toString() => 'MeasurementState(status: $status, errorMessage: $errorMessage, measurement: $measurement)';
}