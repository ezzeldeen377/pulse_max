// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:pulse_max/features/alarm/data/models/medicine.dart';

enum MedicineStatus {
  initial,
  loading,
  success,
  error,
  empty
}

extension MedicineStateExtension on MedicineState {
  bool get isLoading => status == MedicineStatus.loading;
  bool get isSuccess => status == MedicineStatus.success;
  bool get isError => status == MedicineStatus.error;
  bool get isEmpty => status == MedicineStatus.empty;
  bool get isInitial => status == MedicineStatus.initial;
}

class MedicineState {
  final MedicineStatus status;
  final List<Medicine>? medicines;
  final Medicine? selectedMedicine;
  final String? selectedFrequency;
  final String? errorMessage;
  final List<DateTime>? timeList;

  const MedicineState({
    required this.status,
    this.medicines,
    this.selectedMedicine,
    this.selectedFrequency,
    this.errorMessage,
     this.timeList,
  });

  MedicineState copyWith({
    MedicineStatus? status,
    List<Medicine>? medicines,
    Medicine? selectedMedicine,
    String? selectedFrequency,
    String? errorMessage,
    List<DateTime>? timeList,
  }) {
    return MedicineState(
      status: status ?? this.status,
      medicines: medicines ?? this.medicines,
      selectedMedicine: selectedMedicine ?? this.selectedMedicine,
      selectedFrequency: selectedFrequency ?? this.selectedFrequency,
      errorMessage: errorMessage ?? this.errorMessage,
      timeList: timeList ?? this.timeList,
    );
  }



  @override
  String toString() {
    return 'MedicineState(status: $status, medicines: $medicines, selectedMedicine: $selectedMedicine, selectedFrequency: $selectedFrequency, errorMessage: $errorMessage, timeList: $timeList)';
  }
}
