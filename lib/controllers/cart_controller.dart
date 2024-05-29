import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/repositories/cart_repo.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../utils/Colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  CartController({required this.cartRepo});

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          description: value.description,
          img: value.img,
          isExist: true,
          price: value.price,
          quantity: value.quantity! + quantity,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            description: product.description,
            img: product.img,
            isExist: true,
            price: product.price,
            quantity: quantity,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "Item Count",
          "You need to Add atleast One Item in your Cart!",
          colorText: Colors.white,
          backgroundColor: AppColors.mainColor,
        );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool isExist(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalQuantity {
    var totalQty = 0;
    _items.forEach((key, value) {
      totalQty += value.quantity!;
    });
    return totalQty;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalPrice {
    int total = 0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    // print("length of cart in storage is " + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addCartHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartListHistory() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistoryList() {
    cartRepo.clearCartHistory();
    update();
  }
}
