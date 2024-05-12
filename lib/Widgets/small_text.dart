import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:get/get.dart';

class SmallText extends StatelessWidget {
  Color? color;
  double size;
  double height;
  final String text;
  SmallText({
    super.key,
    required this.text,
    this.size = 0,
    this.height = 1.2,
    this.color = const Color(0xFFccc7c5),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.height12 : size,
        height: height,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
