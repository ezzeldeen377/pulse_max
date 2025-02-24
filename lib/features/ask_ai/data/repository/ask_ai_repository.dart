import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/ask_ai/data/data_source/ask_ai_data_source.dart';

abstract class AskAiRepository {
  Future<Either<String, String>> getMessage(String prompt);
}
@Injectable(as: AskAiRepository)

class AskAiRepositoryImpl implements AskAiRepository {
  final AskAiDataSource dataSource;

  AskAiRepositoryImpl(this.dataSource);

  @override
  Future<Either<String, String>> getMessage(String prompt) async {
    try {
      final response = await dataSource.getMessage(prompt);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
