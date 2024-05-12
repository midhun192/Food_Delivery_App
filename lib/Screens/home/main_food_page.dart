import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/home/food_page_body.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/Widgets/small_text.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Header Section
          Container(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Location Column
                  Column(
                    children: [
                      BigText(text: "India", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: "Kochi"),
                          const Icon(
                            Icons.arrow_drop_down_rounded,
                          )
                        ],
                      )
                    ],
                  ),

                  // Search Icon
                  Container(
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.height24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body Section
          const Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
