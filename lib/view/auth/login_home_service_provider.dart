import 'package:estraightwayapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHomeServiceProviderPage extends StatelessWidget {
  const LoginHomeServiceProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/icons/images/login/login_home_service_provider.png',
            width: 1.sw,
            height: 1.sh,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            top: .25.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Center(
                    child: Text(
                      "Welcome",
                      style: GoogleFonts.poppins(
                        color: Color(0xff5086A1),
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
                        color: Color(0xff5086A1),
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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/login', arguments: true);
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
          )
        ],
      ),
    );
  }
}
