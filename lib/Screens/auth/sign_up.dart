import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Widgets/big_text.dart';
import 'package:food_delivery_app/Widgets/sign_up_field.dart';
import 'package:food_delivery_app/base/custom_loading_indicator.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:food_delivery_app/routes/route_Helper.dart';
import 'package:food_delivery_app/utils/Colors.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    var signupImages = [
      "g.png",
      "f.png",
      "t.png",
    ];

    void _validation(AuthController authController) {
      var name = nameController.text.trim();
      var password = passController.text.trim();
      var email = emailController.text.trim();
      var phone = phoneController.text.trim();

      if (name.isEmpty) {
        showCustomSnackbar("Enter your Name !", title: "Name");
      } else if (password.isEmpty) {
        showCustomSnackbar("Enter your Password !", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackbar("Password Should be at least 6 letters!",
            title: "Password");
      } else if (email.isEmpty) {
        showCustomSnackbar("Enter your Email !", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackbar("Enter valid Email Address !",
            title: "Invalid Email");
      } else if (phone.isEmpty) {
        showCustomSnackbar("Enter your Phone Number !", title: "Phone Number");
      } else if (phone.length < 10) {
        showCustomSnackbar("Enter valid Phone Number !",
            title: "Invalid Phone Number");
      } else {
        // showCustomSnackbar("All Went Well", title: "Success");
        SignUpModel signUpBody = SignUpModel(
            name: name, email: email, password: password, phone: phone);
        // print(signUpBody.toString());
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success Registration !");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackbar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            return !_authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        Container(
                          height: Dimensions.screenHeight * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              radius: Dimensions.height20 * 4,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage(
                                  "assets/image/logo part 1.png"),
                            ),
                          ),
                        ),
                        SignUpFields(
                          hintText: "E-Mail",
                          textController: emailController,
                          icon: Icons.email,
                        ),
                        SizedBox(height: Dimensions.height20),
                        SignUpFields(
                          hintText: "Password",
                          textController: passController,
                          icon: Icons.password,
                          obscureText: true,
                        ),
                        SizedBox(height: Dimensions.height20),
                        SignUpFields(
                          hintText: "Name",
                          textController: nameController,
                          icon: Icons.person,
                        ),
                        SizedBox(height: Dimensions.height20),
                        SignUpFields(
                          hintText: "Phone",
                          textController: phoneController,
                          icon: Icons.phone_android,
                        ),
                        SizedBox(height: Dimensions.height20),
                        GestureDetector(
                          onTap: () {
                            _validation(_authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 17,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.height30),
                            ),
                            child: Center(
                                child: BigText(
                                    text: "Sign Up", color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        RichText(
                          text: TextSpan(
                            text: "Have an Account already ?",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.height20,
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        RichText(
                          text: TextSpan(
                            text: "Sign up using one of the following methods",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.height15,
                            ),
                          ),
                        ),
                        Wrap(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: Dimensions.height30,
                                backgroundImage: AssetImage(
                                    "assets/image/" + signupImages[index]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const CustomLoadingIndicator();
          },
        ));
  }
}
