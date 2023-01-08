import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/auth/sign_up_service_provider_contoller.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:estraightwayapp/widget/text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpServiceProviderPage extends StatelessWidget {
  SignUpServiceProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CONTROLLER
    final loginController = Get.put(SignUpServiceProviderController());
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -.4.sh,
              child: Image.asset(
                  'assets/icons/images/login/login_background_image.png')),
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
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
                child: Center(
                  child: Text(
                    "Service Provider",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    MyTextFormField(
                      controller: loginController.userNameController,
                      keyboardtype: TextInputType.name,
                      maxText: 50,
                      heading: "Name",
                      hintText: "JoXX XXX",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Yor name";
                        }
                        return null;
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/selectCategoryPage');
                      },
                      child: MyTextFormField(
                        heading: "Select Category",
                        controller: loginController.categoryController,
                        suffixIcon: const Icon(
                          Icons.arrow_forward,
                          color: Color(0xff97AFDE),
                        ),
                        isEnabled: false,
                        keyboardtype: TextInputType.name,
                        maxText: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (loginController.category != null) {
                          Get.toNamed('/selectSubCategoryPage');
                        } else {
                          showInfoSnackbar(context, 'Please select a category');
                        }
                      },
                      child: MyTextFormField(
                        controller: loginController.subCategoryController,
                        heading: "Select Sub-Category",
                        suffixIcon: const Icon(
                          Icons.arrow_forward,
                          color: Color(0xff97AFDE),
                        ),
                        isEnabled: false,
                        keyboardtype: TextInputType.name,
                        maxText: 15,
                      ),
                    ),
                  ],
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
                      if (loginController.category != null &&
                          loginController.subCategory != null) {
                        _submitForm(
                            loginController.subCategory!.subCategoryType);
                      } else {
                        showInfoSnackbar(
                            context, 'please select category and sub-category');
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

  void _submitForm(type) async {
    if (type == 'map') {
      Get.toNamed('/mapBasedBookingSignUpServiceProvider');
    } else if (type == 'date') {
      Get.toNamed('/slotBasedBookingSignUpServiceProvider');
    } else {
      Get.toNamed('/directBookingSignUpServiceProvider');
    }
  }
}
