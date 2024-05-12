import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/small_text.dart';

import '../utils/Colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final double size;
  const AppColumn({
    super.key,
    required this.text,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: Dimensions.height10),
        BigText(text: text, size: size),
        SizedBox(height: Dimensions.height10),
        SmallText(text: " with custom made Ingredients"),
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
    );
  }
}
