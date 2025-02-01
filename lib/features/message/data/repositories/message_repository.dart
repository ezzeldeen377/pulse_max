import 'package:dartz/dartz.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/message/data/data_sources/message_remote_data_source.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';

abstract class MessageRepository {
  Stream<Either<String, List<ChatModel>>> getUserChats(String uid);
  Future<Either<String, ChatModel>> createChat(ChatModel chat);
  Stream<Either<String, List<types.Message>>> listOnChatMessages(String chatId);
  Future<Either<String, Unit>> sendMessage(
      types.TextMessage message, String chatId);
  Future<Either<String, Unit>> deleteChat(String chatId);
}

@Injectable(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  MessageRemoteDataSource dataSource;
  MessageRepositoryImpl({required this.dataSource});

  @override
  Stream<Either<String, List<ChatModel>>> getUserChats(String uid) async* {
    try {
      // Get the raw data stream from the data source

      // Map the raw data stream to ChatModel and wrap it in a Right
      yield* dataSource.getUserChats(uid).map((rawData) {
        final chats = rawData.map((data) => ChatModel.fromMap(data)).toList();
        return Right(chats);
      });
    } catch (e) {
      // Catch any synchronous exceptions and yield a Left
      yield Left('Error: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, ChatModel>> createChat(ChatModel chat) async {
    try {
      return Right(await dataSource.createChat(chat));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<Either<String, List<types.Message>>> listOnChatMessages(
      String chatId) async* {
    try {
      yield* dataSource
          .listOnChatMessages(chatId)
          .map((messages) => Right(messages));
    } catch (e) {
      yield Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> sendMessage(
      types.TextMessage message, String chatId) async {
    try {
      await dataSource.sendMessage(message, chatId);
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> deleteChat(String chatId) async {
    try {
      await dataSource.deleteChat(chatId);
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
