
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/ask_ai/data/models/messages_model.dart';
import 'package:pulse_max/features/ask_ai/data/repository/ask_ai_repository.dart';

part 'ask_ai_state.dart';

@injectable
class AskAiCubit extends Cubit<AskAiState> {
  AskAiCubit({required this.repository}) : super(AskAiState(state: AskAiStatus.initial));
  AskAiRepository repository;

  final TextEditingController controller = TextEditingController();

  List<MessagesModel> chats = [];


Future<void> getMessage() async {
  try {
    if (controller.text.trim().isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter a message'));
      return;
    }

    final String prompt = controller.text;
    controller.clear();

    // Add user message to chat
    chats.add(MessagesModel(message: prompt, state: 'send'));
    
    // Show typing indicator
    final typingMessage = MessagesModel(message: 'typing...', state: 'received');
    chats.add(typingMessage);
    
    // Emit loading state
    emit(state.copyWith(
      state: AskAiStatus.loading,
      errorMessage: null ,messages:chats // Clear any previous errors
    ));

    // Get response from repository
    final result = await repository.getMessage(prompt);

    result.fold(
      (error) {
        // Remove typing indicator and show error
        chats.removeLast();
        chats.add(MessagesModel(
          message: 'Error: $error',
          state: 'received',
          
        ));
        emit(state.copyWith(
          state: AskAiStatus.error,
          errorMessage: error,messages: chats
        ));
      },
      (response) {
        // Update typing message with response
        typingMessage.message = response;
        emit(state.copyWith(
          state: AskAiStatus.success,
          errorMessage: null,messages: chats
        ));
      }
      
    );
  } catch (e) {
    // Handle any unexpected errors
    emit(state.copyWith(
      state: AskAiStatus.error,
      errorMessage: e.toString()
    ));
  }
}

}
