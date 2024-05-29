import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height100,
        width: Dimensions.height100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height50),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.mainColor),
        ),
      ),
    );
  }
}
