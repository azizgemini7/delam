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
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/dashboard_screen.dart';

/// AddCategory

class AddCategory extends StatefulWidget {
  const AddCategory({Key key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoryName = TextEditingController();

  void validateAndSave(BuildContext context ,bool idUpload) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
      if(idUpload != null && idUpload){
        getImageFromGallery(context);
      }else{
        Provider.of<ProductFirebaseProvider>(context, listen: false).addCategory(
            CategoryFireBase(
              name: categoryName.text,
              icon: imgValue
            )
        );
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

                      /// category Name Name
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: categoryName,
                          decoration: InputDecoration(labelText: 'Category Name'),
                          validator: (value) => value.isEmpty ? 'Category Name cannot be blank'  : null,
                          // validator: (value) => value.isEmpty ? 'Product Name cannot be blank' : value.contains("@") ? null : 'Please add a valid email',
                          // onSaved: (value) => productName = value,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // MaterialButton(
                          //   color: ColorResources.getPrimary(context),
                          //   child: Text(
                          //     'Upload Image',
                          //     style: TextStyle(fontSize: 20.0),
                          //   ),
                          //   onPressed: () async {
                          //     await validateAndSave(context , true);
                          //   },
                          //   // onPressed: validateAndSave,
                          // ),

                          MaterialButton(
                            color: ColorResources.getPrimary(context),
                            child: Text(
                              'Add Category',
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
