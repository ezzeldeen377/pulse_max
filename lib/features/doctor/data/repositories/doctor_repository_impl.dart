import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/core/errors/failures/failure.dart';
import 'package:pulse_max/core/errors/failures/network_failure.dart';
import 'package:pulse_max/core/network/network_info.dart';
import 'package:pulse_max/features/doctor/data/data_sources/doctor_remote_data_source.dart';
import 'package:pulse_max/features/doctor/data/models/doctor_model.dart';
import 'package:pulse_max/features/doctor/domain/entities/doctor.dart';
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
  Future<Either<Failure, Unit>> createDoctor(Doctor doctor) async {
    if (await networkInfo.isConnected) {
      await doctorRemoteDataSource.createDoctor(
        DoctorModel.fromEntity(doctor),
      );
      return right(unit);
    }

    return left(NetworkFailure());
  }

  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctorList() async {
    if (await networkInfo.isConnected) {
      final rawData = await doctorRemoteDataSource.getDoctorList();
      final doctorList = rawData?.map((data) =>DoctorModel.fromJson(data)).toList();
      return right(doctorList!);
    } else {
      return left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateDoctor(Doctor doctor) async {
    if (await networkInfo.isConnected) {
      doctorRemoteDataSource.updateDoctor(
        DoctorModel.fromEntity(doctor),
      );
      return right(unit);
    } else {
      return left(NetworkFailure());
    }
  }

  @override
  void listen(Function(List<DoctorModel> p1) callback) {
    return doctorRemoteDataSource.listen(callback);
  }
}
