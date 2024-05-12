import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Widgets/app_column.dart';
import 'package:food_delivery_app/Widgets/app_icon.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/Widgets/expandable_text_widget.dart';
import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../utils/Colors.dart';
import '../../utils/dimensions.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AppConstants.APP_BASE_URL +
                      AppConstants.UPDLOADS +
                      product.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.height350 - Dimensions.height20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.height30),
                  topRight: Radius.circular(Dimensions.height30),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!, size: Dimensions.height24),
                  SizedBox(height: Dimensions.height30),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description!),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            padding: EdgeInsets.only(
              top: Dimensions.height10,
              bottom: Dimensions.height10,
              right: Dimensions.width20,
              left: Dimensions.width20,
            ),
            height: Dimensions.height120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.height20 * 2),
                topRight: Radius.circular(Dimensions.height20 * 2),
              ),
              color: AppColors.buttonBackgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                    right: Dimensions.width20,
                    left: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(width: Dimensions.width5),
                      BigText(text: popularProduct.quantity.toString()),
                      SizedBox(width: Dimensions.width5),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    bottom: Dimensions.height15,
                    right: Dimensions.width20,
                    left: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(
                      text: "\$ ${product.price!} | Add to Cart",
                      color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
