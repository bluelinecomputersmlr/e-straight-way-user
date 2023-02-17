import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:estraightwayapp/controller/home/profile_page_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profilePageController = Get.put(ProfilePageController());
    const kGradientBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xffe9effd), Color(0xff5861F5)],
      ),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    );
    initializeDateFormatting();
    return Obx(
      () => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        profilePageController.isLoading.isTrue
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffe9effd),
                                  shape: BoxShape.circle,
                                ),
                                height: 80,
                                width: 80,
                                child: const CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              )
                            : profilePageController
                                        .userData.value.profilePhoto !=
                                    null
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                              profilePageController
                                                  .userData.value.profilePhoto!,
                                            ))),
                                    height: 80,
                                    width: 80,
                                  )
                                : Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffe9effd),
                                      shape: BoxShape.circle,
                                    ),
                                    height: 80,
                                    width: 80,
                                    child: const Icon(
                                      Icons.person,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                        const CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          radius: 10,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        )
                      ],
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      profilePageController
                                          .getFromGalleryProfile();

                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                const Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    child: InkWell(
                                      child: const Text(
                                        'Pick From Camera',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      onTap: () {
                                        profilePageController
                                            .getFromCameraProfile();
                                        Navigator.pop(context);
                                      },
                                    ))
                              ],
                            ),
                          );
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/terms');
                        },
                        child: Container(
                          decoration: kGradientBoxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              width: .28.sw,
                              height: .5.sw,
                              decoration: const BoxDecoration(
                                color: Color(0xffe9effd),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Terms & Condition',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                    'assets/icons/term_condition_icon.png',
                                    fit: BoxFit.fitWidth,
                                    width: .3.sw,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/privacy');
                        },
                        child: Container(
                          decoration: kGradientBoxDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Container(
                              width: .28.sw,
                              height: .5.sw,
                              decoration: const BoxDecoration(
                                color: Color(0xffe9effd),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Privacy\nPolicy',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset(
                                      'assets/icons/privacy_policy_icon.png',
                                      fit: BoxFit.fitWidth,
                                      width: .3.sw,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: kGradientBoxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Container(
                            width: .28.sw,
                            height: .5.sw,
                            decoration: const BoxDecoration(
                              color: Color(0xffe9effd),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Help Desk',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/icons/help_desk_icon.png',
                                  fit: BoxFit.fitWidth,
                                  width: .3.sw,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ((profilePageController.userData.value.isServiceProvider !=
                            null &&
                        profilePageController.userData.value.lastLoggedAsUser !=
                            true)
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/myBusiness');
                              },
                              child: Container(
                                decoration: kGradientBoxDecoration,
                                child: Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    width: .28.sw,
                                    height: .5.sw,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffe9effd),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'My Business',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Image.asset(
                                          'assets/icons/term_condition_icon.png',
                                          fit: BoxFit.fitWidth,
                                          width: .3.sw,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: .15.sw,
                    width: 1.sw,
                    decoration: const BoxDecoration(
                        color: Color(0xfff8faff),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Whatsapp Us',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Image.asset(
                            'assets/icons/whatsapp.png',
                            height: 30,
                            width: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/aboutUs');
                    },
                    child: Container(
                      height: .15.sw,
                      width: 1.sw,
                      decoration: const BoxDecoration(
                          color: Color(0xfff8faff),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'About Us',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      Get.toNamed('/refundPolicy');
                    },
                    child: Container(
                      height: .15.sw,
                      width: 1.sw,
                      decoration: const BoxDecoration(
                          color: Color(0xfff8faff),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cancellation, Refund Policy',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      Get.toNamed('/contactUs');
                    },
                    child: Container(
                      height: .15.sw,
                      width: 1.sw,
                      decoration: const BoxDecoration(
                          color: Color(0xfff8faff),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Contact Us',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      await profilePageController.logoutUser();
                      await Get.offAllNamed('/loginHome');
                    },
                    child: Container(
                      height: .15.sw,
                      width: 1.sw,
                      decoration: const BoxDecoration(
                          color: Color(0xfff8faff),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Logout',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Image.asset(
                              'assets/icons/logout.png',
                              height: 30,
                              width: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
