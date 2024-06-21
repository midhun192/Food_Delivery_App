import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Screens/auth/sign_up.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/Widgets/sign_up_field.dart';
import 'package:food_delivery_app/base/custom_loading_indicator.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/dimensions.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passController = TextEditingController();

    void _login(AuthController authController) {
      // var email = emailController.text.trim();
      var phone = phoneController.text.trim();
      var password = passController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackbar("Enter Phone Number", title: "Phone");
      } else if (phone.length < 10) {
        showCustomSnackbar("Phone Number Should have length of 10",
            title: "Phone");
      } else if (password.isEmpty) {
        showCustomSnackbar("Enter your Password !", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackbar("Password Should be at least 6 letters!",
            title: "Password");
      } else {
        // print(signUpBody.toString());
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            // Get.toNamed(RouteHelper.getInitial());
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimensions.height20 * 4,
                            backgroundImage: const AssetImage(
                                "assets/image/logo part 1.png"),
                          ),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontSize: Dimensions.height60,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: Dimensions.height10),
                            Text(
                              "Sign in to your Account",
                              style: TextStyle(
                                fontSize: Dimensions.height20,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      // SignUpFields(
                      //   hintText: "E-mail",
                      //   obscureText: false,
                      //   textController: emailController,
                      //   icon: Icons.email,
                      // ),
                      // SizedBox(height: Dimensions.height20),
                      SignUpFields(
                        hintText: "Phone",
                        textController: phoneController,
                        icon: Icons.phone,
                        obscureText: false,
                      ),
                      SizedBox(height: Dimensions.height20),
                      SignUpFields(
                        hintText: "Password",
                        textController: passController,
                        icon: Icons.password,
                        obscureText: true,
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                        text: TextSpan(
                          text: "Sign in to your Account",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.height20,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          height: Dimensions.screenHeight / 17,
                          width: Dimensions.screenWidth / 2,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.height30),
                          ),
                          child: Center(
                            child:
                                BigText(text: "Sign in", color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                        text: TextSpan(
                          text: "Don\'t have an account ? ",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.height20,
                          ),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(
                                      () => const SignUp(),
                                      transition: Transition.fade,
                                    ),
                              text: "Create",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.height20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const CustomLoadingIndicator();
        },
      ),
    );
  }
}
