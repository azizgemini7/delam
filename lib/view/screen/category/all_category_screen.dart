import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/category.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/category_provider.dart';
import 'package:sixvalley_ui_kit/provider/product_firebase_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/view/screen/product/product_details_firebase.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/product_Screen.dart';

class AllCategoryScreen extends StatefulWidget {
  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  Future futureMethod;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMethod = getData();
  }

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('CATEGORY', context)),
          Expanded(child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return categoryProvider.categoryList.length != 0
                  ? Row(children: [
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(top: 3),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 1,
                                blurRadius: 1)
                          ],
                        ),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: categoryProvider.categoryList.length,
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            Category _category =
                                categoryProvider.categoryList[index];
                            return InkWell(
                              onTap: () {
                                Provider.of<CategoryProvider>(context,
                                        listen: false)
                                    .changeSelectedIndex(index);
                                // Provider.of<ProductFirebaseProvider>(context, listen: false).loadCategoryProducts(categoryId: Provider.of<CategoryProvider>(context, listen: false).categorySelectedIndex);
                              },
                              child: CategoryItem(
                                title: _category.name,
                                icon: _category.icon,
                                isSelected:
                                    categoryProvider.categorySelectedIndex == index,
                              ),
                            );
                          },
                        ),
                      ),

                      Expanded(child: futureBody(categoryProvider , categoryProvider)),

                      ///
                      // Expanded(child: ListView.builder(
                      //   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      //   // itemCount: 1,
                      //   itemCount: Provider.of<ProductFirebaseProvider>(context, listen: false).productsList != null ? Provider.of<ProductFirebaseProvider>(context, listen: false).productsList.length + 1 : 1
                      //   // itemCount: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories != null ? categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories.length + 1 : 1
                      //   ,
                      //   itemBuilder: (context, index) {
                      //
                      //     List<Product> products;
                      //     if(index != 0) {
                      //       products = Provider.of<ProductFirebaseProvider>(context, listen: false).loadCategoryProductsCat(categoryId: Provider.of<CategoryProvider>(context, listen: false).categorySelectedIndex);
                      //     }
                      //     if(index == 0) {
                      //       return Ink(
                      //         color: Theme.of(context).accentColor,
                      //         child: ListTile(
                      //           title: Text(getTranslated('all', context), style: titilliumSemiBold, maxLines: 2, overflow: TextOverflow.ellipsis),
                      //           trailing: Icon(Icons.navigate_next),
                      //           onTap: () {
                      //             Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                      //               isBrand: false,
                      //               id: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].id.toString(),
                      //               name: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].name,
                      //             )));
                      //           },
                      //         ),
                      //       );
                      //     }
                      //     else if (Provider.of<ProductFirebaseProvider>(context, listen: false).productsList.length != 0) {
                      //     // else if (_subCategory.subSubCategories.length != 0) {
                      //       return Ink(
                      //         color: Theme.of(context).accentColor,
                      //         child: Theme(
                      //           data: Provider.of<ThemeProvider>(context).darkTheme ? ThemeData.dark() : ThemeData.light(),
                      //           child: Column(
                      //             // key: Key('${Provider.of<CategoryProvider>(context).categorySelectedIndex}$index'),
                      //             // title: Text(Provider.of<ProductFirebaseProvider>(context, listen: true).productsList[index-1].name, style: titilliumSemiBold.copyWith(color: Theme.of(context).textTheme.bodyText1.color), maxLines: 2, overflow: TextOverflow.ellipsis),
                      //             // title: Text(_subCategory.name, style: titilliumSemiBold.copyWith(color: Theme.of(context).textTheme.bodyText1.color), maxLines: 2, overflow: TextOverflow.ellipsis),
                      //             children: _getProductFromCategories(context,Provider.of<ProductFirebaseProvider>(context, listen: false).productsList ),
                      //             // children: _getSubSubCategories(context, _subCategory),
                      //           ),
                      //         ),
                      //       );
                      //     }
                      //     else {
                      //       return Ink(
                      //         color: Theme.of(context).accentColor,
                      //         child: ListTile(
                      //           title: Text("_subCategory.name", style: titilliumSemiBold, maxLines: 2, overflow: TextOverflow.ellipsis),
                      //           trailing: Icon(Icons.navigate_next, color: Theme.of(context).textTheme.bodyText1.color),
                      //           onTap: () {
                      //             Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                      //               isBrand: false,
                      //               id: _subCategory.id.toString(),
                      //               name: _subCategory.name,
                      //             )));
                      //           },
                      //         ),
                      //       );
                      //     }
                      //
                      //   },
                      // )),
                    ])
                  : Center(child: CircularProgressIndicator());
            },
          )),
        ],
      ),
    );
  }

  Widget futureBody(categoryProvider ,CategoryProvider category) {
    return FutureBuilder(
        future: getData(),
        // ignore: missing_return
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            print("${snapshots.error}");
            return Text(
              "There is Error",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 22),
            );
          }
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircularProgressIndicator(),
                  Text(
                    // "${translator.translate('loading')}",
                    "",
                    style: TextStyle(fontSize: 23),
                  )
                ],
              ));

            case ConnectionState.done:
              return ListView.builder(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                // itemCount: 1,
                itemCount:
                    Provider.of<ProductFirebaseProvider>(context, listen: true)
                                .productsList !=
                            null
                        ? Provider.of<ProductFirebaseProvider>(context,
                                    listen: true)
                                .productsList
                                .length +
                            1
                        : 1
                // itemCount: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories != null ? categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories.length + 1 : 1
                ,
                itemBuilder: (context, index) {


                  if (index == 0) {
                    return Ink(
                      color: Theme.of(context).accentColor,
                      child: ListTile(
                        title: Text(getTranslated('all', context),
                            style: titilliumSemiBold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        trailing: Icon(Icons.navigate_next),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => BrandAndCategoryProductScreen(
                          //               isBrand: false,
                          //               id: categoryProvider
                          //                   .categoryList[categoryProvider
                          //                       .categorySelectedIndex]
                          //                   .id
                          //                   .toString(),
                          //               name: categoryProvider
                          //                   .categoryList[categoryProvider
                          //                       .categorySelectedIndex]
                          //                   .name,
                          //             )));
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ListProductsScreen(
                            isBrand: false,
                            id: category.categoryList[category.categorySelectedIndex].id.toString(),
                            name: category.categoryList[category.categorySelectedIndex].name,
                          )));

                        },
                      ),
                    );
                  } else if (Provider.of<ProductFirebaseProvider>(context, listen: false).productsList.length != 0) {
                    // else if (_subCategory.subSubCategories.length != 0) {
                    // return Ink(
                    //   color: Theme.of(context).accentColor,
                    //   child: Theme(
                    //       data: Provider.of<ThemeProvider>(context).darkTheme
                    //           ? ThemeData.dark()
                    //           : ThemeData.light(),
                    //       child: ListView.builder(
                    //           shrinkWrap: true,
                    //           itemCount: Provider.of<ProductFirebaseProvider>(context, listen: true).productsList.length,
                    //           itemBuilder: (context, index) {
                    //             final _product =
                    //                 Provider.of<ProductFirebaseProvider>(
                    //                         context,
                    //                         listen: true)
                    //                     .productsList[index];
                    //             print("index ${index}");
                    //             return Card(
                    //                 child: Container(
                    //               // color: ColorResources.getIconBg(context),
                    //               margin: EdgeInsets.symmetric(
                    //                   horizontal:
                    //                       Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    //               child: ListTile(
                    //                 title: Row(
                    //                   children: [
                    //                     Container(
                    //                       height: 7,
                    //                       width: 7,
                    //                       decoration: BoxDecoration(
                    //                           color: ColorResources.getPrimary(
                    //                               context),
                    //                           shape: BoxShape.circle),
                    //                     ),
                    //                     if (_product.images != null &&
                    //                         _product.images.isNotEmpty)
                    //                       Container(
                    //                         height: 35,
                    //                         width: 35,
                    //                         child: Image.network(
                    //                             "${_product.images.first}"),
                    //                       ),
                    //                     SizedBox(
                    //                         width:
                    //                             Dimensions.PADDING_SIZE_SMALL),
                    //                     Flexible(
                    //                         child: Text(
                    //                       _product.name,
                    //                       style: titilliumSemiBold.copyWith(
                    //                           color: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyText1
                    //                               .color),
                    //                       maxLines: 2,
                    //                       overflow: TextOverflow.ellipsis,
                    //                     )),
                    //                   ],
                    //                 ),
                    //                 onTap: () {
                    //                   Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (_) =>
                    //                               BrandAndCategoryProductScreen(
                    //                                 isBrand: false,
                    //                                 id: _product.id.toString(),
                    //                                 name: _product.name,
                    //                               )));
                    //                 },
                    //               ),
                    //             ));
                    //           })
                    //
                    //       // Column(
                    //       //   children: _getProductFromCategories(context,Provider.of<ProductFirebaseProvider>(context, listen: true).productsList ),
                    //       //   // children: _getSubSubCategories(context, _subCategory),
                    //       // ),
                    //       ),
                    // );
                   final _product = Provider.of<ProductFirebaseProvider>(context, listen: true).productsList[index-1];
                    return Card(
                        child: Container(
                          // color: ColorResources.getIconBg(context),
                          margin: EdgeInsets.symmetric(
                              horizontal:
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: ListTile(
                            title: Row(
                              children: [
                                Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                      color: ColorResources.getPrimary(
                                          context),
                                      shape: BoxShape.circle),
                                ),
                                if (_product.images != null && _product.images.isNotEmpty && _product.images.first != null)
                                  Container(
                                    height: 35,
                                    width: 35,
                                    child: Image.network("${_product.images.first}"),
                                  ),
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                Flexible(
                                    child: Text(
                                      _product.name,
                                      style: titilliumSemiBold.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(context, PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 1000),
                                pageBuilder: (context, anim1, anim2) => ProductDetailsFireBase(product: _product),
                              ));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) =>
                              //             BrandAndCategoryProductScreen(
                              //               isBrand: false,
                              //               id: _product.id.toString(),
                              //               name: _product.name,
                              //             )));
                            },
                          ),
                        ));
                  } else {
                    return Ink(
                      color: Theme.of(context).accentColor,
                      child: ListTile(
                        title: Text("_subCategory.name",
                            style: titilliumSemiBold,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        trailing: Icon(Icons.navigate_next,
                            color: Theme.of(context).textTheme.bodyText1.color),
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
                          //   isBrand: false,
                          //   id: _subCategory.id.toString(),
                          //   name: _subCategory.name,
                          // )));
                        },
                      ),
                    );
                  }
                },
              );
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
          }
        });
  }

  Future getData() async {
    await Provider.of<ProductFirebaseProvider>(context, listen: false)
        .loadCategoryProducts(
            categoryId: Provider.of<CategoryProvider>(context, listen: false)
                .categorySelectedIndex);
  }

  // List<Widget> _getProductFromCategories(BuildContext context, List<Product> subCategory) {
  //   List<Widget> _subSubCategories = [];
  //   // _subSubCategories.add(
  //   //     Card(
  //   //   color: Colors.white,
  //   //   child: Container(
  //   //     // color: ColorResources.getIconBg(context),
  //   //     margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
  //   //     child: ListTile(
  //   //       title: Row(
  //   //         children: [
  //   //           Container(
  //   //             height: 7,
  //   //             width: 7,
  //   //             decoration: BoxDecoration(color: ColorResources.getPrimary(context), shape: BoxShape.circle),
  //   //           ),
  //   //           SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
  //   //           Flexible(child: Text(getTranslated('all', context), style: titilliumSemiBold.copyWith(
  //   //               color: Theme.of(context).textTheme.bodyText1.color), maxLines: 2, overflow: TextOverflow.ellipsis,
  //   //           )),
  //   //         ],
  //   //       ),
  //   //       onTap: () {
  //   //         Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
  //   //           isBrand: false,
  //   //           id: subCategory.id.toString(),
  //   //           name: subCategory.name,
  //   //         )));
  //   //       },
  //   //     ),
  //   //   ),
  //   // )
  //   // );
  //   for(int index=0; index < subCategory.length; index++) {
  //     _subSubCategories.add(
  //         ,
  //     ));
  //   }
  //   return _subSubCategories;
  // }

  List<Widget> _getSubSubCategories(
      BuildContext context, SubCategory subCategory) {
    List<Widget> _subSubCategories = [];
    _subSubCategories.add(Container(
      color: ColorResources.getIconBg(context),
      margin:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: ListTile(
        title: Row(
          children: [
            Container(
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                  color: ColorResources.getPrimary(context),
                  shape: BoxShape.circle),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
            Flexible(
                child: Text(
              getTranslated('all', context),
              style: titilliumSemiBold.copyWith(
                  color: Theme.of(context).textTheme.bodyText1.color),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BrandAndCategoryProductScreen(
                        isBrand: false,
                        id: subCategory.id.toString(),
                        name: subCategory.name,
                      )));
        },
      ),
    ));
    for (int index = 0; index < subCategory.subSubCategories.length; index++) {
      _subSubCategories.add(Container(
        color: ColorResources.getIconBg(context),
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: ListTile(
          title: Row(
            children: [
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                    color: ColorResources.getPrimary(context),
                    shape: BoxShape.circle),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Flexible(
                  child: Text(
                subCategory.subSubCategories[index].name,
                style: titilliumSemiBold.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BrandAndCategoryProductScreen(
                          isBrand: false,
                          id: subCategory.subSubCategories[index].id.toString(),
                          name: subCategory.subSubCategories[index].name,
                        )));
          },
        ),
      ));
    }
    return _subSubCategories;
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;

  CategoryItem(
      {@required this.title, @required this.icon, @required this.isSelected});

  Widget build(BuildContext context) {

    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? ColorResources.getPrimary(context) : null,
      ),
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              if(icon != null)
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: isSelected
                      ? Theme.of(context).accentColor
                      : Theme.of(context).hintColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),

              ///MALAS

              child: Image.network(
                // child: Image.asset(
                icon,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  color: isSelected
                      ? Theme.of(context).accentColor
                      : Theme.of(context).hintColor,
                )),
          ),
        ]),
      ),
    );
  }
}
