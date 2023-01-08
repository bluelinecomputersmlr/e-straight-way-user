import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/auth/login_controller.dart';
import 'package:estraightwayapp/controller/auth/sign_up_service_provider_contoller.dart';
import 'package:estraightwayapp/service/auth/login_service.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:estraightwayapp/widget/text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MapBasedBookingSignUpServiceProviderPage extends StatelessWidget {
  const MapBasedBookingSignUpServiceProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CONTROLLER
    final loginController = Get.put(SignUpServiceProviderController());

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(.4.sw),
            child: Stack(children: [
              Positioned(
                  top: -.5.sh,
                  child: Image.asset(
                    'assets/icons/images/login/login_background_image.png',
                    fit: BoxFit.fitWidth,
                    width: 1.sw,
                  )),
              Positioned(
                  top: .09.sh,
                  left: .26.sw,
                  child: Image.asset(
                    'assets/icons/images/login/login_home_center_logo.png',
                    height: .3.sw,
                    width: .45.sw,
                    fit: BoxFit.fitWidth,
                  )),
            ])),
        body: Obx(
          () => loginController.isMainPageLoading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    Lottie.asset('assets/icons/loader1.json',
                        width: 1.sw, height: .6.sw),
                    Text(
                      "Please wait\nwhile we create your\nBusiness Profile....",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 19.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Form(
                  key: loginController.formKey,
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              width: .4.sw,
                              height: .5.sw,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20))),
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return Container(
                                            height: 0.3.sw,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5,
                                                        horizontal: 15),
                                                    child: InkWell(
                                                      child: const Text(
                                                        'Pick From Gallery',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        loginController
                                                            .getFromGalleryProfile(
                                                                loginController
                                                                    .profilePhoto);

                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 15),
                                                      child: InkWell(
                                                        child: const Text(
                                                          'Pick From Camera',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          loginController
                                                              .getFromCameraProfile(
                                                                  loginController
                                                                      .profilePhoto);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ))
                                                ]));
                                      });
                                },
                                child: Obx(
                                  () => Stack(
                                    alignment: Alignment.topRight,
                                    fit: StackFit.expand,
                                    children: [
                                      loginController.profilePhoto.value.path !=
                                              ''
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(
                                                          loginController
                                                              .profilePhoto
                                                              .value))),
                                              height: .5.sw,
                                              width: .38,
                                            )
                                          : Container(
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffe9effd),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              height: .5.sw,
                                              width: .38,
                                              child: const Icon(
                                                Icons.person,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                      const Positioned(
                                        top: 0,
                                        right: 0,
                                        child: CircleAvatar(
                                          backgroundColor: kPrimaryColor,
                                          radius: 20,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: .55.sw,
                            child: Column(
                              children: [
                                MyTextFormField(
                                  controller:
                                      loginController.businessNameConroller,
                                  keyboardtype: TextInputType.name,
                                  maxText: 50,
                                  textAction: TextInputAction.next,
                                  heading: "Business Name",
                                  hintText: "JoXX XXX",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Yor Business Name";
                                    }
                                    return null;
                                  },
                                ),
                                MyTextFormField(
                                  controller:
                                      loginController.serviceChargeController,
                                  keyboardtype: TextInputType.number,
                                  textAction: TextInputAction.next,
                                  maxText: 7,
                                  heading: "Service Charge",
                                  hintText: "JoXX XXX",
                                  inputFormatters: <TextInputFormatter>[
                                    // for below version 2 use this
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Yor Service Charge";
                                    }
                                    return null;
                                  },
                                ),
                                MyTextFormField(
                                  controller:
                                      loginController.experienceController,
                                  keyboardtype: TextInputType.number,
                                  textAction: TextInputAction.next,
                                  inputFormatters: <TextInputFormatter>[
                                    // for below version 2 use this
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxText: 2,
                                  heading: "Experience in years",
                                  hintText: "JoXX XXX",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Yor Experience in years";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      MyTextFormField(
                        controller:
                            loginController.vehiceRegistrationController,
                        keyboardtype: TextInputType.text,
                        maxText: 15,
                        heading: "Vehicle Registration",
                        hintText: 'AA 00 AA 0000',
                        textAction: TextInputAction.done,
                        inputFormatters: [
                          MaskedTextInputFormatter(
                              mask: 'xx-xx-xx-xxxx', separator: '-'),
                          UpperCaseTextFormatter(),
                        ],
                        validator: (String? value) {
                          String pattern =
                              r'^[A-Za-z]{2}[-][0-9]{2}[-][A-Za-z]{2}[-][0-9]{4}$';
                          RegExp regExp = new RegExp(pattern);
                          if (regExp.hasMatch(value!)) {}
                          if (value.isEmpty) {
                            return 'Enter Vehicle Number';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please Enter Valid Vehicle Number';
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        controller: loginController.businessPhoneController,
                        keyboardtype: TextInputType.phone,
                        maxText: 15,
                        isEnabled: false,
                        heading: "Phone",
                        hintText: "+999XXXXXXX",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Yor Phone Number";
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        controller: loginController.addressController,
                        keyboardtype: TextInputType.streetAddress,
                        textAction: TextInputAction.next,
                        maxText: 100,
                        heading: "Address",
                        hintText: "XXX XXX",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Address";
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        controller: loginController.userNameController,
                        keyboardtype: TextInputType.name,
                        maxText: 15,
                        heading: "Account Name",
                        textAction: TextInputAction.next,
                        hintText: "JoXX XXX",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Account Name";
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        controller: loginController.bankAccountNumberController,
                        keyboardtype: TextInputType.name,
                        maxText: 15,
                        heading: "Bank Account Number",
                        hintText: "JoXX XXX",
                        textAction: TextInputAction.next,
                        isPassword: true,
                        validator: (String? value) {
                          String pattern = r"[0-9]{9,18}";
                          RegExp regExp = new RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'Enter Your Account Number';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid Account Number';
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        controller: loginController.ifscCodeController,
                        keyboardtype: TextInputType.name,
                        maxText: 15,
                        textAction: TextInputAction.next,
                        heading: "IFSC Code",
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        hintText: "IFDC00001111",
                        validator: (String? value) {
                          const pattern = r"^[A-Z]{4}0[A-Z0-9]{6}$";
                          RegExp regExp = new RegExp(pattern);
                          if (value!.isEmpty) {
                            return 'Enter IFSC Code';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid IFSC Code';
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        controller: loginController.upiIdController,
                        keyboardtype: TextInputType.name,
                        maxText: 15,
                        heading: "Upi ID",
                        hintText: "xxxx@xbank",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Upi ID";
                          }
                          return null;
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              context: context,
                              builder: (BuildContext bc) {
                                return Container(
                                    height: 0.3.sw,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 15),
                                            child: InkWell(
                                              child: const Text(
                                                'Pick From Gallery',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                ),
                                              ),
                                              onTap: () {
                                                loginController
                                                    .getFromGalleryProfile(
                                                        loginController
                                                            .aadharPhoto);

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 15),
                                              child: InkWell(
                                                child: const Text(
                                                  'Pick From Camera',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                onTap: () {
                                                  loginController
                                                      .getFromCameraProfile(
                                                          loginController
                                                              .aadharPhoto);
                                                  Navigator.pop(context);
                                                },
                                              ))
                                        ]));
                              });
                        },
                        child: Obx(
                          () => MyTextFormField(
                            isEnabled: false,
                            keyboardtype: TextInputType.name,
                            maxText: 15,
                            heading: "Upload Aadhar",
                            hintText: "Upload Aadhar",
                            suffixIcon:
                                loginController.aadharPhoto.value.path == ''
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      ),
                            validator: (value) {
                              if (loginController.aadharPhoto.value.path ==
                                  '') {
                                return 'please add your aadhar photo';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              context: context,
                              builder: (BuildContext bc) {
                                return Container(
                                    height: 0.3.sw,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 15),
                                            child: InkWell(
                                              child: const Text(
                                                'Pick From Gallery',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                ),
                                              ),
                                              onTap: () {
                                                loginController
                                                    .getFromGalleryProfile(
                                                        loginController
                                                            .licencePhoto);

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 15),
                                              child: InkWell(
                                                child: const Text(
                                                  'Pick From Camera',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                onTap: () {
                                                  loginController
                                                      .getFromCameraProfile(
                                                          loginController
                                                              .licencePhoto);
                                                  Navigator.pop(context);
                                                },
                                              ))
                                        ]));
                              });
                        },
                        child: Obx(
                          () => MyTextFormField(
                            isEnabled: false,
                            keyboardtype: TextInputType.name,
                            maxText: 15,
                            heading: "Driving Licence",
                            hintText: "Driving Licence",
                            suffixIcon:
                                loginController.licencePhoto.value.path == ''
                                    ? Container(
                                        width: 20,
                                        height: 20,
                                      )
                                    : const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      ),
                            validator: (value) {
                              if (loginController.licencePhoto.value.path ==
                                  '') {
                                return 'please add your Driving Licence';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              context: context,
                              builder: (BuildContext bc) {
                                return Container(
                                    height: 0.3.sw,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 15),
                                            child: InkWell(
                                              child: const Text(
                                                'Pick From Gallery',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                ),
                                              ),
                                              onTap: () {
                                                loginController
                                                    .getFromGalleryProfile(
                                                        loginController
                                                            .vehicleRegistrationPhoto);

                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 15),
                                              child: InkWell(
                                                child: const Text(
                                                  'Pick From Camera',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                onTap: () {
                                                  loginController
                                                      .getFromCameraProfile(
                                                          loginController
                                                              .vehicleRegistrationPhoto);
                                                  Navigator.pop(context);
                                                },
                                              ))
                                        ]));
                              });
                        },
                        child: Obx(
                          () => MyTextFormField(
                            isEnabled: false,
                            keyboardtype: TextInputType.name,
                            maxText: 15,
                            heading: "Vehicle Registration",
                            hintText: "Vehicle Registration",
                            suffixIcon: loginController
                                        .vehicleRegistrationPhoto.value.path ==
                                    ''
                                ? Container(
                                    width: 20,
                                    height: 20,
                                  )
                                : const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                            validator: (value) {
                              if (loginController
                                      .vehicleRegistrationPhoto.value.path ==
                                  '') {
                                return 'please add your Vehicle Registration';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              if (loginController.formKey.currentState!
                                  .validate()) {
                                await loginController
                                    .submitFormMapBasedBooking();
                                await Get.offAllNamed(
                                    '/homeServiceProviderPage');
                              } else {
                                showErrorSnackbar(
                                    context, 'please enter valid details');
                              }
                            },
                            child: Container(
                                width: .7.sw,
                                height: .12.sw,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      kButtonUpperColor,
                                      kButtonLowerColor
                                    ],
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
                  ),
                ),
        ));
  }
}
