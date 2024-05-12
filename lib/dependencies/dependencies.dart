import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/controllers/recommended_Product_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repositories/popular_product_repo.dart';
import 'package:food_delivery_app/data/repositories/recommended_product_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../data/repositories/cart_repo.dart';

Future<void> init() async {
  // Api Client
  Get.lazyPut(() => ApiClient(appBaseurl: AppConstants.APP_BASE_URL));

  // Repositories
  Get.lazyPut(
      () => PopularProductRepo(apiClient: Get.find())); // popularProductRepo
  Get.lazyPut(() =>
      RecommendedProductRepo(apiClient: Get.find())); // recommendedProductRepo
  Get.lazyPut(() => CartRepo()); // cartRepo

  // Controllers
  Get.lazyPut(() => PopularProductController(
      popularProductRep: Get.find())); // popularProductController
  Get.lazyPut(() => RecommendedProductController(
      recommendedProductRepo: Get.find())); // recommendedProductController
  Get.lazyPut(() => CartController(cartRepo: Get.find())); // cartController
}
