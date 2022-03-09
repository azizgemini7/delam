import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/repository/auth_repo.dart';

class ProductRepo {

  List<Product> getLatestProductList() {
    List<Product> productList = [
      Product(1, 'admin', '1', 'Lamborghini', '', [], '', '', '1', '', ['assets/images/white_car.png', 'assets/images/blue_car.png'], 'assets/images/blue_car.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Tripod Projection Screen. This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.7')]),
      Product(2, 'seller', '1', 'Special Lounge', '', [], '', '', '1', '', ['assets/images/lounge1.png', 'assets/images/lounge.png', 'assets/images/lounge2.png'], 'assets/images/lounge.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.2')]),
      Product(3, 'seller', '1', 'Headphone', '', [], '', '', '1', '', ['assets/images/headphone1.png', 'assets/images/headphone2.png', 'assets/images/headphone3.png', 'assets/images/headphone4.png'], 'assets/images/headphone.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '480', '5', 'percent', '5', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '5.0')]),
      Product(4, 'seller', '1', 'Gaming RAM', '', [], '', '', '1', '', ['assets/images/gaming_ram_1.png', 'assets/images/gaming_ram_2.png', 'assets/images/gaming_ram.png'], 'assets/images/gaming_ram.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '460', '230', '5', 'percent', '10', 'percent', '7', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '4.5')]),
      Product(5, 'seller', '1', 'Hair Cutter', '', [], '', '', '1', '', ['assets/images/hair_cutter.png'], 'assets/images/hair_cutter.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '260', '230', '9', 'percent', '8', 'percent', '7', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '4.7')]),
      Product(6, 'seller', '1', 'HP Laptop', '', [], '', '', '1', '', ['assets/images/laptop.png'], 'assets/images/laptop.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '460', '290', '9', 'percent', '2', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(7, 'seller', '1', 'Realme Phone', '', [], '', '', '1', '', ['assets/images/realme1.png', 'assets/images/realme.png'], 'assets/images/realme.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '960', '590', '4', 'percent', '2', 'percent', '5', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '4.2')]),
      Product(8, 'seller', '1', 'Special Men\'s Shoe', '', [], '', '', '1', '', ['assets/images/shoe1.png', 'assets/images/shoe.png'], 'assets/images/shoe.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '990', '590', '4', 'percent', '12', 'percent', '5', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.9')]),
      Product(9, 'seller', '1', 'Hand Watch', '', [], '', '', '1', '', ['assets/images/watch.png'], 'assets/images/watch.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '990', '590', '4', 'percent', '12', 'percent', '5', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '4.9')]),
      Product(10, 'seller', '1', 'Samsung LED TV', '', [], '', '', '1', '', ['assets/images/tv1.png', 'assets/images/tv.png'], 'assets/images/tv.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '990', '590', '4', 'percent', '12', 'percent', '5', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '5.0')]),
    ];
    return productList;
  }

  List<Product> getSellerProductList() {
    List<Product> productList = [
      Product(1, 'admin', '1', 'Lamborghini', '', [], '', '', '1', '', ['assets/images/white_car.png', 'assets/images/blue_car.png'], 'assets/images/blue_car.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Tripod Projection Screen. This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.7')]),
    ];
    return productList;
  }

  List<Product> getBrandOrCategoryProductList() {
    List<Product> productList = [
      Product(2, 'seller', '2', 'Special Loungeee', '', [], '', '', '1', '', ['assets/images/lounge1.png', 'assets/images/Lounge.png', 'assets/images/lounge2.png'], 'assets/images/lounge.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '450', '5', 'percent', '10', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '3.2')]),
      Product(3, 'seller', '1', 'Headphone', '', [CategoryIds(id: '2')], '', '', '1', '', ['assets/images/headphone1.png', 'assets/images/headphone2.png', 'assets/images/headphone3.png', 'assets/images/headphone4.png'], 'assets/images/headphone.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '500', '480', '5', 'percent', '5', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '5.0')]),
      Product(4, 'seller', '1', 'Gaming RAM', '', [CategoryIds(id: '3', position: 3)], '', '', '1', '', ['assets/images/gaming_ram_1.png', 'assets/images/gaming_ram_2.png', 'assets/images/gaming_ram.png'], 'assets/images/gaming_ram.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '460', '230', '5', 'percent', '10', 'percent', '7', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '4.5')]),
      Product(5, 'seller', '1', 'Hair Cutter', '', [CategoryIds(id: '4', position: 4)], '', '', '1', '', ['assets/images/hair_cutter.png'], 'assets/images/hair_cutter.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '260', '230', '9', 'percent', '8', 'percent', '7', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '4.7')]),
      Product(6, 'seller', '1', 'HP Laptop', '', [CategoryIds(id: '5', position: 5)], '', '', '1', '', ['assets/images/laptop.png'], 'assets/images/laptop.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '460', '290', '9', 'percent', '2', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(7, 'seller', '1', 'تيشيرت برج السرطان', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/1.png'], 'assets/images/1.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(8, 'seller', '1', 'تيشيرت برج الأسد', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/2.png'], 'assets/images/2.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(9, 'seller', '1', 'تيشيرت برج العذراء', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/3.png'], 'assets/images/3.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(10, 'seller', '1', 'تيشيرت برج الميزان', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/4.png'], 'assets/images/4.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(11, 'seller', '1', 'تيشيرت برج العقرب', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/5.png'], 'assets/images/5.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(12, 'seller', '1', 'تيشيرت برج القوس', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/6.png'], 'assets/images/6.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(13, 'seller', '1', 'تيشيرت برج الجدي', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/7.png'], 'assets/images/7.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(14, 'seller', '1', 'تيشيرت برج الدلو', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/8.png'], 'assets/images/8.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(15, 'seller', '1', 'تيشيرت برج الحوت', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/9.png'], 'assets/images/9.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(16, 'seller', '1', 'تيشيرت برج الحمل', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/10.png'], 'assets/images/10.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(17, 'seller', '1', 'تيشيرت برج الثور', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/11.png'], 'assets/images/11.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),
      Product(18, 'seller', '1', 'تيشيرت برج الجوزاء', '', [CategoryIds(id: '1', position: 5)], '', '', '1', '', ['assets/images/12.png'], 'assets/images/12.png', '', '', '', '', [ProductColors(name: 'Black', code: '#000000')], '', [], [], [], '', '130', '290', '9', 'percent', '30', 'percent', '10', 'Apollo 70, Tripod Projection Screen, This durable tripod projection screen from Apollo sets up in seconds. The screen is ideal for computer, video, slide and overhead projections. Keystone eliminator ends distortion problems which occur when screen and projector are on uneven planes, Flame-retardant, Matte white finish, Black 1-inch border, Easy-roll mechanism sets up quickly, Screen measures 70 inches long x 70 inches high, Origin- USA. No warranty', '', '', '', '', '', '', [Rating(average: '2.3')]),

    ];
    return productList;
  }

  List<Product> getRelatedProductList() {
    List<Product> productList = [];
    return productList;
  }
}