import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/notification_service.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:estraightwayapp/service/location_service.dart';
import 'package:estraightwayapp/view/auth/admin_service.dart';
import 'package:estraightwayapp/view/auth/booking_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocoding/geocoding.dart' as GeoCoding;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

class HomePageController extends GetxController {
  Rx<UserModel> userData = UserModel().obs;
  var isMainPageLoading = false.obs;
  final CarouselController carouselController = CarouselController();
  var currentIndex = 0;
  var isMainError = false.obs;
  List<String>? banners = [];
  var mainErrorMessage = "".obs;

  RxList categories = [].obs;

  RxList subCategories = [].obs;

  var longitude = 0.0.obs;

  var latitude = 0.0.obs;

  var currentPlace = "".obs;

  // @override
  // void onInit() {
  //   getLocation();
  //
  //   getUserData();
  //   getBanners();
  //   getCategories();
  //   notifyChildrens();
  //   getSubCategories();
  //   super.onInit();
  // }

  Future<void> getLocation() async {
    Location location = Location();

    bool isPermissionGranted = await SagarLocationService.instance.checkLocationPermission();
    print('Current Home isPermissionGranted --> $isPermissionGranted');
    if (!isPermissionGranted) return;
    Position currentPosition = await SagarLocationService.instance.getCurrentLocation();
    print('Current Home position --> ${currentPosition.toJson()}');

    longitude.value = currentPosition.longitude;
    latitude.value = currentPosition.latitude;

    List<GeoCoding.Placemark> placemarks = await GeoCoding.placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);

    currentPlace.value =
        "${placemarks[0].toString().split(",")[9].split(":")[1]} ${placemarks[0].toString().split(",")[8].split(":")[1]} ${placemarks[0].toString().split(",")[7].split(":")[1]}";
    update();

    location.onLocationChanged.listen((newLoc) async {
      longitude.value = newLoc.longitude!;
      latitude.value = newLoc.latitude!;
      List<GeoCoding.Placemark> placeMarks = await GeoCoding.placemarkFromCoordinates(newLoc.latitude!, newLoc.longitude!);
      currentPlace.value =
          "${placeMarks[0].toString().split(",")[9].split(":")[1]} ${placeMarks[0].toString().split(",")[8].split(":")[1]} ${placeMarks[0].toString().split(",")[7].split(":")[1]}";
      update();
    });
  }

  Future<void> getUserData() async {
    isMainPageLoading(true);
    var response = await HomePageService().getUserData();
    log('Users data --> $response');
    if (response["status"] == "success") {
      log('User data --> $response');
      userData.value = UserModel.fromJson(response["user"]);
      log('User data value --> ${userData.value.toJson()}');
    } else {
      isMainError(true);
      mainErrorMessage.value = response["message"];
    }
    isMainPageLoading(false);
    update();
  }

  void updateIndex(index) {
    currentIndex = index;
    notifyChildrens();
  }

  void getBanners() async {
    banners = await HomePageService().getBanners().whenComplete(() {
      notifyChildrens();
    });
  }

  void getCategories() async {
    isMainPageLoading(true);
    categories.value = await HomePageService().getCategories().whenComplete(() {
      categories.obs.update((val) {});
    });
    isMainPageLoading(false);
    update();
  }

  void getSubCategories() async {
    isMainPageLoading(true);
    subCategories.value = await HomePageService().getSubCategories().whenComplete(() => subCategories.obs.update((val) {}));
    isMainPageLoading(false);
    update();
  }
}
