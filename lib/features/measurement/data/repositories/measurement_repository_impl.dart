import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/measurement/data/datasources/measurement_data_source.dart';
import 'package:pulse_max/features/measurement/data/models/measurement_model.dart';
import 'package:pulse_max/features/measurement/data/repositories/measurement_repository.dart';
@Injectable(as: MeasurementRepository)
class MeasurementRepositoryImpl implements MeasurementRepository {
  final MeasurementDataSource _dataSource;

  MeasurementRepositoryImpl(this._dataSource);

  @override
  Stream<MeasurementModel> getMeasurements() {
    return _dataSource.getMeasurements();
  }

  @override
  void dispose() {
    _dataSource.dispose();
  }
}