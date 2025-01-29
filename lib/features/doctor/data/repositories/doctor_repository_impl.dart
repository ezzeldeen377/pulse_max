import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/core/errors/failures/failure.dart';
import 'package:pulse_max/core/errors/failures/network_failure.dart';
import 'package:pulse_max/core/network/network_info.dart';
import 'package:pulse_max/features/doctor/data/data_sources/doctor_remote_data_source.dart';
import 'package:pulse_max/features/doctor/data/models/appointment_model.dart';
import 'package:pulse_max/features/doctor/data/models/doctor.dart';
import 'package:pulse_max/features/doctor/domain/repository/doctor_repository.dart';

@Injectable(as: DoctorRepository)
class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource doctorRemoteDataSource;
  final NetworkInfo networkInfo;
  DoctorRepositoryImpl({
    required this.doctorRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> createDoctor(DoctorModel doctor) async {
    if (await networkInfo.isConnected) {
      await doctorRemoteDataSource.createDoctor(
        doctor,
      );
      return right(unit);
    }

    return left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorList() async {
    if (await networkInfo.isConnected) {
      final rawData = await doctorRemoteDataSource.getDoctorList();
      final doctorList =
          rawData?.map((data) => DoctorModel.fromMap(data)).toList();
      return right(doctorList!);
    } else {
      return left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateDoctor(DoctorModel doctor) async {
    if (await networkInfo.isConnected) {
      doctorRemoteDataSource.updateDoctor(
        doctor,
      );
      return right(unit);
    } else {
      return left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createAppointment(AppointmentModel app) async {
    if (await networkInfo.isConnected) {
      await doctorRemoteDataSource.createAppointment(
        app,
      );
      return right(unit);
    }

    return Left(NetworkFailure());
}
}