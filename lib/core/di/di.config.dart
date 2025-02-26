// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/alarm/data/datasources/medicine_data_source.dart'
    as _i867;
import '../../features/alarm/data/repositories/medicine_repository.dart'
    as _i946;
import '../../features/alarm/presentation/cubit/medicine_cubit.dart' as _i526;
import '../../features/ask_ai/data/data_source/ask_ai_data_source.dart'
    as _i633;
import '../../features/ask_ai/data/repository/ask_ai_repository.dart' as _i235;
import '../../features/ask_ai/presentation/cubit/ask_ai_cubit.dart' as _i958;
import '../../features/authentication/data/data_source/auth_remote_data_source.dart'
    as _i21;
import '../../features/authentication/data/repositories/auth_repository.dart'
    as _i935;
import '../../features/authentication/presentation/cubits/sign_in_cubit/sign_in_cubit.dart'
    as _i670;
import '../../features/authentication/presentation/cubits/sign_in_cubit/sign_in_view_model.dart'
    as _i361;
import '../../features/authentication/presentation/cubits/sign_up_cubit/sign_up_cubit.dart'
    as _i531;
import '../../features/authentication/presentation/cubits/sign_up_cubit/sign_up_view_model.dart'
    as _i22;
import '../../features/doctor/data/data_sources/doctor_remote_data_source.dart'
    as _i337;
import '../../features/doctor/data/repositories/doctor_repository_impl.dart'
    as _i596;
import '../../features/doctor/domain/repository/doctor_repository.dart'
    as _i849;
import '../../features/doctor/domain/usecases/create_doctor.dart' as _i2;
import '../../features/doctor/domain/usecases/get_doctors.dart' as _i522;
import '../../features/doctor/domain/usecases/start_chat_with_doctor.dart'
    as _i432;
import '../../features/doctor/domain/usecases/update_doctor.dart' as _i959;
import '../../features/doctor/presentation/bloc/bloc/edit_doctor_bloc.dart'
    as _i985;
import '../../features/doctor/presentation/bloc/doctors/doctors_cubit.dart'
    as _i871;
import '../../features/measurement/data/datasources/measurement_data_source.dart'
    as _i173;
import '../../features/measurement/data/datasources/measurement_data_source_impl.dart'
    as _i1;
import '../../features/measurement/data/repositories/measurement_repository.dart'
    as _i900;
import '../../features/measurement/data/repositories/measurement_repository_impl.dart'
    as _i959;
import '../../features/measurement/presentation/cubit/measurement_cubit.dart'
    as _i730;
import '../../features/message/data/data_sources/message_remote_data_source.dart'
    as _i110;
import '../../features/message/data/repositories/message_repository.dart'
    as _i684;
import '../../features/message/presentation/cubits/chats_cubit.dart' as _i933;
import '../common/cubit/app_user/app_user_cubit.dart' as _i94;
import '../network/network_info.dart' as _i932;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i361.SignInViewModel>(() => _i361.SignInViewModel());
    gh.factory<_i22.SignUpViewModel>(() => _i22.SignUpViewModel());
    gh.factory<_i21.AuthRemoteDataSource>(
        () => _i21.AuthRemoteDataSourceImpl());
    gh.factory<_i110.MessageRemoteDataSource>(
        () => _i110.MessageRemoteDataSourceImpl());
    gh.factory<_i337.DoctorRemoteDataSource>(
        () => _i337.DoctorRemoteDataSourceImpl());
    gh.factory<_i633.AskAiDataSource>(() => _i633.AskAiDataSourceImpl());
    gh.factory<_i867.MedicineDataSource>(() => _i867.MedicineDataSourceImpl());
    gh.factory<_i932.NetworkInfo>(() => _i932.NetworkInfoImpl());
    gh.factory<_i849.DoctorRepository>(() => _i596.DoctorRepositoryImpl(
          doctorRemoteDataSource: gh<_i337.DoctorRemoteDataSource>(),
          networkInfo: gh<_i932.NetworkInfo>(),
        ));
    gh.factory<_i985.DoctorBloc>(
        () => _i985.DoctorBloc(repository: gh<_i849.DoctorRepository>()));
    gh.factory<_i173.MeasurementDataSource>(
        () => _i1.MeasurementDataSourceImpl());
    gh.factory<_i935.AuthRepository>(() => _i935.AuthRepositoryImpl(
        authDataSource: gh<_i21.AuthRemoteDataSource>()));
    gh.factory<_i531.SignUpCubit>(() => _i531.SignUpCubit(
          authRepository: gh<_i935.AuthRepository>(),
          signUpViewModel: gh<_i22.SignUpViewModel>(),
        ));
    gh.factory<_i235.AskAiRepository>(
        () => _i235.AskAiRepositoryImpl(gh<_i633.AskAiDataSource>()));
    gh.factory<_i670.SignInCubit>(() => _i670.SignInCubit(
          authRepository: gh<_i935.AuthRepository>(),
          signInViewModel: gh<_i361.SignInViewModel>(),
        ));
    gh.factory<_i684.MessageRepository>(() => _i684.MessageRepositoryImpl(
        dataSource: gh<_i110.MessageRemoteDataSource>()));
    gh.factory<_i900.MeasurementRepository>(() =>
        _i959.MeasurementRepositoryImpl(gh<_i173.MeasurementDataSource>()));
    gh.factory<_i946.MedicineRepository>(
        () => _i946.MedicineRepositoryImpl(gh<_i867.MedicineDataSource>()));
    gh.factory<_i94.AppUserCubit>(
        () => _i94.AppUserCubit(authRepository: gh<_i935.AuthRepository>()));
    gh.factory<_i432.StartChatWithDoctor>(() =>
        _i432.StartChatWithDoctor(repository: gh<_i684.MessageRepository>()));
    gh.factory<_i2.CreateDoctor>(
        () => _i2.CreateDoctor(doctorRepository: gh<_i849.DoctorRepository>()));
    gh.factory<_i522.GetDoctors>(
        () => _i522.GetDoctors(doctorRepository: gh<_i849.DoctorRepository>()));
    gh.factory<_i959.UpdateDoctor>(() =>
        _i959.UpdateDoctor(doctorRepository: gh<_i849.DoctorRepository>()));
    gh.factory<_i871.DoctorsCubit>(() => _i871.DoctorsCubit(
          getDoctors: gh<_i522.GetDoctors>(),
          updateDoctor: gh<_i959.UpdateDoctor>(),
          createDoctor: gh<_i2.CreateDoctor>(),
          startChatWithDoctor: gh<_i432.StartChatWithDoctor>(),
          repository: gh<_i849.DoctorRepository>(),
        ));
    gh.factory<_i933.ChatsCubit>(() =>
        _i933.ChatsCubit(messageRepository: gh<_i684.MessageRepository>()));
    gh.factory<_i958.AskAiCubit>(
        () => _i958.AskAiCubit(repository: gh<_i235.AskAiRepository>()));
    gh.factory<_i730.MeasurementCubit>(
        () => _i730.MeasurementCubit(gh<_i900.MeasurementRepository>()));
    gh.factory<_i526.MedicineCubit>(
        () => _i526.MedicineCubit(repository: gh<_i946.MedicineRepository>()));
    return this;
  }
}
