import 'package:firebase_core/firebase_core.dart';

enum AuthStatus{
  successful,wrongPassword,emailAlreadyExists,invalidEmail,weakPassword,userNotFouund,unknow
}
class HandleFirebaseException {
  static HandleAuthException(FirebaseException e){
    AuthStatus status =switch(e.code){
      "invalid-email" => AuthStatus.invalidEmail,
      "wrong-password" => AuthStatus.wrongPassword,
      "weak-password" => AuthStatus.weakPassword,
      "email-already-in-use" => AuthStatus.emailAlreadyExists,
      "user-not-found" => AuthStatus.userNotFouund,
      _ => AuthStatus.unknow
    };
    return status;
  }

  static String generateErrMsg(error){
    String errMsg = switch (error){
      AuthStatus.invalidEmail => "Your email address is not valid",
      AuthStatus.weakPassword => "Your email should be at least 6 characters",
      AuthStatus.wrongPassword => "Your email pr password is wrong",
      AuthStatus.emailAlreadyExists => "The email address is already in use by another account",
      AuthStatus.userNotFouund => "NO user correspoing to the email address",
      _ => "An error occured.Please try again later"
    };
    return errMsg;
  }
}