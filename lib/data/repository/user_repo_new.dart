import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:sixvalley_ui_kit/data/model/response/user.dart';
import 'package:sixvalley_ui_kit/error/database_failure.dart';

class UserRepository {
  final FirebaseFirestore _fs;

  UserRepository(this._fs);

  Future<Either<DatabaseFailuer, String>> createUser({User user}) async {
    try {
      await _fs.collection("Users").doc(user.id).set(user.toJson());
      return Right('Account Created Successfully');
    } catch (e) {
      return Left(
          DatabaseFailuer(title: '', message: 'Failed to Create Account'));
    }
  }

  Future<Either<DatabaseFailuer, User>> getUserData({String uid}) async {
    try {
      DocumentSnapshot userData = await _fs.collection("Users").doc(uid).get();
      print(userData.data());
      var user = User().fromJson(userData.data());
      return Right(user);
    } catch (e) {
      return Left(
          DatabaseFailuer(title: '', message: 'Failed to get User Data'));
    }
  }

  Future<Either<DatabaseFailuer, User>> updateUserData(User user) async {
    try {
      await _fs.collection("Users").doc(user.id).set(user.toJson());
      var userData = await _fs.collection("Users").doc(user.id).get();

      return Right(User().fromJson(userData.data()));
    } catch (e) {
      return Left(
          DatabaseFailuer(title: '', message: 'Failed to get User Data'));
    }
  }
}
