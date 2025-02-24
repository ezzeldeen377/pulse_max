import 'package:pulse_max/features/measurement/data/models/measurement_model.dart';

abstract class MeasurementDataSource {
  /// Stream of measurement data
  Stream<MeasurementModel> getMeasurements();

  /// Stop listening to measurements
  void dispose();
}