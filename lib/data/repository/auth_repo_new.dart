import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sixvalley_ui_kit/error/auth_failer.dart';

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Future<Either<AuthFailuer, User>> logingIn(
      {String email, String password}) async {
    try {
      UserCredential userCride = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(userCride.user);
      return Right(userCride.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(
            AuthFailuer(title: '', message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return Left(AuthFailuer(
            title: '', message: 'Wrong password provided for that user'));
      } else {
        return Left(
            AuthFailuer(title: '', message: 'Error Occure While getting data'));
      }
    }
  }

  Future<Either<AuthFailuer, User>> register(
      {String email, String password}) async {
    try {
      UserCredential userCride = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCride.user != null && userCride.user.uid != null) {
        return Right(userCride.user);
      } else {
        return Left(
            AuthFailuer(title: '', message: 'Error Occure While getting data'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left(AuthFailuer(
            title: '', message: 'This Email Exist with diffrent account'));
      } else {
        return Left(AuthFailuer(
            title: '', message: 'Error Occure While Create Account data'));
      }
    }
  }

  Future<Either<AuthFailuer, String>> resetPassword({String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return Right("Email Sent Successfuly");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/user-not-found') {
        return Left(
            AuthFailuer(title: '', message: 'No User Related To This Email'));
      } else {
        return Left(AuthFailuer(title: '', message: e.message));
      }
    }
  }

  Future<Either<AuthFailuer, String>> changePassword({String password}) async {
    try {
      await _auth.currentUser.updatePassword(password);

      return Right("Email Sent Successfuly");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/user-not-found') {
        return Left(
            AuthFailuer(title: '', message: 'No User Related To This Email'));
      } else {
        return Left(AuthFailuer(title: '', message: e.message));
      }
    }
  }

  Future<Either<AuthFailuer, String>> signOut() async {
    try {
      await _auth.signOut();
      return Right('Done');
    } catch (e) {
      return Left(AuthFailuer(message: 'Error Sign out'));
    }
  }

  User getCurrentUser() {
    return _auth.currentUser;
  }
}
