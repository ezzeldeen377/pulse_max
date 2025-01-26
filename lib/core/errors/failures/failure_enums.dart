import 'package:pulse_max/core/errors/failures/cache_failure.dart';
import 'package:pulse_max/core/errors/failures/failure.dart';
import 'package:pulse_max/core/errors/failures/network_failure.dart';
import 'package:pulse_max/core/errors/failures/server_failure.dart';

enum FailureEnum {
  networkFailure,
  cacheFailure,
  serverFailure,
  unknownFailure,
}

FailureEnum failure2FailureEnum(Failure failure) {
  switch (failure) {
    case NetworkFailure():
      return FailureEnum.networkFailure;
    case CacheFailure():
      return FailureEnum.cacheFailure;
    case ServerFailure():
      return FailureEnum.serverFailure;
  }

  return FailureEnum.unknownFailure;
}
