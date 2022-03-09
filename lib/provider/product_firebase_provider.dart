/// ProductFirebaseProvider
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/repository/product_firebase_repo.dart';
import 'package:sixvalley_ui_kit/error/database_failure.dart';

class ProductFirebaseProvider extends ChangeNotifier {
  final ProductFirebaseRepository productFirebaseRepo;

  ProductFirebaseProvider({this.productFirebaseRepo});
  
  Either<DatabaseFailuer, List<Product>> products;
  Either<DatabaseFailuer, List<Product>> allProducts;


  List<Product> _productsList = [];
  int _categorySelectedIndex;

  List<Product> get productsList => _productsList;

  Map<String, List<Product>> linkProductsToCategory = {};
  List<Product> get getProducts => allProducts.getOrElse(() => []);

  Future loadAllProducts() async {
    allProducts = await productFirebaseRepo.getAllProducts();
    notifyListeners();
  }

  Future loadLatestProducts() async {
    allProducts = await productFirebaseRepo.getLatestProducts();
    notifyListeners();
  }

  Future loadCategoryProducts({int categoryId}) async {
    // products.
    _productsList = [];
    _productsList = await productFirebaseRepo.getCountryCities(countryId: categoryId);
    // products = await productFirebaseRepo.getCountryCities(countryId: categoryId);
    // return _productsList ;
    // if (products.isRight()) {
    //   linkProductsToCategory.putIfAbsent(categoryId.toString(), () => products.getOrElse(() => null));
    // } else {
    //
    // }
    notifyListeners();
  }

  Future<List<Product>> loadCategoryProductsCat({int categoryId}) async {
    // products.
    // _productsList = [];
    List<Product> _product = [] ;
    _product = await productFirebaseRepo.getCountryCities(countryId: categoryId);
    // products = await productFirebaseRepo.getCountryCities(countryId: categoryId);
    return _product ;
    // if (products.isRight()) {
    //   linkProductsToCategory.putIfAbsent(categoryId.toString(), () => products.getOrElse(() => null));
    // } else {
    //
    // }
    notifyListeners();
  }
  addProduct(Product product) async {
    await productFirebaseRepo.addProduct(product);
  }

  addCategory(Category category) async {
    await productFirebaseRepo.addCategory(category);
  }


  // List<String> cityfavs = [];
  //
  // List<City> get favCity {
  //   List<City> favs = [];
  //   for (var city in allCities.getOrElse(() => null)) {
  //     if (cityfavs.contains(city.id)) {
  //       favs.add(city);
  //     }
  //   }
  //   return favs;
  // }
  //
  // Future addToFav({
  //   String id,
  // }) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   cityfavs.add(id);
  //   prefs.setStringList('cityfavs', cityfavs);
  //
  //   notifyListeners();
  // }
  //
  // Future removeFromFave({
  //   String id,
  // }) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   cityfavs.remove(id);
  //   prefs.setStringList('cityfavs', cityfavs);
  //   notifyListeners();
  // }
  //
  // Future loadAllFav() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   cityfavs = prefs.getStringList('cityfavs') ?? [];
  //   notifyListeners();
  // }
  //
  // deleteAllFav() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove('corsfavs');
  //   prefs.remove('cityfavs');
  // }
}
