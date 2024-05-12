import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/app_icon.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/Widgets/expandable_text_widget.dart';
import 'package:food_delivery_app/Widgets/small_text.dart';
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
                AppIcon(icon: Icons.shopping_cart_outlined),
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
      bottomNavigationBar: Column(
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
                AppIcon(
                  icon: Icons.remove,
                  backgroundColor: AppColors.mainColor,
                ),
                BigText(
                    text: "\$ ${product.price!} X 0",
                    color: AppColors.mainBlackColor,
                    size: Dimensions.height24),
                AppIcon(
                  icon: Icons.add,
                  backgroundColor: AppColors.mainColor,
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
                Container(
                  padding: EdgeInsets.all(Dimensions.height17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                    color: AppColors.mainColor,
                  ),
                  child: SmallText(
                    text: "\$ 28 | Add to Cart",
                    size: Dimensions.height20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
