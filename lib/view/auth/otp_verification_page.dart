import 'package:estraightwayapp/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/auth/login_controller.dart';
import 'package:estraightwayapp/main.dart';
import 'package:estraightwayapp/service/auth/login_service.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({Key? key}) : super(key: key);

  final _otpController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // CONTROLLER
    final loginController = Get.put(LoginController());
    // const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color(0xffDEE8FF);
    // const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: fillColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]
          // border: Border.all(color: borderColor),
          ),
    );

    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: [
          Positioned(
              top: -.9.sw,
              child: Image.asset(
                  'assets/icons/images/login/login_background_image.png',
                  width: 1.sw,
                  fit: BoxFit.fitWidth)),
          Positioned(
              top: .35.sw,
              left: .26.sw,
              child: Image.asset(
                'assets/icons/images/login/login_home_center_logo.png',
                height: .3.sw,
                width: .45.sw,
                fit: BoxFit.fitWidth,
              )),
          ListView(
            children: [
              SizedBox(
                height: .7.sw,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 18.0,
                ),
                child: Text(
                  "OTP VERIFICATION",
                  style: GoogleFonts.rubik(
                    color: kHeaderTextFontColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              //LOGIN PAGE PARAGRAPH

              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Text(
                    "Enter the 6 Digit OTP sent to ${loginController.userMobileNumber}",
                    style: GoogleFonts.inter(
                      color: kHeaderTextFontColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(
                height: 15.0,
              ),
              //MOBILE NUMBER INPUT FILED

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 18.0,
                ),
                child: Directionality(
                  // Specify direction if desired
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: _otpController,
                    focusNode: focusNode,
                    length: 6,

                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                    validator: (value) {
                      return value?.length == 6 ? null : 'Pin is incorrect';
                    },
                    // onClipboardFound: (value) {
                    //   debugPrint('onClipboardFound: $value');
                    //   pinController.setText(value);
                    // },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {
                      // SUBMIT THE FORM
                      // ONLY IF THE OTP IS REACHED CRITERIA
                      if (_otpController.text.length == 6) {
                        _submitForm(
                            _otpController.text, loginController, context);
                      } else {
                        showInfoSnackbar(context, "Enter correct otp");
                      }
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                        ),
                      ],
                    ),
                    focusedPinTheme: PinTheme(
                      width: 50,
                      height: 50,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: fillColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]
                          // border: Border.all(color: borderColor),
                          ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: 50,
                      height: 50,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: fillColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]
                          // border: Border.all(color: borderColor),
                          ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 50.0,
              ),

              //SUBMIT BUTTON
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: GestureDetector(
                onTap: () {
                  // SUBMIT THE FORM
                  // ONLY IF THE OTP IS REACHED CRITERIA
                  if (_otpController.text.length == 6) {
                    // _submitForm(_otpController.text, loginController, context);
                  } else {
                    showInfoSnackbar(context, "Enter correct otp");
                  }
                },
                child: Container(
                    width: .7.sw,
                    height: .12.sw,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [kButtonUpperColor, kButtonLowerColor],
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Proceed",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _submitForm(
    String otp, LoginController controller, BuildContext context) async {
  controller.toggleLoading(true);

  // VERIFY OTP
  // IF OTP IS PROPER
  // SAVE DATA TO THE STORAGE (JWT)
  // MOVE TO HOME PAGE
  var response =
      await LoginService().submitOtp(controller.verificationCode.value, otp);
  if (response["status"] == "success") {
    var response = await LoginService().loginUser();
    if (response["status"] == "success") {
      LoginService().updateUser(controller.isServiceProvider);
      UserModel user = UserModel.fromJson(response['user']);
      if (controller.isServiceProvider == true) {
        if (user.isServiceProviderRegistered == true) {
          Get.offAllNamed('/homeServiceProviderPage');
        } else {
          Get.offAllNamed('/signUpServiceProvider');
        }
      } else {
        Get.offAllNamed('/home');
      }
    } else {
      if (controller.isServiceProvider == true) {
        Get.offAllNamed('/signUpServiceProvider');
      } else {
        Get.offAllNamed('/signUp');
      }
    }
  } else {
    // ignore: use_build_context_synchronously
    showErrorSnackbar(context, response["message"]);
  }

  controller.toggleLoading(false);
}
