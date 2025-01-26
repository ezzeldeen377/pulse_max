import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
import 'package:pulse_max/features/doctor/domain/usecases/create_doctor.dart';
import 'package:pulse_max/features/doctor/domain/usecases/doctors_stream.dart';
import 'package:pulse_max/features/doctor/domain/usecases/get_doctors.dart';
import 'package:pulse_max/features/doctor/domain/usecases/start_chat_with_doctor.dart';
import 'package:pulse_max/features/doctor/domain/usecases/update_doctor.dart';
import 'package:pulse_max/features/doctor/presentation/providers/doctors_state.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';


@injectable
class DoctorsCubit extends Cubit<DoctorsState> {
  final GetDoctors getDoctors;
  final UpdateDoctor updateDoctor;
  final CreateDoctor createDoctor;
  final DoctorsStream doctorsStream;
  final StartChatWithDoctor startChatWithDoctor;

  DoctorsCubit({
    required this.getDoctors,
    required this.updateDoctor,
    required this.createDoctor,
    required this.doctorsStream,
    required this.startChatWithDoctor
  }) : super(DoctorsState(status: DoctorsStatus.initial)) {
    getDoctors().then((failureOrDoctors) {
      failureOrDoctors.fold((failure) {}, (doctors) {
        emit(state.copyWith(status: DoctorsStatus.success,doctors: doctors));
      });
    });

    doctorsStream.listen((doctors) {
      emit(state.copyWith(status: DoctorsStatus.success,doctors: doctors));
    });
  }

  create(Doctor doctor) async {
    final failureOrUnit = await createDoctor(doctor);
    failureOrUnit.fold((failure) {}, (_) {
      emit(state.copyWith(status: DoctorsStatus.success,doctors: [...state.doctors!, doctor]));
    });

  }

  update(Doctor doctor) async {
    await updateDoctor(doctor);
  }

  Future<ChatModel?> startChat(ChatModel chat) async{
    final response = await startChatWithDoctor(chat);
    return response.fold((l) =>null, (r) => r); 
  }

  @override
  Future<void> close() {
    return super.close();
  }
}


