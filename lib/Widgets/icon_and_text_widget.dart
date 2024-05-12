import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  double iconSize;
  final String text;
  final Color textColor;
  double textSize;
  IconAndTextWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    this.iconSize = 0,
    required this.text,
    this.textColor = const Color(0xFFccc7c5),
    this.textSize = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize == 0 ? Dimensions.height17 : iconSize,
        ),
        SizedBox(width: Dimensions.height5),
        Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: textSize == 0 ? Dimensions.height14 : textSize),
        )
      ],
    );
  }
}
