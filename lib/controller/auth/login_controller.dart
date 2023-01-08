import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var userMobileNumber = "".obs;
  var jwtToken = "".obs;
  var verificationCode = "".obs;
  bool? isServiceProvider = Get.arguments;

  void toggleLoading(bool value) {
    isLoading(value);
  }

  void setUserMobileNumber(String number) {
    userMobileNumber.value = number;
  }

  void setVerificationCode(String code) {
    verificationCode.value = code;
  }
}
