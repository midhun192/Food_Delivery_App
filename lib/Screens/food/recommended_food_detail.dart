import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Widgets/app_icon.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/Widgets/expandable_text_widget.dart';
import 'package:food_delivery_app/Widgets/small_text.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/controllers/recommended_Product_controller.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';

import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/dimensions.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  RecommendedFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height60,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(icon: Icons.clear)),
                // AppIcon(icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      Get.find<PopularProductController>().totalItems > 0
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.shopping_cart_outlined,
                                iconColor: Colors.transparent,
                                size: Dimensions.height20,
                                backgroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      Get.find<PopularProductController>().totalItems > 0
                          ? Positioned(
                              right: Get.find<PopularProductController>()
                                          .totalItems <=
                                      10
                                  ? Dimensions.height5
                                  : Dimensions.height3,
                              top: 1,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                color: Colors.white,
                                size: Dimensions.height12,
                              ),
                            )
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height45),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.height30),
                    topLeft: Radius.circular(Dimensions.height30),
                  ),
                ),
                padding: EdgeInsets.only(
                    top: Dimensions.height10, bottom: Dimensions.height10),
                width: double.maxFinite,
                child: Center(
                  child: BigText(
                    text: product.name!,
                    size: Dimensions.height20,
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.height300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.APP_BASE_URL +
                    AppConstants.UPDLOADS +
                    product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.height5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: Dimensions.height20,
                  ),
                  child: ExpandableTextWidget(text: product.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width45 * 2,
                right: Dimensions.width45 * 2,
                bottom: Dimensions.height5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                  BigText(
                      text: "\$ ${product.price!} X ${controller.inCartItems} ",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.height24),
                  GestureDetector(
                    onTap: () {
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.height120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.height45),
                  topRight: Radius.circular(Dimensions.height45),
                ),
                color: AppColors.buttonBackgroundColor,
              ),
              padding: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                top: Dimensions.height20,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.height17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height20),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: Dimensions.height24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height17),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.height20),
                        color: AppColors.mainColor,
                      ),
                      child: SmallText(
                        text: "\$ ${product.price!} | Add to Cart",
                        size: Dimensions.height20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
