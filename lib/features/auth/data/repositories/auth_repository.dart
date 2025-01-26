
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/auth/data/datasources/auth_data_source.dart';
import 'package:pulse_max/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel >> signInWithGoogle();
  Future<void> signOut();
 Future<Either<String, Unit>> saveUserRemote(UserModel user);
  Future<Either<String ,UserModel?>> getUserRemote(String userId);

}
@Injectable(as:AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthDataSource auth;

  AuthRepositoryImpl({required this.auth});


  @override


  Future<Either<String, UserModel >> signInWithGoogle() async{
    try{
      final response = await auth.signInWithGoogle();
      
  return Right(UserModel(uid: response.user!.uid, email: response.user!.email!,username: response.user!.displayName!, profilePicture: response.user!.photoURL!,createdAt: response.user!.metadata.creationTime!));
    }catch(e){
      return Left(e.toString());
    }
  
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
  
  @override
  Future<Either<String ,UserModel?>> getUserRemote(String userId) async {
    try{
      final response = await auth.getUserRemote(userId);
      if(response != null) {
        return Right( UserModel.fromMap(response));
      }else{
        return const Right(null);
      }
       
    }catch(e){
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either<String, Unit>> saveUserRemote(UserModel user) async {
    try {
      final userData = await getUserRemote(user.uid);
      return userData.fold(
        (l) => Left(l),
        (r) async => r == null
            ? Right(await auth.saveUserRemote(user))
            : const Right(unit),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}