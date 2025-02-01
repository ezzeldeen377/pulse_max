import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/domain/repository/doctor_repository.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/bloc/edit_doctor_event.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/bloc/edit_doctor_state.dart';

@injectable
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController specializationController;
  late TextEditingController qualificationController;
  late TextEditingController licenseNumberController;
  late TextEditingController hospitalOrClinicNameController;
  late TextEditingController yearsOfExperienceController;
  late TextEditingController bioController;
  late TextEditingController consultationFeeController;

  // Form key for validation
  final formKey = GlobalKey<FormState>();
  DoctorRepository repository;
  DoctorBloc({required this.repository})
      : super(DoctorState(status: DoctorStatus.initial)) {
    on<UpdateDoctor>((event, emit) => emit(state.copyWith(status: DoctorStatus.update, doctor: event.doctor)));
    on<SaveDoctor>((event, emit) async {
      if (formKey.currentState!.validate()) {
        emit(state.copyWith(status: DoctorStatus.loading));
       final result=await repository.createDoctor(state.doctor!);
       result.fold((error)=>emit(state.copyWith(status: DoctorStatus.error)),(ifRight)=>emit(state.copyWith(status: DoctorStatus.success)));
      }
    });
  }
   void initState(DoctorModel doctor) {
    // Initialize controllers with provided values
    emit(DoctorState(status: DoctorStatus.update, doctor: doctor));
    nameController = TextEditingController(text: state.doctor?.name??'');
    emailController = TextEditingController(text: state.doctor?.email??'');
    phoneNumberController = TextEditingController(text: state.doctor?.phoneNumber??'');
    specializationController = TextEditingController(text: state.doctor?.specialization??'');
    qualificationController = TextEditingController(text: state.doctor?.qualification??'');
    licenseNumberController = TextEditingController(text: state.doctor?.licenseNumber??'');
    hospitalOrClinicNameController = TextEditingController(text: state.doctor?.hospitalOrClinicName??'');
    yearsOfExperienceController = TextEditingController(text: state.doctor?.yearsOfExperience?.toString()??'');
    bioController = TextEditingController(text: state.doctor?.bio??'');
    consultationFeeController = TextEditingController(text: state.doctor?.consultationFee?.toString()??'');
  }
@override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    specializationController.dispose();
    qualificationController.dispose();
    licenseNumberController.dispose();
    hospitalOrClinicNameController.dispose();
    yearsOfExperienceController.dispose();
    bioController.dispose();
    consultationFeeController.dispose();
    
   return super.close();
  }
}