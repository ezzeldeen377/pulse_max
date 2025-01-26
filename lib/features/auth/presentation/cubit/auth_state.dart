// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pulse_max/features/auth/data/models/user_model.dart';

enum AuthStatus{
  initial,
  loading,
  success,
  saved,
  error
}
extension AuthStateExtension on AuthState{
  bool get isLoading => status == AuthStatus.loading;
  bool get isSuccess => status == AuthStatus.success;
  bool get isError => status == AuthStatus.error;
  bool get isInitial => status == AuthStatus.initial; // Fixed typo
  bool get isSaved => status == AuthStatus.saved;
}
class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  UserModel? user;
  AuthState({
    required this.status,
    this.errorMessage,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    UserModel? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
