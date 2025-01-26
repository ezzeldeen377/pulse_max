// lib/features/message/presentation/cubits/chats_state.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:pulse_max/features/message/data/models/chat_model.dart';

enum ChatsStatus{
  initial,
  loading,
  success,
  error,
  empty
}
extension ChatsStateExtension on ChatsState{
  bool get isLoading => status == ChatsStatus.loading;
  bool get isSuccess => status == ChatsStatus.success;
  bool get isError => status == ChatsStatus.error;
  bool get isEmpty => status == ChatsStatus.empty;
  bool get isInitial => status == ChatsStatus.initial;
}

class ChatsState {
  final ChatsStatus status;
  final List<ChatModel>? chats;
  final List<types.Message>? messages; 
  final String? errorMessage;

  const ChatsState({
    required this.status,
    this.chats,
    this.messages,
    this.errorMessage,
  });

  ChatsState copyWith({
    ChatsStatus? status,
    List<ChatModel>? chats,
    List<types.Message>? messages,
    String? errorMessage,
  }) {
    return ChatsState(
      status: status ?? this.status,
      chats: chats ?? this.chats,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, chats, errorMessage];
  @override
  String toString() {
    return 'ChatsState(status: $status, chats: $chats, errorMessage: $errorMessage, messages: $messages)';
  }
}
