import 'package:food_delivery_app/data/repositories/auth_repo.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:food_delivery_app/models/sign_up_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // User Registartion for first time
  Future<ResponseModel> registration(SignUpModel signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  // User Login
  Future<ResponseModel> login(
      String email, String phone, String password) async {
    // print("Getting Token");
    // String toke1 = await authRepo.getUserToken();
    // print(toke1);
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, phone, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      // print("Backend Token");
      await authRepo.saveUserToken(response.body["token"]);
      print("MY TOKEN IS :" + response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool isUserLoggedIn() {
    return authRepo.isUserLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
