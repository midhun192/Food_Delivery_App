import 'dart:convert';

import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPrefs;
  CartRepo({required this.sharedPrefs});

  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    /*sharedPrefs.remove(AppConstants.CART_LIST);
    sharedPrefs.remove(AppConstants.CART_HISTORY_LIST);*/
    cart = [];
    DateTime time = DateTime.now();
    cartList.forEach((element) {
      element.time = time.toString();
      return cart.add(jsonEncode(element));
    });
    sharedPrefs.setStringList(AppConstants.CART_LIST, cart);
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPrefs.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPrefs.getStringList(AppConstants.CART_LIST)!;
      print("from storage: " + carts.toString());
    }
    List<CartModel> cartList = [];
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPrefs.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory = sharedPrefs.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartHistoryList = [];
    cartHistory.forEach((element) =>
        cartHistoryList.add(CartModel.fromJson(jsonDecode(element))));
    return cartHistoryList;
  }

  void addToCartHistoryList() {
    if (sharedPrefs.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = sharedPrefs.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("cart hsitory is " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPrefs.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("cart history length is " + getCartHistoryList().length.toString());
    for (int j = 0; j < getCartHistoryList().length; j++) {
      print("cart history product time is " +
          getCartHistoryList()[j].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPrefs.remove(AppConstants.CART_LIST);
  }
}
