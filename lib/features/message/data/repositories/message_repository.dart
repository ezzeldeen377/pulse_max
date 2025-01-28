import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/message/data/data_sources/message_remote_data_source.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';

abstract class MessageRepository {
  Future<Either<String, List<ChatModel>>> getUserChats(String uid);
  Future<Either<String,ChatModel>> createChat(ChatModel chat);
   void listenOnChatMessages(Function(List<types.Message> p1) callback,String chatId);
     Future<Either<String ,Unit>> sendMessage(types.TextMessage message, String chatId);

}
@Injectable(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  MessageRemoteDataSource dataSource;
  MessageRepositoryImpl({required this.dataSource});

  @override
  Future<Either<String, List<ChatModel>>> getUserChats(String uid) async {
    try {
      final rawData = await dataSource.getUserChats(uid);
      return Right(rawData.map((data) => ChatModel.fromMap(data)).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either<String, ChatModel>> createChat(ChatModel chat)async {
    try {
      return Right(await dataSource.createChat(chat));
    } catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  void listenOnChatMessages(Function(List<types.Message> p1) callback, String chatId) {
    return dataSource.listOnChatMessages(callback, chatId);
    }
    
      @override
      Future<Either<String, Unit>> sendMessage(types.TextMessage message, String chatId) async {
    try {
      await dataSource.sendMessage(message, chatId);
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }

      }
}
