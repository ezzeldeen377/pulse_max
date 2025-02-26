import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:injectable/injectable.dart';

abstract class AskAiDataSource {
  Future<String> getMessage(String prompt);
}
@Injectable(as: AskAiDataSource)
class AskAiDataSourceImpl implements AskAiDataSource {
  @override
  Future<String> getMessage(String prompt) async {
    final response =await Gemini.instance.prompt(parts: [
  Part.text(prompt),
]);
    return response?.output ?? '';
  }
}
