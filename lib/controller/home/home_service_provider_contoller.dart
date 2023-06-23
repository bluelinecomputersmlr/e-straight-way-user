import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/model/single_course_model.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:estraightwayapp/service/location_service.dart';
import 'package:estraightwayapp/service/service_provider/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ntp/ntp.dart';

import '../service_provider/select_location_controller.dart';

class HomeServiceProviderController extends GetxController {
  HomeServiceProviderController({required});
  Rx<UserModel> userData = UserModel().obs;
 var businessResponse;
  var isMainPageLoading = false.obs;
  final CarouselController carouselController = CarouselController();
  var currentIndex = 0;
  var isMainError = false.obs;
  List<String>? banners = [];
  var mainErrorMessage = "".obs;
  DateTime dateTime = DateTime.now();
  bool isPay = false;
  RxList categories = [].obs;
  RxBool isSendLocation = true.obs;

  var lastLocationUpdated = DateTime.now();

  Timer? timer;

  setLocation() => timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => updateLocation());

  Future<void> updateLocation() async {
    bool isPermissionGranted = await SagarLocationService.instance.checkLocationPermission();
    print('Current isPermissionGranted --> $isPermissionGranted');
    if (!isPermissionGranted) return;
    Position currentPosition = await SagarLocationService.instance.getCurrentLocation();
    print('Current position --> ${currentPosition.toJson()}');
    if (FirebaseAuth.instance.currentUser == null) return;
    await LocationService().updateBusinessLocation(
      FirebaseAuth.instance.currentUser!.uid,
      isSendLocation.value ? LatLng(currentPosition.latitude, currentPosition.longitude) : const LatLng(0, 0),
    );
  }

  void getLocation() async {
    Location location = Location();

    bool serviceEnabled = false;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    location.onLocationChanged.listen((newLoc) async {
      if (-lastLocationUpdated.difference(DateTime.now()) >
          const Duration(minutes: 5)) {
        lastLocationUpdated = DateTime.now();
        print(FirebaseAuth.instance.currentUser!.uid);
        await LocationService().updateBusinessLocation(
          FirebaseAuth.instance.currentUser!.uid,
          LatLng(newLoc.latitude!, newLoc.longitude!),
        );
      }
    });
  }

  Future<void> getUserData() async {
    isMainPageLoading(true);
    var response = await HomePageService().getUserData();
    if (response["status"] == "success") {
      userData.value = UserModel.fromJson(response["user"]);
      dateTime = await NTP.now();
      log('userData.value :::: ${userData.value}');
      if (userData.value.isInitialPaymentDone == null && userData.value.lastLoggedAsUser == false) {
        if (!isPay) Get.offAllNamed('/doPayment');
        isMainPageLoading(false);
        return;
      }

      businessResponse =
          await HomePageService().getBusinessData(userData.value.serviceProviderDetails!.businessUID.toString());
      log('businessResponse jemin ====== ${businessResponse["status"]}');
      log('businessResponse jemin ====== ${businessResponse["data"]["isApproved"]}');
      if (businessResponse["status"] == "success") {
        isMainPageLoading(false);
        if (businessResponse['data']['isApproved'] == null || businessResponse["data"]["isApproved"] == false) {
          Get.offAllNamed("/wait");
        }
      }
    } else {
      isMainPageLoading(false);
      isMainError(true);
      mainErrorMessage.value = response["message"];
    }
    if (userData.value.isServiceProvider == true && userData.value.lastLoggedAsUser == false) {
      if (userData.value.serviceProviderDetails!.businessType == "map") {
        getLocation();
      }
    }
    isMainPageLoading(false);
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
  }

  void isFromPay(value) {
    isPay = value;
  }
}
