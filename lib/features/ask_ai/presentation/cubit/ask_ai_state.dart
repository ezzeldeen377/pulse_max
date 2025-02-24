// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ask_ai_cubit.dart';

enum AskAiStatus {
  initial,
  loading,
  error,
  success
}
extension ChatStateX on AskAiStatus {
  bool get isInitial => this == AskAiStatus.initial;
  bool get isLoading => this == AskAiStatus.loading;
  bool get isError => this == AskAiStatus.error;
  bool get isSuccess => this == AskAiStatus.success;
}

class AskAiState {
  final AskAiStatus state;
  final String? errorMessage;
  final List<MessagesModel>? messages;

  AskAiState({
    required this.state,
    this.errorMessage,
    this.messages,
  });

  factory AskAiState.initial() => AskAiState(state: AskAiStatus.initial);
  
  factory AskAiState.loading() => AskAiState(state: AskAiStatus.loading);
  
  factory AskAiState.error(String message) => AskAiState(
    state: AskAiStatus.error,
    errorMessage: message
  );
  
  

  AskAiState copyWith({
    AskAiStatus? state,
    String? errorMessage,
    List<MessagesModel>? messages,
  }) {
    return AskAiState(
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
      messages: messages ?? this.messages,
    );
  }

  @override
  String toString() => 'ChatScreenState(state: $state, errorMessage: $errorMessage, messages: $messages)';
}
