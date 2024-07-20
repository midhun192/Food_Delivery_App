import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/popular_product_conroller.dart';
import '../controllers/recommended_Product_controller.dart';

/* Normal Animation */

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late Animation<double> animation;
//   late AnimationController animationController;
//
//   Future<void> _isLoaded() async {
//     await Get.find<PopularProductController>().getPopularProductListFromRepo();
//     await Get.find<RecommendedProductController>()
//         .getRecommendedProductListFromRepo();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _isLoaded();
//     animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 3),
//     )..forward();
//     animation = CurvedAnimation(
//       parent: animationController,
//       curve: Curves.linear,
//     );
//
//     Timer(Duration(seconds: 3), () => Get.offNamed(RouteHelper.getInitial()));
//   }
//
//   @override
//   void dispose() {
//     animationController
//         .dispose(); // Properly dispose of the AnimationController
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ScaleTransition(
//             scale: Tween<double>(begin: 0, end: 1.5).animate(animation),
//             // child: Center(
//             //     child: Image.asset(
//             //   "assets/image/logo part 1.png",
//             //   width: Dimensions.width230,
//             // )),
//             child: Center(
//               child: Lottie.network(
//                   "https://lottie.host/7df86832-e51b-4b8d-8ec4-ab326723c91e/sZwjopOZ7i.json"),
//             ),
//           ),
//           Center(
//             child: Image.asset(
//               "assets/image/logo part 2.png",
//               width: Dimensions.width250,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late AnimationController lottieController;

  Future<void> _isLoaded() async {
    await Get.find<PopularProductController>().getPopularProductListFromRepo();
    await Get.find<RecommendedProductController>()
        .getRecommendedProductListFromRepo();
  }

  @override
  void initState() {
    super.initState();
    _isLoaded();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        lottieController.forward();
      }
    });

    lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offNamed(RouteHelper.getInitial());
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    lottieController.dispose();
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
            scale: Tween<double>(begin: 0, end: 1.0).animate(animation),
            child: Center(
              child: Lottie.asset(
                "assets/animations/Animation_1.json",
                controller: lottieController,
                onLoaded: (composition) {
                  lottieController.duration = const Duration(seconds: 4);
                },
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/image/logo part 2.png",
              width: Dimensions.width250,
            ),
          ),
        ],
      ),
    );
  }
}
