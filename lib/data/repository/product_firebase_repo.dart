import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/error/database_failure.dart';



class ProductFirebaseRepository {
  // final FirebaseFirestore _fs;
  //
  // ProductFirebaseRepository(this._fs);


  Future<Either<DatabaseFailuer, List<Product>>> getAllProducts() async {
    try {
      var data = await FirebaseFirestore.instance.collection('Product').get();
      List<Product> cities =
      data.docs.map((e) => Product.fromJson(e.data())).toList();
      return Right(cities);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailuer(title: '', message: e.message));
    }
  }

  Future<Either<DatabaseFailuer, List<Product>>> getLatestProducts() async {
    try {
      var data = await FirebaseFirestore.instance.collection('Product').limit(8).get();
      List<Product> cities =
      data.docs.map((e) => Product.fromJson(e.data())).toList();
      return Right(cities);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailuer(title: '', message: e.message));
    }
  }

  addProduct(Product product) async {
    try {
      await FirebaseFirestore.instance.collection('Product').add(product.toJsonFireBase(FieldPath.documentId)).then((value) {
        var collection = FirebaseFirestore.instance.collection('Product');collection.doc('${value.id}').update({"id" : "${value.id}"});
      });
    } catch (e) {
      print(e);
    }
  }

  addCategory(Category category) async {
    try {
      await FirebaseFirestore.instance.collection('Category').add(category.toJsonFireBase()).then((value) {
        var collection = FirebaseFirestore.instance.collection('Category');collection.doc('${value.id}').update({"id" : "${value.id}"});
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Product>> getCountryCities(
      {int countryId}) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('Product')
          .where('categoryId', isEqualTo: countryId)
          .get();

      List<Product> cities = data.docs.map((e) => Product.fromJson(e.data())).toList();
      // data.docs.map((e) => Product.fromJson(e.data(), e.id)).toList();
      print(data.docs.length);
      // print(cities.length);
      return cities;
      // return Right(cities);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  
}

