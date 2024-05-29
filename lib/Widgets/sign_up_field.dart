import 'package:flutter/material.dart';

import '../utils/Colors.dart';
import '../utils/dimensions.dart';

class SignUpFields extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  const SignUpFields({
    super.key,
    required this.hintText,
    required this.textController,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
        borderRadius: BorderRadius.circular(Dimensions.height15),
      ),
      child: TextField(
        controller: textController,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: AppColors.yellowColor),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height15),
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height15),
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
