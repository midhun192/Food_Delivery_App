import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/controllers/recommended_Product_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repositories/auth_repo.dart';
import 'package:food_delivery_app/data/repositories/popular_product_repo.dart';
import 'package:food_delivery_app/data/repositories/recommended_product_repo.dart';
import 'package:food_delivery_app/data/repositories/user_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../data/repositories/cart_repo.dart';

Future<void> init() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPrefs);
  // Api Client
  Get.lazyPut(() => ApiClient(
      appBaseurl: AppConstants.APP_BASE_URL, sharedPreferences: Get.find()));
  // Auth Repo
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // User Repo
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  // Repositories
  Get.lazyPut(
      () => PopularProductRepo(apiClient: Get.find())); // popularProductRepo
  Get.lazyPut(() =>
      RecommendedProductRepo(apiClient: Get.find())); // recommendedProductRepo
  Get.lazyPut(() => CartRepo(sharedPrefs: Get.find()));

  // Controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find())); // authController
  Get.lazyPut(() => UserController(userRepo: Get.find())); // User Controller
  Get.lazyPut(() => PopularProductController(
      popularProductRep: Get.find())); // popularProductController
  Get.lazyPut(() => RecommendedProductController(
      recommendedProductRepo: Get.find())); // recommendedProductController
  Get.lazyPut(() => CartController(cartRepo: Get.find())); // cartController
}
