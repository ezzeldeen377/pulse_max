import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/alarm/data/models/medicine.dart';

abstract class MedicineDataSource {
  Future<void> storeMedicine(Medicine medicine);
  Stream<List<Medicine>> listMedicines();
  Future<void> deleteMedicine(int medicineId);
  Future<void> deleteAllMedicines();
  Future<void> updateMedicine(Medicine medicine); // New method
}

@Injectable(as: MedicineDataSource)
class MedicineDataSourceImpl implements MedicineDataSource {
  Future<Box<Medicine>> get _medicineBox async =>
      await Hive.openBox<Medicine>('medicines');

  @override
  Future<void> storeMedicine(Medicine medicine) async {
    final box = await _medicineBox;
    await box.put(medicine.id, medicine);
    box.close();
  }

  @override
  Stream<List<Medicine>> listMedicines() async* {
    var box = await _medicineBox;
    final list = box.values.toList();
    list.sort((a, b) => a.time.compareTo(b.time));
    yield list; // Initial value

    box.watch().listen((_) async* {
      final list = box.values.toList();
      list.sort((a, b) => a.time.compareTo(b.time));
      yield list;
    });
  }

  @override
  Future<void> deleteMedicine(int medicineId) async {
    final box = await _medicineBox;
    await box.delete(medicineId);
    box.close();
  }

  @override
  Future<void> deleteAllMedicines() async {
    final box = await _medicineBox;
    await box.clear();
    box.close();
  }

  @override
  Future<void> updateMedicine(Medicine medicine) async {
    final box = await _medicineBox;
    if (box.containsKey(medicine.id)) {
      await box.put(medicine.id, medicine); // Update existing medicine
    }
    box.close();
  }
}
