import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpModel signUpBody) async {
    return await apiClient.postData(
        AppConstants.REGISTER_URI, signUpBody.toJson());
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  bool isUserLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  /*Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }*/

  Future<Response> login(String email, String phone, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI,
        {"email": email, "phone": phone, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PHONE);
    sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }
}
