import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/controllers/recommended_Product_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repositories/popular_product_repo.dart';
import 'package:food_delivery_app/data/repositories/recommended_product_repo.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  // Api Client
  Get.lazyPut(() => ApiClient(appBaseurl: AppConstants.APP_BASE_URL));

  // Repositories
  Get.lazyPut(
      () => PopularProductRepo(apiClient: Get.find())); // popularProductRepo
  Get.lazyPut(() =>
      RecommendedProductRepo(apiClient: Get.find())); // recommendedProductRepo

  // Controllers
  Get.lazyPut(() => PopularProductController(
      popularProductRep: Get.find())); // popularProductController
  Get.lazyPut(() => RecommendedProductController(
      recommendedProductRepo: Get.find())); // // recommendedProductController
}
