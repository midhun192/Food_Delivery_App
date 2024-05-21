import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/cart/cart_page.dart';
import 'package:food_delivery_app/Screens/food/popular_food_detail.dart';
import 'package:food_delivery_app/Screens/food/recommended_food_detail.dart';
import 'package:food_delivery_app/Screens/home/main_food_page.dart';
import 'package:food_delivery_app/Screens/splash_screen.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/controllers/recommended_Product_controller.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'dependencies/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: const SplashScreen(),
          initialRoute: RouteHelper.getSplashScreen(),
          getPages: RouteHelper.Routes,
        );
      });
    });
  }
}
