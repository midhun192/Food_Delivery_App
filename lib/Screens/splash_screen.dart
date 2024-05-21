import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../controllers/popular_product_conroller.dart';
import '../controllers/recommended_Product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  Future<void> _isLoaded() async {
    await Get.find<PopularProductController>().getPopularProductListFromRepo();
    await Get.find<RecommendedProductController>()
        .getRecommendedProductListFromRepo();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoaded();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..forward();
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );

    Timer(Duration(seconds: 3), () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  void dispose() {
    animationController
        .dispose(); // Properly dispose of the AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animationController,
            child: Center(
                child: Image.asset("assets/image/logo part 1.png",
                    width: Dimensions.width250)),
          ),
          Center(
              child: Image.asset("assets/image/logo part 2.png",
                  width: Dimensions.width250)),
        ],
      ),
    );
  }
}
