import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/alarm/data/models/medicine.dart';
import 'package:pulse_max/features/alarm/data/repositories/medicine_repository.dart';
import 'package:uuid/uuid.dart';

import 'medicine_state.dart';

@injectable
class MedicineCubit extends Cubit<MedicineState> {
  MedicineRepository repository;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  MedicineCubit({
    required this.repository,
  }) : super(const MedicineState(status: MedicineStatus.initial));
  void changeFrequency(String frequency) {
    emit(state.copyWith(selectedFrequency: frequency));
  }

  void addTimeToList(DateTime time) {
    final currentTimes = List<DateTime>.from(state.timeList ?? []);
    if (!currentTimes.contains(time)) {
      currentTimes.add(time);
      emit(state.copyWith(timeList: currentTimes));
    }
  }

  void removeTimeFromList(DateTime time) {
    final currentTimes = List<DateTime>.from(state.timeList ?? []);
    currentTimes.remove(time);
    emit(state.copyWith(timeList: currentTimes));
  }

  Future<void> getMedicines() async {
    emit(state.copyWith(status: MedicineStatus.loading));

    try {
      repository.getMedicines().listen(
        (result) {
          result.fold(
            (failure) => emit(state.copyWith(
              status: MedicineStatus.error,
              errorMessage: failure,
            )),
            (medicines) => emit(state.copyWith(
              status: MedicineStatus.success,
              medicines: medicines,
            )),
          );
        },
        onError: (error) {
          emit(state.copyWith(
            status: MedicineStatus.error,
            errorMessage: error.toString(),
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: MedicineStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addMedicine(Medicine medicine) async {
    emit(state.copyWith(status: MedicineStatus.loading));
    try {
      final result = await repository.saveMedicine(medicine);
      result.fold(
        (failure) => emit(state.copyWith(
          status: MedicineStatus.error,
          errorMessage: failure,
        )),
        (_) => getMedicines(),
      );
    } catch (e) {
      emit(state.copyWith(
        status: MedicineStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateMedicine(Medicine medicine) async {
    emit(state.copyWith(status: MedicineStatus.loading));
    try {
      final result = await repository.updateMedicine(medicine);
      result.fold(
        (failure) => emit(state.copyWith(
          status: MedicineStatus.error,
          errorMessage: failure,
        )),
        (_) => getMedicines(),
      );
    } catch (e) {
      emit(state.copyWith(
        status: MedicineStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteMedicine(int medicineId) async {
    emit(state.copyWith(status: MedicineStatus.loading));
    try {
      final result = await repository.removeMedicine(medicineId);
      result.fold(
        (failure) => emit(state.copyWith(
          status: MedicineStatus.error,
          errorMessage: failure,
        )),
        (_) {
         getMedicines();
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: MedicineStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void selectMedicine(Medicine medicine) {
    emit(state.copyWith(selectedMedicine: medicine));
  }

  void clearSelectedMedicine() {
    emit(state.copyWith(selectedMedicine: null));
  }

  Medicine? createMedicine() {
    var uuid = const Uuid().v4();
    int hashedId = uuid.hashCode.abs();
    
    // Validate required fields
    if (nameController.text.isEmpty) {
      emit(state.copyWith(
        status: MedicineStatus.empty,
        errorMessage: 'Please enter medicine name',
      ));
      return null;
    }
    
    if (dosageController.text.isEmpty) {
      emit(state.copyWith(
        status: MedicineStatus.empty,
        errorMessage: 'Please enter dosage',
      ));
      return null;
    }

    if (state.timeList == null || state.timeList!.isEmpty) {
      emit(state.copyWith(
        status: MedicineStatus.empty,
        errorMessage: 'Please select at least one time',
      ));
      return null;
    }

    return Medicine(
      id: hashedId % 10000,
      name: nameController.text,
      dosage: dosageController.text,
      instructions: notesController.text,
      frequency: state.selectedFrequency ?? 'Once',
      time: state.timeList!.first,
      isEnabled: true,
    );
  }
}
