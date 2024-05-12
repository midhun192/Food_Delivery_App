import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/app_column.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/Widgets/icon_and_text_widget.dart';
import 'package:food_delivery_app/Widgets/small_text.dart';
import 'package:food_delivery_app/controllers/popular_product_conroller.dart';
import 'package:food_delivery_app/controllers/recommended_Product_controller.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  int currPageValue = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return popularProduct.isLoaded
              ? CarouselSlider.builder(
                  options: CarouselOptions(
                      onPageChanged: ((index, reason) {
                        setState(() {
                          currPageValue = index;
                        });
                      }),
                      height: Dimensions.height320,
                      autoPlay: false,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      enlargeFactor: 0.3,
                      enableInfiniteScroll: false),
                  itemCount: popularProduct.popularProductList.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return _carouselSlider(itemIndex,
                        popularProduct.popularProductList[itemIndex]);
                  },
                )
              : CircularProgressIndicator(color: AppColors.mainColor);
        }),
        // Dots Indicator
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProductList.isEmpty
                ? 1
                : popularProduct.popularProductList.length,
            position: currPageValue.toDouble(),
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
          );
        }),
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height3),
                child: BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height4),
                child: SmallText(text: "Popular Trending"),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.height20),
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoaded
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recommendedProduct.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.recommendedFood(index));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width30,
                              bottom: Dimensions.height10,
                              right: Dimensions.width30),
                          child: Row(
                            children: [
                              // Image Section
                              Container(
                                height: Dimensions.height120,
                                width: Dimensions.height120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.height30),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        AppConstants.APP_BASE_URL +
                                            AppConstants.UPDLOADS +
                                            recommendedProduct
                                                .recommendedProductList[index]
                                                .img!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Text Container
                              Expanded(
                                child: Container(
                                  height: Dimensions.height100,
                                  decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.height20),
                                      bottomRight:
                                          Radius.circular(Dimensions.height20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10,
                                      top: Dimensions.height10,
                                    ),
                                    child: AppColumn(
                                        text: recommendedProduct
                                            .recommendedProductList[index]
                                            .name!,
                                        size: Dimensions.height20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        ),
      ],
    );
  }

  Widget _carouselSlider(int index, ProductModel popularProducts) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.popularFood(index));
          },
          child: Container(
            height: Dimensions.height220,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage(AppConstants.APP_BASE_URL +
                    AppConstants.UPDLOADS +
                    popularProducts.img!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.height120,
            margin: EdgeInsets.only(
                left: Dimensions.width35,
                right: Dimensions.width35,
                bottom: Dimensions.height20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.height30),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: 5.0,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width15,
                right: Dimensions.width15,
                top: Dimensions.height15,
                bottom: Dimensions.height10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(text: popularProducts.name!),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        children: List.generate(
                          5,
                          (index) {
                            return Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                              size: Dimensions.height15,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: Dimensions.width10),
                      SmallText(text: "4.5"),
                      SizedBox(width: Dimensions.width10),
                      Row(
                        children: [
                          SmallText(text: "1287"),
                          SizedBox(width: Dimensions.width5),
                          SmallText(text: "Comments"),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.height10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconAndTextWidget(
                        icon: Icons.circle_sharp,
                        iconColor: AppColors.iconColor1,
                        text: "Normal",
                      ),
                      IconAndTextWidget(
                        icon: Icons.location_on,
                        iconColor: AppColors.mainColor,
                        text: "1.7 km",
                      ),
                      IconAndTextWidget(
                        icon: Icons.access_time_rounded,
                        iconColor: AppColors.iconColor2,
                        text: "32 min",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
