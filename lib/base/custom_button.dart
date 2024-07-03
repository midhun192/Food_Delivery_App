import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double radius;
  final double? width;
  final double? height;
  final double? fontSize;
  final IconData? iconData;
  const CustomButton({
    super.key,
    required this.buttonText,
    this.transparent = false,
    this.onPressed,
    this.radius = 5,
    this.height,
    this.width,
    this.fontSize,
    this.margin,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(width == null ? Dimensions.screenWidth : width!,
          height != null ? height! : Dimensions.height50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimensions.screenWidth,
        height: height ?? Dimensions.height50,
        child: TextButton(
          onPressed: onPressed,
          style: _flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconData != null
                  ? Padding(
                      padding: EdgeInsets.only(right: Dimensions.width5),
                      child: Icon(iconData,
                          color: transparent
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor),
                    )
                  : SizedBox(),
              Text(
                buttonText,
                style: TextStyle(
                    color: transparent
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
