import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:pulse_max/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
  Future<Unit> saveUserRemote(UserModel user);
  Future<Map<String, dynamic>?> getUserRemote(String userId);
  }
@Injectable(as:AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource{
  final auth =FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance;
  
  CollectionReference get userCollection => firestore.collection('users');
  
  @override
  Future<UserCredential > signInWithGoogle()async {
    try{
final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);

      return userCredential;
      } catch (e) {
        return Future.error(e);
}
    }
  
  
  @override
  Future<void> signOut()async {
    await GoogleSignIn().signOut();
  }
  
  @override
  Future<Map<String, dynamic>?> getUserRemote(String userId) async {
    var user = await userCollection.doc(userId).get();
    if (user.exists) {
      return user.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }
  
  @override
  Future<Unit> saveUserRemote(UserModel user) async {
    final userDoc =  userCollection.doc(user.uid);
    await userDoc.set(user.toMap());
    return Future.value(unit);

  }
}
//   class AuthDataSourceImpl implements AuthDataSource {
// final Supabase supabase; 
//  AuthDataSourceImpl({required this.supabase});
  
 
//   @override
//   Future<void> signOut() async {
//    await GoogleSignIn().signOut();
//   }
  
//   @override
//   Future<void> signInWithFacebook() {
//     // TODO: implement signInWithFacebook
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<AuthResponse> signInWithGoogle()async {
//    const iosClientId = 'my-ios.apps.googleusercontent.com';
//      const webClientId = '281354208064-46n37nstdvjg0qd5idikfl3f2t79vmch.apps.googleusercontent.com';
//   final GoogleSignIn googleSignIn = GoogleSignIn(
//     clientId: iosClientId,
//     serverClientId: webClientId
//   );
//   final googleUser = await googleSignIn.signIn();
//   final googleAuth = await googleUser!.authentication;
//   final accessToken = googleAuth.accessToken;
//   final idToken = googleAuth.idToken;

//   if (accessToken == null) {
//     throw 'No Access Token found.';
//   }
//   if (idToken == null) {
//     throw 'No ID Token found.';
//   }

//  return  await supabase.client.auth.signInWithIdToken(
//     provider: OAuthProvider.google,
//     idToken: idToken,
//     accessToken: accessToken,
//   );
//   }
  
  
//   }