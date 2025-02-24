import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:pulse_max/features/alarm/data/datasources/medicine_data_source.dart';
import 'package:pulse_max/features/alarm/data/models/medicine.dart';

abstract class MedicineRepository {
  Future<Either<String, Unit>> saveMedicine(Medicine medicine);
  Stream<Either<String, List<Medicine>>> getMedicines();
  Future<Either<String, Unit>> removeMedicine(int medicineId);
  Future<Either<String, Unit>> removeAllMedicines();
  Future<Either<String, Unit>> updateMedicine(Medicine medicine);
}
@Injectable(as: MedicineRepository)
class MedicineRepositoryImpl implements MedicineRepository {
  final MedicineDataSource _dataSource;

  MedicineRepositoryImpl(this._dataSource);

  @override
  Future<Either<String, Unit>> saveMedicine(Medicine medicine) async {
    try {
      await _dataSource.storeMedicine(medicine);
      return Right(unit);
    } catch (e) {
      return Left('Failed to save medicine: $e');
    }
  }

  @override
Stream<Either<String, List<Medicine>>> getMedicines() async* {
  try {
    await for (final medicines in _dataSource.listMedicines()) {
      yield Right(medicines);
    }
  } catch (e) {
    yield Left('Failed to get medicines: $e');
  }
}



  @override
  Future<Either<String, Unit>> removeMedicine(int medicineId) async {
    try {
      await _dataSource.deleteMedicine(medicineId);
      return Right(unit);
    } catch (e) {
      return Left('Failed to remove medicine: $e');
    }
  }

  @override
  Future<Either<String, Unit>> removeAllMedicines() async {
    try {
      await _dataSource.deleteAllMedicines();
      return Right(unit);
    } catch (e) {
      return Left('Failed to remove all medicines: $e');
    }
  }

  @override
  Future<Either<String, Unit>> updateMedicine(Medicine medicine) async {
    try {
      await _dataSource.updateMedicine(medicine);
      return Right(unit);
    } catch (e) {
      return Left('Failed to update medicine: $e');
    }
  }
}