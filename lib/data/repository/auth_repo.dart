import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/user_info_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final String uid;
  AuthRepo({@required this.sharedPreferences, this.uid});

  // for collection reference
  final CollectionReference delamCollection = FirebaseFirestore.instance.collection('delams');

  Future updateUserData(String product, String name, int number) async {
    return await delamCollection.doc(uid).set({
      'product':product,
      'name':name,
      'number':number,
    });
  }

  // FIREBASE USERS snapshot
  UserInfoModel _firebaseUsers(DocumentSnapshot snapshot) {
    return UserInfoModel(uid: uid, name: 'aziz', fName: 'John', lName: 'Doe', phone: '+886737663', email: 'johndoe@gmail.com', image: 'assets/images/person.jpg');
  }

  // get user doc stream
  Stream<UserInfoModel> get userInfoModel {
    return delamCollection.doc(uid).snapshots()
        .map(_firebaseUsers);
  }

  // FIREBASE PRODUCTS snapshot
  List<Product> _firebaseProducts(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Product(7, 'seller', '1', 'تيشيرت برج السرطان', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/1.png'], 'assets/images/1.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]);
    }).toList();
  }

  // get products stream
  Stream<List<Product>> get delams {
    return delamCollection.snapshots()
        .map(_firebaseProducts);
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }
  Future<bool> clearSharedData() async {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CURRENCY);
    return sharedPreferences.remove(AppConstants.TOKEN);
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }
  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }
  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }
  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

}
