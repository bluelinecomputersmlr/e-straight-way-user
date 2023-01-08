import 'package:estraightwayapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHomePage extends StatelessWidget {
  const LoginHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: .5.sh,
            width: 1.sw,
            color: const Color(0xffe6eeff),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: .5.sh,
              width: 1.sw,
              color: const Color(0xffCEEED9),
            ),
          ),
          Positioned(
            top: .18.sh,
            child: Image.asset(
              'assets/icons/images/login/login_home_top.png',
              width: 1.sw,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/icons/images/login/login_home_below.png',
                width: 1.sw,
                fit: BoxFit.fitWidth,
              )),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Center(
                    child: Text(
                      "Proceed As",
                      style: GoogleFonts.poppins(
                        color: kPrimaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/icons/images/login/login_home_center_logo.png',
                  height: .2.sw,
                  width: .3.sw,
                )
              ],
            ),
          ),
          Positioned(
            top: 0.4.sh,
            left: .15.sw,
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/loginHomeUser');
              },
              child: Container(
                width: .7.sw,
                height: .06.sh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Center(
                  child: Text(
                    "User",
                    style: GoogleFonts.poppins(
                      color: kPrimaryColor,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.54.sh,
            left: .15.sw,
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/loginHomeServiceProvider');
              },
              child: Container(
                width: .7.sw,
                height: .06.sh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Center(
                  child: Text(
                    "Service Provider",
                    style: GoogleFonts.poppins(
                      color: Color(0xffE20A32),
                      fontSize: 19.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
