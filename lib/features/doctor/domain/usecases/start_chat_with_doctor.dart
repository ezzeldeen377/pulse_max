import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/data/repositories/message_repository.dart';

@injectable
class StartChatWithDoctor {
  final MessageRepository repository;
  StartChatWithDoctor({required this.repository});
  Future<Either<String, ChatModel>> call(ChatModel chat) async =>
    await repository.createChat(chat);
  
}