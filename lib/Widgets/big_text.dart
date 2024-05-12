import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  final TextOverflow textOverflow;
  double size;
  BigText({
    super.key,
    this.color = const Color(0xFF332d2b),
    this.textOverflow = TextOverflow.ellipsis,
    this.size = 0,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 1,
      text,
      overflow: textOverflow,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.height20 : size,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400),
    );
  }
}
