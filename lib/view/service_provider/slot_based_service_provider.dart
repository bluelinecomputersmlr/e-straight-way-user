import 'package:carousel_slider/carousel_slider.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/auth/sign_up_service_provider_contoller.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:estraightwayapp/widget/text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SlotBasedBookingSignUpServiceProviderPage extends StatelessWidget {
  const SlotBasedBookingSignUpServiceProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CONTROLLER
    final loginController = Get.put(SignUpServiceProviderController());
    // loginController.isMainPageLoading(true);
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
                    const SizedBox(height: 20),
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
                      loginController.serviceImages.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: .7.sw,
                                    child: CarouselSlider(
                                      carouselController:
                                          loginController.carouselController,
                                      options: CarouselOptions(
                                          viewportFraction: 0.9,
                                          height: 1.sw,
                                          autoPlay: true,
                                          onPageChanged: (index, reason) {
                                            loginController.updateIndex(index);
                                          }),
                                      items: loginController.serviceImages
                                          .toList()
                                          .map((item) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Image.file(
                                                    item,
                                                    width: 1.sw,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  "assets/icons/placing_image.jpg",
                                  width: 1.sw,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: loginController.serviceImages
                              .asMap()
                              .entries
                              .map((entry) {
                            return GestureDetector(
                              onTap: () => loginController.carouselController
                                  .animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(loginController
                                                    .currentIndex.value ==
                                                entry.key
                                            ? 0.9
                                            : 0.4)),
                              ),
                            );
                          }).toList()),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                        .getFromGalleryServiceImage();

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
                                                          .getFromCameraServiceImage();
                                                      Navigator.pop(context);
                                                    },
                                                  ))
                                            ]));
                                  });
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
                                child: Center(
                                  child: Text(
                                    "Add Images",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      MyTextFormField(
                        controller: loginController.businessNameConroller,
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
                            loginController.businessDescriptionConroller,
                        keyboardtype: TextInputType.name,
                        maxLines: 5,
                        textAction: TextInputAction.next,
                        heading: "Description",
                        hintText: "",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Yor Business Description";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 4,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Obx(() => ListView.builder(
                                    itemCount: loginController
                                        .addedServiceModel.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  loginController.removeNewService(
                                                      loginController
                                                              .addedServiceModel[
                                                          index]);
                                                },
                                              ),
                                            ),
                                            MyTextFormField(
                                                keyboardtype:
                                                    TextInputType.name,
                                                initialvalue: loginController
                                                            .addedServiceModel[
                                                                index]
                                                            .addedServiceName !=
                                                        null
                                                    ? loginController
                                                        .addedServiceModel[
                                                            index]
                                                        .addedServiceName!
                                                    : '',
                                                maxText: 50,
                                                textAction:
                                                    TextInputAction.next,
                                                heading:
                                                    "Service ${index + 1} Name",
                                                hintText: "",
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter Yor Service Name";
                                                  }
                                                  return null;
                                                },
                                                onchanged: (value) {
                                                  loginController
                                                      .addedServiceModel[index]
                                                      .addedServiceName = value!;
                                                }),
                                            MyTextFormField(
                                              initialvalue: loginController
                                                          .addedServiceModel[
                                                              index]
                                                          .addedServicePrice !=
                                                      null
                                                  ? loginController
                                                      .addedServiceModel[index]
                                                      .addedServicePrice
                                                      .toString()
                                                  : '',
                                              keyboardtype:
                                                  TextInputType.number,
                                              textAction: TextInputAction.next,
                                              maxText: 7,
                                              heading:
                                                  "Service ${index + 1} Charge",
                                              hintText: "",
                                              onchanged: (value) {
                                                loginController
                                                        .addedServiceModel[index]
                                                        .addedServicePrice =
                                                    double.parse(value!);
                                              },
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                // for below version 2 use this
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter Yor Service Charge";
                                                }
                                                return null;
                                              },
                                            ),
                                            MyTextFormField(
                                              initialvalue: loginController
                                                          .addedServiceModel[
                                                              index]
                                                          .addedServiceDescription !=
                                                      null
                                                  ? loginController
                                                      .addedServiceModel[index]
                                                      .addedServiceDescription!
                                                  : '',
                                              keyboardtype: TextInputType.name,
                                              maxLines: 5,
                                              textAction: TextInputAction.next,
                                              heading:
                                                  "Service ${index + 1} Description",
                                              hintText: "",
                                              onchanged: (value) {
                                                loginController
                                                        .addedServiceModel[index]
                                                        .addedServiceDescription =
                                                    value!;
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter Yor Service Description";
                                                }
                                                return null;
                                              },
                                            ),
                                            Divider(),
                                          ]);
                                    })),
                                GestureDetector(
                                  onTap: () {
                                    loginController.addNewService();
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
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Add More",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                          if (loginController.serviceImages.length < 6) {
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
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                          } else {
                            showErrorSnackbar(
                                context, "cant add more than 5 images");
                          }
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
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              if (loginController.formKey.currentState!
                                  .validate()) {
                                await loginController
                                    .submitFormSlotBasedBooking();
                                Get.offAllNamed('/homeServiceProviderPage');
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
