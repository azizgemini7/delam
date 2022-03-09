import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
// import 'package:sixvalley_ui_kit/data/model/response/categoryFireBase.dart';
import 'package:sixvalley_ui_kit/error/database_failure.dart';

class CategoryRepo {

  FirebaseFirestore _fs;

  // CategoryRepo(this._fs);

  List<Category> getCategoryList() {
    List<Category> categoryList = [
      // Category(id: 1, name: 'أزياء وثقافات', icon: 'assets/images/category.png', subCategories: [SubCategory(id: 9, name: 'Headphone', subSubCategories: [SubSubCategory(id: 10, name: 'Earphone', position: '1')])]),
      // Category(id: 2, name: 'مأكل ومشرب', icon: 'assets/images/category1.png', subCategories: []),
      // Category(id: 3, name: 'رعاية صحية', icon: 'assets/images/category2.png', subCategories: []),
      // Category(id: 4, name: 'إلكترونيات وأثاث', icon: 'assets/images/category3.png', subCategories: []),
      // Category(id: 5, name: 'توفير وتقييم', icon: 'assets/images/category4.png', subCategories: []),
      // Category(id: 6, name: 'إمداد وجملة', icon: 'assets/images/category5.png', subCategories: []),
      // Category(id: 7, name: 'أسهم وتداول', icon: 'assets/images/category6.png', subCategories: []),
      // Category(id: 8, name: 'مشاريع وتطوير', icon: 'assets/images/category7.png', subCategories: []),
    ];
    return categoryList;
  }


  Future<List<Category>> getAllCategory() async {
    try {
      var data = await FirebaseFirestore.instance.collection('Category').get();
      List<Category> category = data.docs.map((e) => Category.fromJson(e.data())).toList();
      return category;
    } on FirebaseException catch (e) {
      return null;
    }
  }

}

/*


imagePath


https://firebasestorage.googleapis.com/v0/b/delam-302308.appspot.com/o/Products%2FCategory%2Fcategory7.png?alt=media&token=f574ee8f-742b-4d0d-952a-2340f0a999a5




 */