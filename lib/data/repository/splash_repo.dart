import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/config_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final SharedPreferences sharedPreferences;
  SplashRepo({@required this.sharedPreferences});

  ConfigModel getConfig() {
    ConfigModel configModel = ConfigModel();
    configModel.currencyList = [];
    configModel.currencyList.add(CurrencyList(id: 1, name: 'SAR', symbol: '﷼',code: 'SAR', exchangeRate: '1.00'));
    configModel.currencyList.add(CurrencyList(id: 2, name: 'USD', symbol: '\$',code: 'USD', exchangeRate: '0.27'));
    return configModel;
  }

  List<String> getLanguageList() {
    List<String> languageList = ['English', 'Bengali', 'Hindi'];
    return languageList;
  }

  void initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    if (!sharedPreferences.containsKey(AppConstants.SEARCH_ADDRESS)) {
      sharedPreferences.setStringList(AppConstants.SEARCH_ADDRESS, []);
    }
    if(!sharedPreferences.containsKey(AppConstants.CURRENCY)) {
      sharedPreferences.setString(AppConstants.CURRENCY, 'SAR');
    }
  }

  String getCurrency() {
    return sharedPreferences.getString(AppConstants.CURRENCY) ?? 'SAR';
  }

  void setCurrency(String currencyCode) {
    sharedPreferences.setString(AppConstants.CURRENCY, currencyCode);
  }

}
