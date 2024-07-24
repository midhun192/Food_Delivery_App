import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/account_field.dart';
import 'package:food_delivery_app/Widgets/app_icon.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/base/custom_loading_indicator.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().isUserLoggedIn();

    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("User has Logged in");
    } else {
      print("User is not logged in ");
    }

    return SafeArea(
      child: Container(
        color: AppColors.mainColor,
        padding: EdgeInsets.only(top: Dimensions.height45),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
            title: BigText(text: "Profile", color: Colors.white),
            leading: IconButton(
              onPressed: () {
                Get.offAndToNamed(RouteHelper.getInitial());
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          body: GetBuilder<UserController>(
            builder: (userController) {
              return _userLoggedIn
                  ? (userController.isLoading
                      ? Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: Dimensions.height15),
                          child: Column(
                            children: [
                              // Profile Icon
                              AppIcon(
                                icon: Icons.person,
                                iconColor: Colors.white,
                                backgroundColor: AppColors.mainColor,
                                iconSize:
                                    Dimensions.height60 + Dimensions.height15,
                                size:
                                    Dimensions.height120 + Dimensions.height30,
                              ),
                              SizedBox(height: Dimensions.height20),
                              // Account Fields
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // Name
                                      AccountField(
                                        appIcon: AppIcon(
                                          icon: Icons.person,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height30,
                                          size: Dimensions.height50,
                                        ),
                                        bigText: BigText(
                                            text:
                                                userController.userModel!.name),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      // Phone
                                      AccountField(
                                        appIcon: AppIcon(
                                          icon: Icons.phone_android,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height30,
                                          size: Dimensions.height50,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel!.phone),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      // Email
                                      AccountField(
                                        appIcon: AppIcon(
                                          icon: Icons.email,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height30,
                                          size: Dimensions.height50,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel!.email),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      // Location
                                      GetBuilder<LocationController>(
                                          builder: (locationController) {
                                        if (_userLoggedIn &&
                                            locationController
                                                .addressList.isEmpty) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  RouteHelper.getAddressPage());
                                            },
                                            child: AccountField(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                iconColor: Colors.white,
                                                iconSize: Dimensions.height30,
                                                size: Dimensions.height50,
                                              ),
                                              bigText: BigText(
                                                  text: "Fill in Your Address"),
                                            ),
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  RouteHelper.getAddressPage());
                                            },
                                            child: AccountField(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                iconColor: Colors.white,
                                                iconSize: Dimensions.height30,
                                                size: Dimensions.height50,
                                              ),
                                              bigText:
                                                  BigText(text: "Your Address"),
                                            ),
                                          );
                                        }
                                      }),
                                      SizedBox(height: Dimensions.height10),
                                      // Message
                                      AccountField(
                                        appIcon: AppIcon(
                                          icon: Icons.message,
                                          backgroundColor: AppColors.paraColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height30,
                                          size: Dimensions.height50,
                                        ),
                                        bigText: BigText(text: "Messages"),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      // Settings
                                      AccountField(
                                        appIcon: AppIcon(
                                          icon: Icons.settings,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height30,
                                          size: Dimensions.height50,
                                        ),
                                        bigText: BigText(text: "Settings"),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      // Help
                                      AccountField(
                                        appIcon: AppIcon(
                                          icon: Icons.help,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height30,
                                          size: Dimensions.height50,
                                        ),
                                        bigText: BigText(text: "Help"),
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      GestureDetector(
                                        onTap: () {
                                          if (Get.find<AuthController>()
                                              .isUserLoggedIn()) {
                                            Get.find<AuthController>()
                                                .clearSharedData();
                                            Get.find<CartController>().clear();
                                            Get.find<CartController>()
                                                .clearCartHistoryList();
                                            Get.find<LocationController>()
                                                .clearAddressList();
                                            Get.find<PopularProductController>()
                                                .clearFavorites();
                                            Get.offNamed(
                                                RouteHelper.getSignInPage());
                                          } else {
                                            print("Logged out");
                                          }
                                        },
                                        child: AccountField(
                                          appIcon: AppIcon(
                                            icon: Icons.exit_to_app,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            iconSize: Dimensions.height30,
                                            size: Dimensions.height50,
                                          ),
                                          bigText: BigText(text: "Sign Out"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const CustomLoadingIndicator())
                  : Container(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: Dimensions.height60 * 4,
                              margin: EdgeInsets.only(
                                  left: Dimensions.width20,
                                  right: Dimensions.width20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.height20,
                                  ),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/image/signintocontinue.png"),
                                      fit: BoxFit.cover)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.getSignInPage());
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: Dimensions.height60 * 2,
                                margin: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20),
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.height20,
                                  ),
                                ),
                                child: Center(
                                  child: BigText(
                                    text: "Sign in",
                                    color: Colors.white,
                                    size: Dimensions.height30 +
                                        Dimensions.height5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
