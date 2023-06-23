import 'dart:developer';

import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/home/home_service_provider_contoller.dart';
import 'package:estraightwayapp/controller/service_provider/received_booking_controller.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/model/sos_model.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/view/auth/sos_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class HomeServiceProviderPage extends StatefulWidget {
  const HomeServiceProviderPage({Key? key}) : super(key: key);

  @override
  State<HomeServiceProviderPage> createState() => _HomeServiceProviderPageState();
}

class _HomeServiceProviderPageState extends State<HomeServiceProviderPage> {
  final homePageController = Get.put(HomeServiceProviderController());
  final receivedBookingsController = Get.put(ReceivedBookingController());

  @override
  void initState() {
    Future.delayed(
      const Duration(microseconds: 200),
      () async {
        await homePageController.getUserData();
        await homePageController.setLocation();
        await receivedBookingsController.getStraightWayUser();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("----HomeServiceProviderPage--- ");
    // NumberFormat formatCurrency = NumberFormat.simpleCurrency(
    //     locale: Platform.localeName, name: 'INR', decimalDigits: 0);
    return Obx(
      () => (homePageController.isMainPageLoading.value)
          ? const Center(child: CircularProgressIndicator())
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
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 4,
                            offset: const Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Get.toNamed("/profile"),
                            child: SizedBox(
                              width: .4.sw,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.person),
                                  Text(
                                    "Profile",
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   width: .5,
                          //   height: .15.sw,
                          //   color: Colors.grey,
                          // ),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.toNamed("/bankDetails");
                          //   },
                          //   child: SizedBox(
                          //     width: .4.sw,
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Icon(Icons.credit_card),
                          //         Text("Bank Details",
                          //             style: GoogleFonts.inter(
                          //               fontSize: 14.0,
                          //               color: Colors.black,
                          //               fontWeight: FontWeight.w500,
                          //             )),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
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
                                    ),
                                  ),
                                  Text(
                                    DateFormat('d MMMM yy').format(homePageController.dateTime),
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      color: const Color(0xff8CAFFF),
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
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                                  child: Text(
                                    "Bookings",
                                    style: GoogleFonts.inter(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              FlutterSwitch(
                                height: 28,
                                width: 50,
                                padding: 1,
                                value: homePageController.isSendLocation.value,
                                activeColor: kSuccessColor,
                                onToggle: (bool value) {
                                  homePageController.isSendLocation.value = value;
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: .43.sw,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  color: servicePrimaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 4,
                                      offset: const Offset(0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () => Get.toNamed('/receivedBooking'),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Accepted Bookings",
                                          style: GoogleFonts.inter(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              StreamBuilder<List<dynamic>>(
                                                stream: BusinessServices.acceptedBookings(businessId: homePageController.userData.value.serviceProviderDetails != null ? homePageController.userData.value.serviceProviderDetails!.businessUID ?? '' : ''),
                                                builder: (context, snapshot) {
                                                  return snapshot.hasData && snapshot.data != null
                                                      ? Text(
                                                          snapshot.data!.length.toString(),
                                                          style: GoogleFonts.inter(
                                                            fontSize: 18.0,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        )
                                                      : const SizedBox();
                                                },
                                              ),
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
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  color: servicePrimaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 4,
                                      offset: const Offset(0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () => Get.toNamed('/newBooking'),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "New Bookings",
                                          style: GoogleFonts.inter(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              StreamBuilder<List<BusinessModel>>(
                                                stream: BusinessServices.newBookings(),
                                                builder: (context, snapshot) {
                                                  if (homePageController.userData.value.serviceProviderDetails != null &&
                                                      homePageController.userData.value.serviceProviderDetails!.businessType == "Maps") {
                                                    return const SizedBox();
                                                  }
                                                  return snapshot.hasData && snapshot.data != null
                                                      ? Text(
                                                          snapshot.data!.length.toString(),
                                                          style: GoogleFonts.inter(
                                                            fontSize: 18.0,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        )
                                                      : const SizedBox();
                                                },
                                              ),
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
                          const SizedBox(height: 20.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6FFEF),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Get.toNamed("/todaysConfirmedOrder"),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.40,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFCEEED9),
                                          border: Border.all(
                                            color: const Color(0xFFFFFFFF),
                                          ),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Today’s Completed Orders",
                                              style: GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 20.0),
                                            StreamBuilder<List<BusinessModel>>(
                                              stream: BusinessServices.todayCompletedOrders(businessId: homePageController.userData.value.serviceProviderDetails != null ? homePageController.userData.value.serviceProviderDetails!.businessUID ?? '' : ''),
                                              builder: (context, snapshot) {
                                                return snapshot.hasData && snapshot.data != null
                                                    ? Text(
                                                        snapshot.data!.length.toString(),
                                                        style: GoogleFonts.inter(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      )
                                                    : const SizedBox();
                                              },
                                            ),
                                            Image.asset('assets/icons/completed.png', width: .4.sw, fit: BoxFit.fitWidth),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.toNamed("/todaysCancelledOrder"),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.40,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFCEEED9),
                                          border: Border.all(color: const Color(0xFFFFFFFF)),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Today’s Cancelled Orders",
                                              style: GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 20.0),
                                            StreamBuilder<List<BusinessModel>>(
                                              stream: BusinessServices.todayCancelledOrders(businessId: homePageController.userData.value.serviceProviderDetails != null ? homePageController.userData.value.serviceProviderDetails!.businessUID ?? '' : ''),
                                              builder: (context, snapshot) {
                                                return snapshot.hasData && snapshot.data != null
                                                    ? Text(
                                                        snapshot.data!.length.toString(),
                                                        style: GoogleFonts.inter(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      )
                                                    : const SizedBox();
                                              },
                                            ),
                                            const SizedBox(height: 20.0),
                                            Image.asset('assets/icons/cancelled1.png', width: .5.sw, fit: BoxFit.fitWidth),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          GestureDetector(
                            onTap: () => Get.toNamed("/customerReviews"),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFCEEED9),
                                border: Border.all(color: const Color(0xFFFFFFFF)),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Text(
                                          "Customer Reviews",
                                          style: GoogleFonts.inter(fontSize: 14.0, fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      StreamBuilder<List<BusinessModel>>(
                                        stream: BusinessServices.reviewedOrders(businessId: homePageController.userData.value.serviceProviderDetails != null ? homePageController.userData.value.serviceProviderDetails!.businessUID ?? '' : ''),
                                        builder: (context, snapshot) {
                                          return snapshot.hasData && snapshot.data != null
                                              ? Text(
                                                  snapshot.data!.length.toString(),
                                                  style: GoogleFonts.inter(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              : const SizedBox();
                                        },
                                      ),
                                      const SizedBox(height: 20.0),
                                      Image.asset('assets/icons/stars.png', width: .2.sw, fit: BoxFit.fitWidth),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  Image.asset('assets/icons/ratings.png', width: .45.sw, fit: BoxFit.fitWidth),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  // Get.toNamed('/sosRequests');
                                  AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
                                    'CHANNEL ID',
                                    'CHANNEL NAME',
                                    channelDescription: 'CHANNEL DESCRIPTION',
                                    importance: Importance.max,
                                    priority: Priority.max,
                                    enableLights: true,
                                    playSound: true,
                                    sound: RawResourceAndroidNotificationSound('notification_sound'),
                                  );
                                  DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(
                                    presentAlert: true,
                                    presentBadge: true,
                                    presentSound: true,
                                    sound: 'notification_sound.aiff',
                                  );
                                  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);

                                  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
                                  await flutterLocalNotificationsPlugin.show(
                                      0,
                                      'remoteMessage.notification!.title' ?? '',
                                      'remoteMessage.notification!.body' ?? '',
                                      notificationDetails,
                                      payload: ''
                                  );
                                  await flutterLocalNotificationsPlugin.schedule(
                                      1,
                                      'Today’s message',
                                      '{slideList[random][].toString()}',
                                      DateTime.now().add(Duration(seconds: 5)),
                                      notificationDetails,
                                      payload: '{slideList[random][].toString()}',

                                  );
                                },
                                child: Container(
                                  width: .43.sw,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    color: servicePrimaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 4,
                                        offset: const Offset(0, 4), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Sos Requests",
                                        style: GoogleFonts.inter(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w400),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            StreamBuilder<List<SosModel>>(
                                              stream: SosService.newSosRequest(),
                                              builder: (context, snapshot) {
                                                return snapshot.hasData && snapshot.data != null
                                                    ? Text(
                                                        snapshot.data!.length.toString(),
                                                        style: GoogleFonts.inter(
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                      )
                                                    : const SizedBox();
                                              },
                                            ),
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
                              // Container(
                              //   width: .43.sw,
                              //   decoration: BoxDecoration(
                              //     borderRadius: const BorderRadius.all(Radius.circular(20)),
                              //     color: servicePrimaryColor,
                              //     boxShadow: [
                              //       BoxShadow(
                              //         color: Colors.grey.withOpacity(0.2),
                              //         spreadRadius: 5,
                              //         blurRadius: 4,
                              //         offset: const Offset(0, 4), // changes position of shadow
                              //       ),
                              //     ],
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: GestureDetector(
                              //       onTap: () => Get.toNamed('/newBooking'),
                              //       child: Column(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         children: [
                              //           Text(
                              //             "New Bookings",
                              //             style: GoogleFonts.inter(
                              //               fontSize: 16.0,
                              //               color: Colors.black,
                              //               fontWeight: FontWeight.w400,
                              //             ),
                              //           ),
                              //           Padding(
                              //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              //             child: Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 StreamBuilder<List<BusinessModel>>(
                              //                   stream: BusinessServices.newBookings(),
                              //                   builder: (context, snapshot) {
                              //                     if (homePageController.userData.value.serviceProviderDetails != null &&
                              //                         homePageController.userData.value.serviceProviderDetails!.businessType == "Maps") {
                              //                       return const SizedBox();
                              //                     }
                              //                     return snapshot.hasData && snapshot.data != null
                              //                         ? Text(
                              //                       snapshot.data!.length.toString(),
                              //                       style: GoogleFonts.inter(
                              //                         fontSize: 18.0,
                              //                         color: Colors.black,
                              //                         fontWeight: FontWeight.w400,
                              //                       ),
                              //                     )
                              //                         : const SizedBox();
                              //                   },
                              //                 ),
                              //                 Image.asset(
                              //                   'assets/icons/service_provider_new_bookings.png',
                              //                   width: .2.sw,
                              //                   fit: BoxFit.fitWidth,
                              //                 )
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
