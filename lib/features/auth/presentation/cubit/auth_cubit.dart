import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/core/helpers/shared_prefernece_utiles.dart';
import 'package:pulse_max/features/auth/data/models/user_model.dart';
import 'package:pulse_max/features/auth/data/repositories/auth_repository.dart';
import 'package:pulse_max/features/auth/presentation/cubit/auth_state.dart';
@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository})
      : super(AuthState(status: AuthStatus.initial));

  Future<void> signInWithGoogle() async {
    emit(AuthState(status: AuthStatus.loading));
    final response = await authRepository.signInWithGoogle();
    response.fold(
      (l) => emit(AuthState(status: AuthStatus.error, errorMessage: l)),
      (r) => emit(AuthState(status: AuthStatus.success,user: r)),
    );
  }

  Future<void> saveUserRemote(UserModel user) async {
    emit(AuthState(status: AuthStatus.loading));
    SharedPreferneceUtiles.saveData(user.toJson());
    final response = await authRepository.saveUserRemote(user);
    response.fold(
      (l) => emit(AuthState(status: AuthStatus.error, errorMessage: l)),
      (r) => emit(AuthState(status: AuthStatus.saved)),
    );
  }
}