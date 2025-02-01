

import 'package:pulse_max/features/doctor/data/models/doctor.dart';

abstract class DoctorEvent {}

class UpdateDoctor extends DoctorEvent {
  final DoctorModel doctor;
  UpdateDoctor(this.doctor);
}

class SaveDoctor extends DoctorEvent {}