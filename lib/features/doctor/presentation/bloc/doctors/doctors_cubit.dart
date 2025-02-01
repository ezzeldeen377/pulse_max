import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/doctor/data/models/appointment_model.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/domain/repository/doctor_repository.dart';
import 'package:pulse_max/features/doctor/domain/usecases/create_doctor.dart';
import 'package:pulse_max/features/doctor/domain/usecases/get_doctors.dart';
import 'package:pulse_max/features/doctor/domain/usecases/start_chat_with_doctor.dart';
import 'package:pulse_max/features/doctor/domain/usecases/update_doctor.dart';
import 'package:pulse_max/features/doctor/presentation/bloc/doctors/doctors_state.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';

@injectable
class DoctorsCubit extends Cubit<DoctorsState> {
  final GetDoctors getDoctors;
  final UpdateDoctor updateDoctor;
  final CreateDoctor createDoctor;
  final StartChatWithDoctor startChatWithDoctor;
  final DoctorRepository repository;

  DoctorsCubit(
      {required this.getDoctors,
      required this.updateDoctor,
      required this.createDoctor,
      required this.startChatWithDoctor,
      required this.repository})
      : super(DoctorsState(status: DoctorsStatus.initial));

  Future<void> getDoctorss(String? category) async {
    emit(state.copyWith(status: DoctorsStatus.loading));
    final result = await getDoctors.call(category);
    result.fold(
        (l) => emit(state.copyWith(
              status: DoctorsStatus.error,
            )),
        (r) => emit(state.copyWith(status: DoctorsStatus.success, doctors: r,category: category)));
  }

  create(DoctorModel doctor) async {
    final failureOrUnit = await createDoctor(doctor);
    failureOrUnit.fold((failure) {}, (_) {
      emit(state.copyWith(
          status: DoctorsStatus.success,   ));
    });
  }

  update(DoctorModel doctor) async {
    await updateDoctor(doctor);
  }

  Future<ChatModel?> startChat(ChatModel chat) async {
    final response = await startChatWithDoctor(chat);
    return response.fold((l) => null, (r) => r);
  }

  createAppointment(AppointmentModel app) async {
    final failureOrUnit = await repository.createAppointment(app);
    failureOrUnit.fold((failure) {
      emit(state.copyWith(status: DoctorsStatus.error));
    }, (_) {
      emit(state.copyWith(
        status: DoctorsStatus.picked,
      ));
    });
  }
}
