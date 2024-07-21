import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/app_icon.dart';
import 'package:food_delivery_app/Widgets/small_text.dart';
import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/controllers/recommended_Product_controller.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../Widgets/big_text.dart';

class FavouriteProductPage extends StatelessWidget {
  const FavouriteProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.mainColor,
        padding: EdgeInsets.only(top: Dimensions.height45),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.mainColor,
            title: BigText(text: "Favourites", color: Colors.white),
            leading: IconButton(
              onPressed: () {
                Get.toNamed(RouteHelper.getInitial());
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          body: GetBuilder<PopularProductController>(builder: (controller) {
            List<ProductModel> favourites = controller.favourites;
            return ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                ProductModel product = favourites[index];
                return Container(
                  margin: EdgeInsets.all(Dimensions.height20),
                  width: double.maxFinite,
                  height: Dimensions.height100,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          int pageId = Get.find<RecommendedProductController>()
                              .recommendedProductList
                              .indexOf(product);
                          if (pageId != -1) {
                            Get.toNamed(RouteHelper.recommendedFood(
                                pageId, 'favouritesPage'));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          height: Dimensions.height100,
                          width: Dimensions.width50 * 2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(AppConstants.APP_BASE_URL +
                                  AppConstants.UPDLOADS +
                                  product.img!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.height15),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.width10),
                      Expanded(
                        child: Container(
                          height: Dimensions.height100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: product.name!,
                                color: Colors.black54,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BigText(
                                    text: "\$ ${product.price.toString()}",
                                    color: Colors.redAccent,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: Dimensions.height5,
                                      bottom: Dimensions.height5,
                                      right: Dimensions.width5,
                                      left: Dimensions.width5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.height20),
                                      color: Colors.white,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.toggleFavorite(product);
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
