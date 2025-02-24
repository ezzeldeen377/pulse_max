import 'package:pulse_max/features/measurement/data/models/measurement_model.dart';

abstract class MeasurementRepository {
  /// Get stream of measurements
  Stream<MeasurementModel> getMeasurements();

  /// Clean up resources
  void dispose();
}