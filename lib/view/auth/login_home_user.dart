import 'package:estraightwayapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHomeUserPage extends StatelessWidget {
  const LoginHomeUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/icons/images/login/login_background_image.png',
            width: 1.sw,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
              bottom: .65.sw,
              left: .26.sw,
              child: Image.asset(
                'assets/icons/images/login/login_home_center_logo.png',
                height: .3.sw,
                width: .45.sw,
                fit: BoxFit.fitWidth,
              )),
          Positioned(
            left: 0,
            top: .2.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Center(
                    child: Text(
                      "Welcome",
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
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Center(
                    child: Text(
                      "Please click on login if you’ve already registered\nwith us, and if not please sign up.",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
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
                      Get.toNamed('/login', arguments: false);
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
                      child: Center(
                        child: Text(
                          "Log In / Sign Up",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
              // Align(
              //   alignment: Alignment.center,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       width: .7.sw,
              //       height: .12.sw,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         border: Border.all(color: kButtonUpperColor),
              //         borderRadius: BorderRadius.circular(50.0),
              //       ),
              //       child: Center(
              //         child: Text(
              //           "Sign Up",
              //           style: GoogleFonts.poppins(
              //             color: kButtonUpperColor,
              //             fontSize: 19.0,
              //             fontWeight: FontWeight.w500,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
