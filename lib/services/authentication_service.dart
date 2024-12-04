import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/services/handle_firebase_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  static late AuthStatus _status;

  static Future<AuthStatus> login({required String username,required String password}) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = HandleFirebaseException.HandleAuthException(e);
    }
    return _status;
  }

  static Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  static Future<AuthStatus> createNewAccount({required String username,required String password}) async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: username, password: password);
      _status = AuthStatus.successful;
    } on FirebaseAuthException catch (e) {
      _status = HandleFirebaseException.HandleAuthException(e);
    }
    return _status;
  }

  static Future<AuthStatus> signinWithGoogle() async{
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      _status = AuthStatus.successful;
    } on  FirebaseAuthException catch(e) {
      _status = HandleFirebaseException.HandleAuthException(e);
    }
    return _status;
  }

  static Future<AuthStatus> resetPassword ({required String Username})async{
    await FirebaseAuth.instance
          .sendPasswordResetEmail(email: Username)
          .then((value) => _status = AuthStatus.successful)
          .catchError((onError)=> _status = HandleFirebaseException.HandleAuthException(onError));
    return _status;
  }
}