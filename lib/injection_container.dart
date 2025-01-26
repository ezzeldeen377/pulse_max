// import 'package:get_it/get_it.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:pulse_max/core/network/network_info.dart';
// import 'package:pulse_max/features/doctor/data/data_sources/doctor_remote_data_source.dart';
// import 'package:pulse_max/features/doctor/data/repositories/doctor_repository_impl.dart';
// import 'package:pulse_max/features/doctor/domain/repository/doctor_repository.dart';
// import 'package:pulse_max/features/doctor/domain/usecases/create_doctor.dart';
// import 'package:pulse_max/features/doctor/domain/usecases/doctors_stream.dart';
// import 'package:pulse_max/features/doctor/domain/usecases/get_doctors.dart';
// import 'package:pulse_max/features/doctor/domain/usecases/update_doctor.dart';
// import 'package:pulse_max/features/doctor/presentation/providers/doctors_provider.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   sl.registerFactory(
//     () => DoctorsProvider(
//       createDoctor: sl(),
//       // getDoctorList: sl(),
//       updateDoctor: sl(),
//       // listen: sl(),
//       doctorsStream: sl(),
//       getDoctors: sl(),
//     ),
//   );

//   sl.registerLazySingleton<GetDoctors>(
//     () => GetDoctors(
//       doctorRepository: sl(),
//     ),
//   );

//   sl.registerLazySingleton<UpdateDoctor>(
//     () => UpdateDoctor(
//       doctorRepository: sl(),
//     ),
//   );

//   sl.registerLazySingleton<CreateDoctor>(
//     () => CreateDoctor(
//       doctorRepository: sl(),
//     ),
//   );

//   sl.registerLazySingleton<DoctorsStream>(
//     () => DoctorsStream(
//       doctorRepository: sl(),
//     ),
//   );

//   sl.registerLazySingleton<DoctorRepository>(
//     () => DoctorRepositoryImpl(
//       networkInfo: sl(),
//       doctorRemoteDataSource: sl(),
//     ),
//   );

//   sl.registerLazySingleton<DoctorRemoteDataSource>(
//     () => DoctorRemoteDataSourceImpl(),
//   );

//   sl.registerLazySingleton<NetworkInfo>(
//     () => NetworkInfoImpl(
//       internetConnectionChecker: sl(),
//     ),
//   );

//   sl.registerLazySingleton<SupabaseClient>(
//     () => Supabase.instance.client,
//   );

//   sl.registerLazySingleton<InternetConnectionChecker>(
//     () => InternetConnectionChecker(),
//   );
// }
