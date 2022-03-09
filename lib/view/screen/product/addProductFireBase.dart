import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/provider/category_provider.dart';
import 'package:sixvalley_ui_kit/provider/product_firebase_provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';

/// AddProduct

class AddProduct extends StatefulWidget {
  const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController productName = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController rate = TextEditingController();
  String discountType ;
  // List<Category> listCategory = [];
  Category categorySelected ;
  // TextEditingController productName = TextEditingController();
  // TextEditingController productName = TextEditingController();
///
  void validateAndSave(BuildContext context ,bool idUpload) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
      if(idUpload != null && idUpload){
        getImageFromGallery(context);
      }else{
        Provider.of<ProductFirebaseProvider>(context, listen: false).addProduct(
            ProductFireBase(
              name: "${productName.text}",
              unitPrice: "${price.text}",
              categoryId: categorySelected.id,
              discount: "${discount.text}",
              images: [imgValue],
              discountType: "${discountType}",
              rate: "${rate.text}",
            )
        );
        // Provider.of<SplashProvider>(context, listen: false).
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => DashBoardScreen()), (route) => false);
      }

    } else {
      print('Form is invalid');
    }
  }
///
  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false).loadAllCategory();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:ColorResources.getPrimary(context),
        title: Text("Add Product"),
      ),
      body: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
          return Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  /// Product Name
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: productName,
                      decoration: InputDecoration(labelText: 'Product Name'),
                      validator: (value) => value.isEmpty ? 'Product Name cannot be blank'  : null,
                      // validator: (value) => value.isEmpty ? 'Product Name cannot be blank' : value.contains("@") ? null : 'Please add a valid email',
                      // onSaved: (value) => productName = value,
                    ),
                  ),
                  /// Price
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: price,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Unit Price'),

                      validator: (value) => value.isEmpty || num.tryParse(value) == null  ? 'Price cannot be blank or not number' : null,
                      // onSaved: (value) => _password = value,
                    ),
                  ),
                  /// discount
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: discount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Discount'),

                      validator: (value) => value.isEmpty || num.tryParse(value) == null  ? 'Price cannot be blank or not number' : null,
                      // onSaved: (value) => _password = value,
                    ),
                  ),
                  /// discount Type
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<String>(
                      // underline: SizedBox,
                      hint: Text(
                        "Discount Type"
                      ),
                      value: discountType,
                      items: <String>["percent" ,"amount"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        discountType = value ;
                      },
                    ),
                  ),

                  /// category
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<Category>(
                      // underline: SizedBox,
                      hint: Text(
                          "Category"
                      ),
                      value: categorySelected,
                      items: categoryProvider.categoryList.map((Category value) {
                        return DropdownMenuItem<Category>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        categorySelected = value ;
                      },
                    ),
                  ),
                  /// Rate
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: rate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Rate (1 - 5)'),

                      validator: (value) => value.isEmpty || num.tryParse(value) == null  ? 'Price cannot be blank or not number' : null,
                      // onSaved: (value) => _password = value,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Upload Image
                      // MaterialButton(
                      //   color: ColorResources.getPrimary(context),
                      //   child: Text(
                      //     'Upload Image',
                      //     style: TextStyle(fontSize: 20.0),
                      //   ),
                      //   onPressed: () async {
                      //     await validateAndSave(context , true);
                      //
                      //   },
                      //   // onPressed: validateAndSave,
                      // ),

                      MaterialButton(
                        color: ColorResources.getPrimary(context),
                        child: Text(
                          'Add Product',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () async {
                          await validateAndSave(context , false);
                        },
                        // onPressed: validateAndSave,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }
  File _image;
  final _picker = ImagePicker();
  var imgValue;

  Future getImageFromGallery(BuildContext context) async {

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      final File image = File(pickedFile.path);
      //  File image = await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _image = image;
      });

   await uploadImageToFirebase(context);
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {

    String fileName = basename(_image.path);

    FirebaseStorage firebaseStorageRef = FirebaseStorage.instance;

    Reference ref =firebaseStorageRef.ref().child('upload/$fileName'+ DateTime.now().toString());

// FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = ref.putFile(_image);

    uploadTask.then((res) {res.ref.getDownloadURL().then((value) {
      imgValue = value ;

    });});
  }
}
