// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_data_source.dart' as _i970;
import '../../features/auth/data/repositories/auth_repository.dart' as _i573;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/doctor/data/data_sources/doctor_remote_data_source.dart'
    as _i337;
import '../../features/doctor/data/repositories/doctor_repository_impl.dart'
    as _i596;
import '../../features/doctor/domain/repository/doctor_repository.dart'
    as _i849;
import '../../features/doctor/domain/usecases/create_doctor.dart' as _i2;
import '../../features/doctor/domain/usecases/doctors_stream.dart' as _i43;
import '../../features/doctor/domain/usecases/get_doctors.dart' as _i522;
import '../../features/doctor/domain/usecases/start_chat_with_doctor.dart'
    as _i432;
import '../../features/doctor/domain/usecases/update_doctor.dart' as _i959;
import '../../features/doctor/presentation/providers/doctors_cubit.dart'
    as _i154;
import '../../features/message/data/data_sources/message_remote_data_source.dart'
    as _i110;
import '../../features/message/data/repositories/message_repository.dart'
    as _i684;
import '../../features/message/presentation/cubits/chats_cubit.dart' as _i933;
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
    gh.factory<_i970.AuthDataSource>(() => _i970.AuthDataSourceImpl());
    gh.factory<_i110.MessageRemoteDataSource>(
        () => _i110.MessageRemoteDataSourceImpl());
    gh.factory<_i337.DoctorRemoteDataSource>(
        () => _i337.DoctorRemoteDataSourceImpl());
    gh.factory<_i573.AuthRepository>(
        () => _i573.AuthRepositoryImpl(auth: gh<_i970.AuthDataSource>()));
    gh.factory<_i932.NetworkInfo>(() => _i932.NetworkInfoImpl());
    gh.factory<_i684.MessageRepository>(() => _i684.MessageRepositoryImpl(
        dataSource: gh<_i110.MessageRemoteDataSource>()));
    gh.factory<_i117.AuthCubit>(
        () => _i117.AuthCubit(authRepository: gh<_i573.AuthRepository>()));
    gh.factory<_i432.StartChatWithDoctor>(() =>
        _i432.StartChatWithDoctor(repository: gh<_i684.MessageRepository>()));
    gh.factory<_i933.ChatsCubit>(() =>
        _i933.ChatsCubit(messageRepository: gh<_i684.MessageRepository>()));
    gh.factory<_i849.DoctorRepository>(() => _i596.DoctorRepositoryImpl(
          doctorRemoteDataSource: gh<_i337.DoctorRemoteDataSource>(),
          networkInfo: gh<_i932.NetworkInfo>(),
        ));
    gh.factory<_i2.CreateDoctor>(
        () => _i2.CreateDoctor(doctorRepository: gh<_i849.DoctorRepository>()));
    gh.factory<_i43.DoctorsStream>(() =>
        _i43.DoctorsStream(doctorRepository: gh<_i849.DoctorRepository>()));
    gh.factory<_i522.GetDoctors>(
        () => _i522.GetDoctors(doctorRepository: gh<_i849.DoctorRepository>()));
    gh.factory<_i959.UpdateDoctor>(() =>
        _i959.UpdateDoctor(doctorRepository: gh<_i849.DoctorRepository>()));
    gh.factory<_i154.DoctorsCubit>(() => _i154.DoctorsCubit(
          getDoctors: gh<_i522.GetDoctors>(),
          updateDoctor: gh<_i959.UpdateDoctor>(),
          createDoctor: gh<_i2.CreateDoctor>(),
          doctorsStream: gh<_i43.DoctorsStream>(),
          startChatWithDoctor: gh<_i432.StartChatWithDoctor>(),
        ));
    return this;
  }
}
