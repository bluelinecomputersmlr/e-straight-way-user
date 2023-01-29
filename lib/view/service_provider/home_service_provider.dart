import 'dart:io';

import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/home/home_service_provider_contoller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeServiceProviderPage extends StatelessWidget {
  const HomeServiceProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(HomeServiceProviderController());
    NumberFormat formatCurrency = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: 'INR', decimalDigits: 0);
    return Obx(
      () => SafeArea(
        child: (homePageController.isMainPageLoading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (homePageController.isMainError.value)
                ? Center(
                    child: Text(
                      homePageController.mainErrorMessage.value,
                      style: GoogleFonts.inter(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Scaffold(
                    backgroundColor: servicePrimaryColor,
                    bottomNavigationBar: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        width: 1.sw,
                        height: .2.sw,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 4), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/profile");
                              },
                              child: SizedBox(
                                width: .4.sw,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.person),
                                    Text("Profile",
                                        style: GoogleFonts.inter(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: .5,
                              height: .15.sw,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: .4.sw,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.credit_card),
                                  Text("Bank Details",
                                      style: GoogleFonts.inter(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Hello, ${homePageController.userData.value.userName}",
                                        style: GoogleFonts.inter(
                                          fontSize: 16.0,
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    Text(
                                      DateFormat('d MMMM yy')
                                          .format(homePageController.dateTime),
                                      style: GoogleFonts.inter(
                                        fontSize: 14.0,
                                        color: Color(0xff8CAFFF),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  'assets/icons/logo/estraightway_logo_service_provider.png',
                                  width: .4.sw,
                                  fit: BoxFit.fitWidth,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: 1.sw,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: servicePrimaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Total Amount Received",
                                      style: GoogleFonts.inter(
                                        fontSize: 14.0,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(formatCurrency.format(16000),
                                      style: GoogleFonts.inter(
                                        fontSize: 24.0,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed("/payouts");
                                          },
                                          child: Container(
                                            width: .32.sw,
                                            height: .15.sw,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                color: kPrimaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        4), // changes position of shadow
                                                  ),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text("Payouts",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                                Text("30",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 15.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed("/payoutsCompleted");
                                          },
                                          child: Container(
                                            width: .32.sw,
                                            height: .15.sw,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                color: kPrimaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 5,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        4), // changes position of shadow
                                                  ),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text("Payouts Completed",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                                Text("10",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 15.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text("Bookings",
                                    style: GoogleFonts.inter(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: .43.sw,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: servicePrimaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 4,
                                          offset: const Offset(0,
                                              4), // changes position of shadow
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/receivedBooking');
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Received Bookings",
                                            style: GoogleFonts.inter(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("10",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                                Image.asset(
                                                  'assets/icons/service_provider_bookings.png',
                                                  width: .2.sw,
                                                  fit: BoxFit.fitWidth,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: .43.sw,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: servicePrimaryColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 4,
                                          offset: const Offset(
                                            0,
                                            4,
                                          ), // changes position of shadow
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/newBooking');
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("New Bookings",
                                              style: GoogleFonts.inter(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("10",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )),
                                                Image.asset(
                                                  'assets/icons/service_provider_new_bookings.png',
                                                  width: .2.sw,
                                                  fit: BoxFit.fitWidth,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE6FFEF),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed("/todaysConfirmedOrder");
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFCEEED9),
                                            border: Border.all(
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Today’s Confirmed Orders",
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Text(
                                                "10",
                                                style: GoogleFonts.inter(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Image.asset(
                                                'assets/icons/completed.png',
                                                width: .4.sw,
                                                fit: BoxFit.fitWidth,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed("/todaysCancelledOrder");
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFCEEED9),
                                            border: Border.all(
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Today’s Cancelled Orders",
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Text(
                                                "10",
                                                style: GoogleFonts.inter(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Image.asset(
                                                'assets/icons/cancelled1.png',
                                                width: .5.sw,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFCEEED9),
                                border: Border.all(
                                  color: const Color(0xFFFFFFFF),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: Text(
                                          "Customer Reviews",
                                          style: GoogleFonts.inter(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        "10",
                                        style: GoogleFonts.inter(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Image.asset(
                                        'assets/icons/stars.png',
                                        width: .2.sw,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Image.asset(
                                    'assets/icons/ratings.png',
                                    width: .45.sw,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
