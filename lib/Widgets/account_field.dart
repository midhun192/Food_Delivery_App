import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/app_icon.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class AccountField extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountField({
    super.key,
    required this.appIcon,
    required this.bigText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height10,
          bottom: Dimensions.height10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20),
          bigText,
        ],
      ),
    );
  }
}
