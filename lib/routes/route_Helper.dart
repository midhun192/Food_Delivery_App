import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/Screens/food/popular_food_detail.dart';
import 'package:food_delivery_app/Screens/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Screens/cart/cart_page.dart';
import '../Screens/food/recommended_food_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static String PopularFood = "/popular_food";
  static String RecommendedFood = "/recommended_food";
  static String cartPage = "/cart_Page";

  static String getInitial() => "$initial";
  static String popularFood(int pageID) => "$PopularFood?pageID=$pageID";
  static String recommendedFood(int pageID) =>
      "$RecommendedFood?pageID=$pageID";
  static String getCartPage() => "$cartPage";

  static List<GetPage> Routes = [
    GetPage(name: initial, page: () => const MainFoodPage()),
    GetPage(
      name: PopularFood,
      page: () {
        var pageId = Get.parameters["pageID"];
        return PopularFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RecommendedFood,
      page: () {
        var pageId = Get.parameters["pageID"];
        return RecommendedFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    ),
  ];
}
