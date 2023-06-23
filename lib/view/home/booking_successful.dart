import 'dart:developer';

import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/home/business_controller.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/notification_service.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/service_provider/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

class BookingSuccesfulPage extends StatefulWidget {
  const BookingSuccesfulPage({super.key});

  @override
  State<BookingSuccesfulPage> createState() => _BookingSuccesfulPageState();
}

class _BookingSuccesfulPageState extends State<BookingSuccesfulPage> {

  @override
  void initState() {
    sendNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments = Get.arguments;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/booking_successful.json',
                repeat: false, height: 200, width: 200),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Booking Successful",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: kPrimaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  Get.offAllNamed("/home");
                },
                child: Container(
                  width: 1.sw,
                  height: .12.sw,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('Return Home'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendNotifications() async {
    var response = BusinessServices().getBusiness(await getPrefStringValue('subCategoryUID') ?? '', '');
    response.forEach((element) {
      for (BusinessModel elements in element ?? []) {
        if (elements.businessFcmToken != null && elements.businessFcmToken!.isNotEmpty) {
          NotificationService.instance.sendNotification(elements.businessFcmToken, "Your have a new Service request");
        }
      }
    });
  }
}
