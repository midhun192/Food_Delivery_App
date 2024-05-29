import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/Screens/auth/sign_in_page.dart';
import 'package:food_delivery_app/Screens/food/popular_food_detail.dart';
import 'package:food_delivery_app/Screens/home/homepage.dart';
import 'package:food_delivery_app/Screens/home/main_food_page.dart';
import 'package:food_delivery_app/Screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Screens/cart/cart_page.dart';
import '../Screens/food/recommended_food_detail.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String initial = "/";
  static String PopularFood = "/popular_food";
  static String RecommendedFood = "/recommended_food";
  static String cartPage = "/cart_Page";
  static String signInPage = "/signIn-Page";

  static String getSplashScreen() => '$splashScreen';
  static String getInitial() => "$initial";
  static String popularFood(int pageID, String previousPage) =>
      "$PopularFood?pageID=$pageID&previousPage=$previousPage";
  static String recommendedFood(int pageID, String previousPage) =>
      "$RecommendedFood?pageID=$pageID&previousPage=$previousPage";
  static String getCartPage() => "$cartPage";
  static String getSignInPage() => "$signInPage";

  static List<GetPage> Routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
      name: PopularFood,
      page: () {
        var pageId = Get.parameters["pageID"];
        var prevPage = Get.parameters["previousPage"];
        return PopularFoodDetail(
            pageId: int.parse(pageId!), prevPage: prevPage!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RecommendedFood,
      page: () {
        var pageId = Get.parameters["pageID"];
        var prevPage = Get.parameters["previousPage"];
        return RecommendedFoodDetail(
            pageId: int.parse(pageId!), prevPage: prevPage!);
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
    GetPage(
      name: signInPage,
      page: () {
        return SignInPage();
      },
      transition: Transition.fade,
    ),
  ];
}
