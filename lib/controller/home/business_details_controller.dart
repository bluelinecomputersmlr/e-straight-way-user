import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';

class BusinessDetailsController extends GetxController {
  final CarouselController carouselController = CarouselController();
  var isLoading = false.obs;
  BusinessModel business = Get.arguments;
  var subCategoryUID = "".obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var currentIndex = 0.obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  Rx<DateTime> currentDate2 = DateTime.now().obs;
  RxString currentMonth = DateFormat.yMMM().format(DateTime.now()).obs;
  Rx<DateTime> targetDateTime = DateTime.now().obs;
  var selectedBusinessIndex = 0.obs;

  RxList paymentOptions = [
    {
      "key": 'rzp_test_HjmiukVH13l5u3',
      "currency": "INR",
      "contact":
          "${(FirebaseAuth.instance.currentUser != null ? (FirebaseAuth.instance.currentUser!.phoneNumber != null && FirebaseAuth.instance.currentUser!.phoneNumber != "") : false) ? FirebaseAuth.instance.currentUser!.phoneNumber! : "9999999999"}",
      "email":
          "${(FirebaseAuth.instance.currentUser != null ? (FirebaseAuth.instance.currentUser!.email != null && FirebaseAuth.instance.currentUser!.email != "") : false) ? FirebaseAuth.instance.currentUser!.email! : "info@estraightwayapp.com"}",
      '_[flow]': 'intent',
    }
  ].obs;
  late Razorpay _razorpay;

  String? walletLogo;
  void updateIndex(index) {
    currentIndex.value = index;
    currentIndex.update((val) {});
    notifyChildrens();
  }

  @override
  void onInit() {
    _razorpay = Razorpay();
    _razorpay.initilizeSDK('rzp_test_HjmiukVH13l5u3');
    notifyChildrens();
    super.onInit();
  }

  void onCalanderChanged(DateTime date) {
    targetDateTime.value = date;
    currentMonth.value = DateFormat.yMMM().format(targetDateTime.value);
    print(targetDateTime.value);
    targetDateTime.update((val) {});
  }

  void onDayPressed(DateTime date, List<Event> events) {
    currentDate2.value = date;
    currentDate2.update((val) {});
    events.forEach((event) => print(event.title));
  }

  void onPreviousPressed() {
    if (targetDateTime.value.isAfter(DateTime.now())) {
      targetDateTime.value =
          DateTime(targetDateTime.value.year, targetDateTime.value.month - 1);
      currentMonth.value = DateFormat.yMMM().format(targetDateTime.value);
    }
  }

  void onNextPressed() {
    targetDateTime.value =
        DateTime(targetDateTime.value.year, targetDateTime.value.month + 1);
    currentMonth.value = DateFormat.yMMM().format(targetDateTime.value);
  }

  void getWalletLogo() async {
    walletLogo =
        await _razorpay.getWalletLogoUrl(paymentOptions.first['wallet']);
  }

  void updateval(Map<String, dynamic> payments) {
    paymentOptions = [].obs;
    paymentOptions.add(payments);
  }
}
