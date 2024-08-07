import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/repositories/popular_product_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';
import '../utils/Colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRep;
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  late SharedPreferences _prefs;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  late CartController _cart;

  List<ProductModel> _favourites = [];
  List<ProductModel> get favourites => _favourites;

  PopularProductController({required this.popularProductRep});

  @override
  void onInit() {
    super.onInit();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFavorites();
  }

  Future<void> getPopularProductListFromRepo() async {
    Response response = await popularProductRep.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      update();
      _isLoaded = true;
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int Quantity) {
    if ((_inCartItems + Quantity) < 0) {
      Get.snackbar(
        "Item Count",
        "You Can't Reduce anymore Items!",
        colorText: Colors.white,
        backgroundColor: AppColors.mainColor,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + Quantity) > 20) {
      Get.snackbar(
        "Item Count",
        "You Can't Add More Items!",
        colorText: Colors.white,
        backgroundColor: AppColors.mainColor,
      );
      return 20;
    } else {
      return Quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.isExist(product);
    print("Exist or not : " + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    // if (_quantity > 0) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("the id is " +
          value.id.toString() +
          " quantity is " +
          value.quantity.toString());
    });
    update();
    // } else {
    //   Get.snackbar(
    //     "Item Count",
    //     "You need to Add atleast One Item in your Cart!",
    //     colorText: Colors.white,
    //     backgroundColor: AppColors.mainColor,
    //   );
    // }
  }

  int get totalItems {
    return _cart.totalQuantity;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }

  // void addFavorite(ProductModel product) {
  //   _favourites.add(product);
  //   update();
  // }
  //
  // void removeFavorite(ProductModel product) {
  //   _favourites.remove(product);
  //   update();
  // }
  //
  // bool isFavorite(ProductModel product) {
  //   return _favourites.contains(product);
  // }
  //
  // void toggleFavorite(ProductModel product) {
  //   if (isFavorite(product)) {
  //     removeFavorite(product);
  //   } else {
  //     addFavorite(product);
  //   }
  // }

  void addFavorite(ProductModel product) {
    if (!_favourites.contains(product)) {
      _favourites.add(product);
      _saveFavorites();
      update();
    }
  }

  void removeFavorite(ProductModel product) {
    if (_favourites.contains(product)) {
      _favourites.remove(product);
      _saveFavorites();
      update();
    }
  }

  bool isFavorite(ProductModel product) {
    return _favourites.contains(product);
  }

  void toggleFavorite(ProductModel product) {
    if (isFavorite(product)) {
      removeFavorite(product);
    } else {
      addFavorite(product);
    }
  }

  void _saveFavorites() {
    List<String> favoritesJson =
        _favourites.map((e) => jsonEncode(e.toJson())).toList();
    _prefs.setStringList("favorites", favoritesJson);
  }

  void _loadFavorites() {
    List<String>? favoritesJson = _prefs.getStringList("favorites");
    if (favoritesJson != null) {
      _favourites = favoritesJson
          .map((e) => ProductModel.fromJson(jsonDecode(e)))
          .toList();
      update();
    }
  }

  void clearFavorites() {
    _favourites.clear();
    _prefs.remove("favorites");
    update();
  }
}
