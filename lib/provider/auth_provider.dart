import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sixvalley_ui_kit/data/model/body/login_model.dart';
import 'package:sixvalley_ui_kit/data/model/body/register_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/data/repository/auth_repo.dart';
import 'package:http/http.dart' as http;
import '../data/model/http_exception.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create firebase obj based on FirebaseUser
  UserInfoModel _userFromFirebaseUser(User user){
   return user != null ? UserInfoModel(uid: user.uid) : null;
  }

  AuthProvider({@required this.authRepo});
  bool _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  updateSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }
  bool get isRemember => _isRemember;
  void updateRemember(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  // auth change user stream
  Stream<UserInfoModel> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  // FIREBASE SIGN IN ANON
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  // FIREBASE SIGN UP REQUEST with EMAIL & PASS
  Future registration(RegisterModel register) async {
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAKfzmdjqarAEITeTb6AIS4kj2cKhoNoME');
    try {
      final response = await http.post(
          url,
          body: json.encode({
            'email': register.email,
            'password': register.password,
            'returnSecureToken': true}));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      };
    } catch (error) {
      throw error;
    }
    authRepo.saveUserToken('token');
  }

  // FIREBASE SIGN IN REQUEST with EMAIL & PASS
  Future login(LoginModel loginBody) async {
    final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAKfzmdjqarAEITeTb6AIS4kj2cKhoNoME');
    try {
      final response = await http.post(
          url,
          body: json.encode({
            'email': loginBody.email,
            'password': loginBody.password,
            'returnSecureToken': true}));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      };
    } catch (error) {
      throw error;
    }
    authRepo.saveUserToken('token');
  }

  // FIREBASE SIGN OUT
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // FIREBASE SIGN UP REQUEST with EMAIL & PASS DEPRECATED
  /*
  Future registration(RegisterModel register) async {
    authRepo.saveUserToken('token');
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: register.email, password: register.password);
      User user = result.user;
      // create a new document for the user with the uid
      await AuthRepo(uid: user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
   */

  // FIREBASE SIGN IN REQUEST with EMAIL & PASS DEPRECATED
  /*
  Future login(LoginModel loginBody) async {
    authRepo.saveUserToken('token');
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: loginBody.email, password: loginBody.password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  */

  // for user Section
  String getUserToken() {
    return authRepo.getUserToken();
  }
  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }
  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }
  String getUserEmail() {
    return authRepo.getUserEmail() ?? "";
  }
  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserEmailAndPassword();
  }
  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }
}
