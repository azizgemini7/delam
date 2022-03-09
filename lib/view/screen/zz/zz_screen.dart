import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/helper/network_info.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/auth_provider.dart';
import 'package:sixvalley_ui_kit/provider/profile_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/basewidget/animated_custom_dialog.dart';
import 'package:sixvalley_ui_kit/view/basewidget/guest_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/cart/cart_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/category/AddCategoryFireBase.dart';
import 'package:sixvalley_ui_kit/view/screen/category/all_category_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/product/addProductFireBase.dart';
import 'package:sixvalley_ui_kit/view/screen/zlang/zlang_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/zz/web_view_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/zz/widget/app_info_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/zz/widget/sign_out_confirmation_dialog.dart';
import 'package:sixvalley_ui_kit/view/screen/zocial/zocial_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/offer/offers_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/profile/profile_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/setting/settings_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/support/support_ticket_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// this page was named "more_screen"

class ZzScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      body: Stack(children: [
        // Background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            Images.more_page_header,
            height: 150,
            fit: BoxFit.fill,
            color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.black : Colors.white,
          ),
        ),

        // AppBar
        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Consumer<ProfileProvider>(
            builder: (context, profile, child) {
              return Row(children: [
                Image.asset(Images.logo_with_name_image, height: 35),
                Expanded(child: SizedBox.shrink()),
                Text(!isGuestMode ? profile.userInfoModel != null ? '${profile.userInfoModel.fName} ${profile.userInfoModel.lName}' : 'Full Name' : 'Guest', style: titilliumRegular.copyWith(color: ColorResources.WHITE)),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                InkWell(
                  onTap: () {
                    if(isGuestMode) {
                      showAnimatedDialog(context, GuestDialog(), isFlip: true);
                    }
                    else {
                      if(Provider.of<ProfileProvider>(context, listen: false).userInfoModel != null) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
                      }
                    }
                  },
                  child: isGuestMode ? CircleAvatar(child: Icon(Icons.person, size: 35)) :
                  profile.userInfoModel == null ? CircleAvatar(child: Icon(Icons.person, size: 35)) : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      profile.userInfoModel.image,
                      width: 35,
                      height: 35,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ]);
            },
          ),
        ),

        // Body
        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getIconBg(context),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              // Top Row Items
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SquareButton(image: Images.shopping_image, title: getTranslated('orders', context), navigateTo: OrderScreen()),
                SquareButton(image: Images.cart_image, title: getTranslated('CART', context), navigateTo: CartScreen()),
                SquareButton(image: Images.offers, title: getTranslated('offers', context), navigateTo: OffersScreen()),
                SquareButton(image: Images.wishlist, title: getTranslated('wishlist', context), navigateTo: WishListScreen()),
              ]),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              // Buttons
              TitleButton(image: Images.more_filled_image, title: "Add Category", navigateTo: AddCategory()),
              TitleButton(image: Images.more_filled_image, title: "Add Product", navigateTo: AddProduct()),
              TitleButton(image: Images.more_filled_image, title: getTranslated('all_category', context), navigateTo: AllCategoryScreen()),
              TitleButton(image: Images.notification_filled, title: getTranslated('notification', context), navigateTo: ZocialScreen()),
              TitleButton(image: Images.chats, title: getTranslated('chats', context), navigateTo: ZlangScreen()),
              TitleButton(image: Images.settings, title: getTranslated('settings', context), navigateTo: SettingsScreen()),
              TitleButton(image: Images.preference, title: getTranslated('support_ticket', context), navigateTo: SupportTicketScreen()),
              TitleButton(image: Images.privacy_policy, title: getTranslated('terms_condition', context), navigateTo: WebViewScreen(
                title: getTranslated('terms_condition', context),
                url: 'https://www.google.com',
              )),
              TitleButton(image: Images.help_center, title: getTranslated('faq', context), navigateTo: WebViewScreen(
                title: getTranslated('faq', context),
                url: 'https://www.google.com',
              )),
              TitleButton(image: Images.about_us, title: getTranslated('about_us', context), navigateTo: WebViewScreen(
                title: getTranslated('about_us', context),
                url: 'https://www.google.com',
              )),
              TitleButton(image: Images.contact_us, title: getTranslated('contact_us', context), navigateTo: WebViewScreen(
                title: getTranslated('contact_us', context),
                url: 'https://www.google.com',
              )),
              ListTile(
                leading: Image.asset(Images.logo_image, width: 25, height: 25, fit: BoxFit.fill, color: ColorResources.getPrimary(context)),
                title: Text(getTranslated('app_info', context), style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                onTap: () => showAnimatedDialog(context, AppInfoDialog(), isFlip: true),
              ),
              isGuestMode
                  ? SizedBox()
                  : ListTile(
                      leading: Icon(Icons.exit_to_app, color: ColorResources.getPrimary(context), size: 25),
                      title: Text(getTranslated('sign_out', context), style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                      onTap: () => showAnimatedDialog(context, SignOutConfirmationDialog(), isFlip: true),
                    ),
            ]),
          ),
        ),
      ]),

      // Zexpo screen Icon
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.book_online_rounded),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/product/Jjvg5p3aRMjJqseJbNAg/TShirts')
              .snapshots()
              .listen((data) {
            data.docs.forEach((document) {
              print(document['Tshirt']);
            });
          });
        },),
    );
  }

}

class SquareButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;

  SquareButton({@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResources.getPrimary(context),
          ),
          child: Image.asset(image, color: Theme.of(context).accentColor),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: titilliumRegular),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  TitleButton({@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image, width: 25, height: 25, fit: BoxFit.fill, color: ColorResources.getPrimary(context)),
      title: Text(title, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () => Navigator.push(
        context,
          /*PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
              return ScaleTransition(scale: animation, child: child, alignment: Alignment.center);
            },
          ),*/
        MaterialPageRoute(builder: (_) => navigateTo),
      ),
    );
  }
}

