import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart'as types;
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/message/data/models/chat_model.dart';
import 'package:pulse_max/features/message/data/repositories/message_repository.dart';
import 'package:pulse_max/features/message/presentation/cubits/chats_state.dart';

@injectable
class ChatsCubit extends Cubit<ChatsState> {
  final MessageRepository messageRepository;
  ChatsCubit({required this.messageRepository})
      : super(const ChatsState(status: ChatsStatus.initial));


  Future<void> getChats(String uid) async {
    emit(state.copyWith(status: ChatsStatus.loading));
    try {
      final response = await messageRepository.getUserChats(uid);
      response.fold(
        (l) => emit(state.copyWith(status: ChatsStatus.error, errorMessage: l)),
        (r) => emit(state.copyWith(status: ChatsStatus.success, chats: r)),
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
    messageRepository.listenOnChatMessages((messages) {
      if (!isClosed) {
        // Ensure Cubit is not closed
        print("test");
        emit(state.copyWith(status: ChatsStatus.success, messages: messages));
      } else {
        print("Cubit is closed, cannot emit state.");
      }
    }, chatId);
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
}
