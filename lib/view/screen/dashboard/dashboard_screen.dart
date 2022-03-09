import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/product_model.dart';
import 'package:sixvalley_ui_kit/data/repository/auth_repo.dart';
import 'package:sixvalley_ui_kit/data/repository/product_repo.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';
import 'package:sixvalley_ui_kit/provider/localization_provider.dart';
import 'package:sixvalley_ui_kit/provider/splash_provider.dart';
import 'package:sixvalley_ui_kit/provider/theme_provider.dart';
import 'package:sixvalley_ui_kit/utill/images.dart';
import 'package:sixvalley_ui_kit/view/screen/zlang/zlang_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/dashboard/widget/fancy_bottom_nav_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/delam/delam_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/zz/zz_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/zocial/zocial_screen.dart';
import 'package:sixvalley_ui_kit/view/screen/order/order_screen.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget {

  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    DelamScreen(),
    ZocialScreen(isBacButtonExist: false),
  //  OrderScreen(isBacButtonExist: false),
    ZlangScreen(isBackButtonExist: false),
    ZzScreen(),
  ];
  final GlobalKey<FancyBottomNavBarState> _bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int _pageIndex;
    if(Provider.of<SplashProvider>(context, listen: false).fromSetting) {
      _pageIndex = 4;
    }
    else {
      _pageIndex = 0;
    }

    return WillPopScope(
      onWillPop: () async {
        if(_pageIndex != 0) {
          _bottomNavKey.currentState.setPage(0);
          return false;
        }
        else {
          return true;
        }
      },
      child: Scaffold(
          bottomNavigationBar: FancyBottomNavBar(
            key: _bottomNavKey,
            initialSelection: _pageIndex,
            isLtr: Provider.of<LocalizationProvider>(context).isLtr,
            isDark: Provider.of<ThemeProvider>(context).darkTheme,
            tabs: [
              FancyTabData(imagePath: Images.shopping_image, title: getTranslated('DELAM', context)),
              FancyTabData(imagePath: Images.zocial_image, title: getTranslated('ZOCIAL', context)),
            //  FancyTabData(imagePath:Images.shopping_image, title: getTranslated('orders', context)),
               FancyTabData(imagePath: Images.zlang_image, title: getTranslated('ZLANG', context)),
              FancyTabData(imagePath: Images.zz_image, title: getTranslated('ZZ', context)),
            ],
            onTabChangedListener: (int index) {
              _pageController.jumpToPage(index);
              _pageIndex = index;
            },
          ),
          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return _screens[index];
            },
          ),
        ),
      );
  }
}