import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/data/repositories/popular_product_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

import '../utils/Colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRep;
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  late CartController _cart;

  PopularProductController({
    required this.popularProductRep,
  });

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
}
