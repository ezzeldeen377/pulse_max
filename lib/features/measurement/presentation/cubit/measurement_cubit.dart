import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/measurement/data/models/measurement_model.dart';
import 'package:pulse_max/features/measurement/data/repositories/measurement_repository.dart';

part 'measurement_state.dart';
@injectable
class MeasurementCubit extends Cubit<MeasurementState> {
  final MeasurementRepository _repository;
  StreamSubscription<MeasurementModel>? _measurementSubscription;

  MeasurementCubit(this._repository) : super(MeasurementState.initial());

  void startMeasuring() {
    emit(MeasurementState.loading());
    _measurementSubscription = _repository.getMeasurements().listen(
      (measurement) {
        emit(MeasurementState.success(measurement));
      },
      onError: (error) {
        emit(MeasurementState.error(error.toString()));
      },
    );

 
  }
     @override
    Future<void> close() {
      _measurementSubscription?.cancel();
      _repository.dispose();
      return super.close();
    }
}
