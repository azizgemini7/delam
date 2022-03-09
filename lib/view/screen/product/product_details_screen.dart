import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/product_details_provider.dart';
import 'package:sixvalley_ui_kit/provider/product_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/provider/wishlist_provider.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/title_row.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/bottom_cart_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/product_image_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/product_specification_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/product_title_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/related_product_view.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/review_widget.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_ui_kit/view/screen/product/widget/seller_view.dart';

import 'faq_and_review_screen.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  ProductDetails({@required this.product});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductDetailsProvider>(context, listen: false).removePrevReview();
    Provider.of<ProductDetailsProvider>(context, listen: false).initProduct(product);
    Provider.of<WishListProvider>(context, listen: false).checkWishList(product.id.toString());
    Provider.of<ProductProvider>(context, listen: false).removePrevRelatedProduct();
    Provider.of<ProductProvider>(context, listen: false).initRelatedProductList();
    Provider.of<ProductDetailsProvider>(context, listen: false).getCount(product.id.toString());
    Provider.of<ProductDetailsProvider>(context, listen: false).getSharableLink(product.id.toString());
    NetworkInfo.checkConnectivity(context);

    return Consumer<ProductDetailsProvider>(
      builder: (context, details, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(children: [
              InkWell(
                child: Icon(Icons.arrow_back_ios, color: Theme.of(context).textTheme.bodyText1.color, size: 20),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Text(getTranslated('product_details', context), style: robotoRegular.copyWith(fontSize: 20, color: Theme.of(context).textTheme.bodyText1.color)),
            ]),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Colors.white.withOpacity(0.5),
          ),

          bottomNavigationBar: BottomCartView(product: product),

          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                ProductImageView(productModel: product),

                ProductTitleView(productModel: product),

                // Coupon
                /*Container(
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: ColorResources.WHITE,
                  child: CouponView(),
                ),*/

                // Seller
                product.addedBy == 'seller' ? SellerView(sellerId: product.userId) : SizedBox.shrink(),

                // Specification
                Container(
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  color: Theme.of(context).accentColor,
                  child: ProductSpecification(productSpecification: product.details ?? ''),
                ),

                // Product variant
                /*Container(
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: ColorResources.WHITE,
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(child: Text(Strings.product_variants, style: robotoBold)),
                        Text(Strings.details, style: titilliumRegular.copyWith(
                          color: ColorResources.SELLER_TXT,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                        )),
                      ]),
                      SizedBox(height: 5),
                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          itemCount: product.colors.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            String colorString = '0xff' + product.colors[index].substring(1, 7);
                            return Container(
                              width: 45,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(int.parse(colorString))),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),*/

                // Reviews
                Container(
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  color: Theme.of(context).accentColor,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    TitleRow(title: getTranslated('reviews', context)+'(${details.reviewList != null ? details.reviewList.length : 0})', isDetailsPage: true, onTap: () {
                      if(details.reviewList != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewScreen(reviewList: details.reviewList)));
                      }
                    }),
                    Divider(),
                    details.reviewList != null ? details.reviewList.length > 0 ? ReviewWidget(reviewModel: details.reviewList[0])
                        : Center(child: Text('No Review')) : ReviewShimmer(),
                  ]),
                ),

                // Related Products
                Container(
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  color: Theme.of(context).accentColor,
                  child: Column(
                    children: [
                      TitleRow(title: getTranslated('related_products', context), isDetailsPage: true),
                      SizedBox(height: 5),
                      RelatedProductView(),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}

