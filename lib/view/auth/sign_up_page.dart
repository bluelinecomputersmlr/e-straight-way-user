import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/auth/login_controller.dart';
import 'package:estraightwayapp/service/auth/login_service.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // CONTROLLER
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -.4.sh,
              child: Image.asset(
                'assets/icons/images/login/login_background_image.png',
                width: 1.sw,
                fit: BoxFit.fitWidth,
              )),
          Positioned(
              top: .18.sh,
              left: .26.sw,
              child: Image.asset(
                'assets/icons/images/login/login_home_center_logo.png',
                height: .3.sw,
                width: .45.sw,
                fit: BoxFit.fitWidth,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: .35.sh,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                child: Center(
                  child: Text(
                    "Sign Up",
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
                    controller: _userNameController,
                    keyboardType: TextInputType.name,
                    maxLength: 15,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Yor name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle:
                          GoogleFonts.poppins(color: const Color(0xff97AFDE)),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: "JoXX XXX",
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _submitForm(
                          _userNameController.text, loginController, context);
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
                              "Submit",
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
              const SizedBox(
                height: 30,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _submitForm(
      String userName, LoginController controller, BuildContext context) async {
    controller.toggleLoading(true);
    //TRIGGER THE OTP
    LoginService().addUser(userName);
    //REDIRECT TO OTP VERIFICATION PAGE
    Get.toNamed('/refer');

    controller.toggleLoading(false);
  }
}
