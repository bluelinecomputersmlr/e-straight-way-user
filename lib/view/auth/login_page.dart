import 'package:flutter/material.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/auth/login_controller.dart';
import 'package:estraightwayapp/service/auth/login_service.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // CONTROLLER
    final loginController = Get.put(LoginController());
    return Scaffold(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Center(
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  width: 1.sw,
                  height: .13.sw,
                  child: TextFormField(
                    controller: _mobileNumberController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value!.length < 10) {
                        return "Enter Valid Mobile Number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                      labelStyle:
                          GoogleFonts.poppins(color: const Color(0xff97AFDE)),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: "99XXX XXXXX",
                      counterText: '',
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        // borderSide: const BorderSide(
                        //   color: kBorderColor,
                        //   width: 2.0,
                        // ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      floatingLabelStyle: GoogleFonts.poppins(
                        color: kTextFiledFontColor,
                      ),
                      fillColor: const Color(0xffDEE8FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: GestureDetector(
                onTap: () {
                  if (_mobileNumberController.text.length == 10) {
                    _submitForm(
                        _mobileNumberController.text, loginController, context);
                  } else {
                    showInfoSnackbar(context, "Enter correct mobile number");
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
                        Icon(
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

void _submitForm(String mobileNumber, LoginController controller,
    BuildContext context) async {
  controller.toggleLoading(true);
  controller.setUserMobileNumber(mobileNumber);
  //TRIGGER THE OTP
  LoginService().verifyPhone(mobileNumber, controller);
  //REDIRECT TO OTP VERIFICATION PAGE
  print("lllllllllllllll${controller.isServiceProvider}");
  Get.toNamed('/otp?', arguments: controller.isServiceProvider);

  controller.toggleLoading(false);
}
