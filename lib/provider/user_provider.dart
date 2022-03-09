import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:sixvalley_ui_kit/data/model/response/user.dart';
import 'package:sixvalley_ui_kit/data/repository/auth_repo_new.dart';
import 'package:sixvalley_ui_kit/data/repository/user_repo_new.dart';
import 'package:sixvalley_ui_kit/error/auth_failer.dart';
import 'package:sixvalley_ui_kit/error/database_failure.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository userRepo;
  final AuthRepository authRepo;
  UserProvider({this.userRepo, this.authRepo});

  Either<DatabaseFailuer, User> userResult;
  Either<AuthFailuer, String> resetPasswordResult;
  Either<AuthFailuer, String> changePasswordResult;
  bool isLoading = false;

  User get user {
    print("dfsd ${userResult}");
    if(userResult == null){
      return null ;
    }else{
      return  userResult.getOrElse(() => null);
    }


  }

  Future login({String email, String password}) async {
    var userr = await authRepo.logingIn(email: email, password: password);
    await userr.fold((fail) {
      userResult = Left(DatabaseFailuer(
        title: fail.title,
        message: fail.message,
      ));
    }, (user) async {
      userResult = await userRepo.getUserData(uid: user.uid);
    });

    notifyListeners();
  }

  Future register({
    User userr,
    String password,
  }) async {
    var user = await authRepo.register(email: userr.email, password: password);
    await user.fold((fail) {
      userResult = Left(DatabaseFailuer(
        title: fail.title,
        message: fail.message,
      ));
    }, (user) async {
      var data = await userRepo.createUser(
          user: User(
            city: userr.city,
            country: userr.country,
            id: user.uid,
            email: userr.email,
            name: userr.name,
          ));
      await data.fold((l) {
        userResult = Left(l);
      }, (r) async {
        userResult = await userRepo.getUserData(uid: user.uid);
      });
    });

    notifyListeners();
  }

  getUserData({String uid}) async {
    userResult = await userRepo.getUserData(uid: uid);
    notifyListeners();
  }

  updateUserData({User user}) async {
    userResult = await userRepo.updateUserData(user);
    notifyListeners();
  }

  Future signOut() async {
    var result = await authRepo.signOut();
    result.fold((l) => l, (r) {
      userResult = null;
      return r;
    });


    notifyListeners();
  }

  fa.User currentUser() {
    return authRepo.getCurrentUser();
  }

  resetPassword({String email}) async {
    var result = await authRepo.resetPassword(email: email);
    result.fold((l) => resetPasswordResult = Left(l),
            (r) => resetPasswordResult = Right(r));

    notifyListeners();
  }

  Future changePassword({String password}) async {
    var result = await authRepo.changePassword(password: password);
    result.fold((l) => changePasswordResult = Left(l),
            (r) => changePasswordResult = Right(r));
    notifyListeners();
  }

  loading() {
    isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<String> uploadFile(File file) async {
    try {
      var result = await FirebaseStorage.instance
          .ref('userImages/${user.id}.png')
          .putFile(file);
      return await result.ref.getDownloadURL();
    } on FirebaseException catch (e) {}
  }
}
