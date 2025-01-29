import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/data/repositories/message_repository.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_state.dart';

@injectable
class ChatsCubit extends Cubit<ChatsState> {
  final MessageRepository messageRepository;
  ChatsCubit({required this.messageRepository})
      : super(const ChatsState(status: ChatsStatus.initial));

  StreamSubscription<Either<String, List<types.Message>>>?
      _messagesSubscription;
  StreamSubscription<Either<String, List<ChatModel>>>? _chatsSubscription;

  Future<void> getChats(String uid) async {
    emit(state.copyWith(status: ChatsStatus.loading));
    try {
      _chatsSubscription = messageRepository.getUserChats(uid).listen(
        (event) {
          event.fold(
            (error) => emit(state.copyWith(
                status: ChatsStatus.error,
                errorMessage: error)), // Handle error
            (chats) => emit(state.copyWith(
                status: ChatsStatus.success,
                chats: chats)), // Handle success
          );
        },
        onError: (error) {
          emit(state.copyWith(
              status: ChatsStatus.error, errorMessage: error.toString()));
        },
      );
    } catch (e) {
      emit(state.copyWith(
          status: ChatsStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> createChat(ChatModel chat) async {
    emit(state.copyWith(status: ChatsStatus.loading));
    try {
      final response = await messageRepository.createChat(chat);
      response.fold(
        (l) => emit(state.copyWith(status: ChatsStatus.error, errorMessage: l)),
        (r) => emit(state.copyWith(status: ChatsStatus.success)),
      );
    } catch (e) {
      emit(state.copyWith(
          status: ChatsStatus.error, errorMessage: e.toString()));
    }
  }

  void listOnChatMessages(String chatId) {
    emit(state.copyWith(status: ChatsStatus.loading));

    // Listen to the repository's stream
    _messagesSubscription = messageRepository.listOnChatMessages(chatId).listen(
      (event) {
        event.fold(
          (error) => emit(state.copyWith(
              status: ChatsStatus.error, errorMessage: error)), // Handle error
          (messages) => emit(state.copyWith(
              status: ChatsStatus.success,
              messages: messages)), // Handle success
        );
      },
      onError: (error) {
        emit(state.copyWith(
            status: ChatsStatus.error, errorMessage: error.toString()));
      },
    );
  }

  void sendMessage(types.TextMessage message, String chatId) async {
    emit(state.copyWith(status: ChatsStatus.loading));
    try {
      final response = await messageRepository.sendMessage(message, chatId);
      response.fold(
        (l) => emit(state.copyWith(status: ChatsStatus.error, errorMessage: l)),
        (r) => emit(state.copyWith(status: ChatsStatus.success)),
      );
    } catch (e) {
      emit(state.copyWith(
          status: ChatsStatus.error, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    _chatsSubscription?.cancel();
    return super.close();
  }
}
