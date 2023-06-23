// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:developer';

import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:estraightwayapp/notification_service.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/location_service.dart';
import 'package:estraightwayapp/service/service_provider/shared_preference_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';

class BusinessController extends GetxController {
  var isLoading = false.obs;

  SubCategoryModel subCategory = Get.arguments;

  var subCategoryUID = "".obs;

  var isError = false.obs;

  var errorMessage = "".obs;

  Rx<BusinessModel> selectedBusiness = BusinessModel().obs;

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

  Rx<LatLng>? initalMapCameraPosition;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  late Razorpay _razorpay;

  String? walletLogo;
  String ? phoneNumber = '';

  @override
  void onInit() {
    _razorpay = Razorpay();
    _razorpay.initilizeSDK('rzp_test_HjmiukVH13l5u3');
    notifyChildrens();
    getLocationAndCreateMap();
    phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber!.toString();
    super.onInit();
  }

  Stream<List<BusinessModel>?>? getBusiness() {
    isLoading(true);
    var id = Get.parameters["subCategoryUID"];
    var pinCode = Get.parameters["pinCode"];

    // JUST FOR BACKUP
    subCategoryUID.value = id.toString();

    // REQUESTING FOR DATA
    var response = BusinessServices().getBusiness(subCategoryUID.value, subCategory.subCategoryType);
    // BusinessServices().getBusinessRadius(subCategoryUID.value, subCategory.subCategoryType);

    // VERIFYING RESPONSE
    //   selectedBusiness.value = response.first;
    setPrefStringValue('subCategoryUID', subCategoryUID.value);
    getLocationAndCreateMap();
    selectedBusiness.update((val) {});
    isLoading(false);
    return response;
  }

  selectBusiness(selectBusiness) {
    selectedBusiness.value = selectBusiness;
    selectedBusiness.update((val) {});
  }

  void getWalletLogo() async {
    walletLogo =
        await _razorpay.getWalletLogoUrl(paymentOptions.first['wallet']);
  }

  void updateval(Map<String, dynamic> payments) {
    paymentOptions = [].obs;
    paymentOptions.add(payments);
  }

  // All about google maps

  Future<void> getLocationAndCreateMap() async {
    Location location = Location();

    bool isPermissionGranted = await SagarLocationService.instance.checkLocationPermission();
    print('getLocationAndCreateMap isPermissionGranted --> $isPermissionGranted');
    if (!isPermissionGranted) {
      await getLocationAndCreateMap();
    }
    Position currentPosition = await SagarLocationService.instance.getCurrentLocation();
    print('getLocationAndCreateMap position --> ${currentPosition.toJson()}');

    var longitude = currentPosition.longitude;
    var latitude = currentPosition.latitude;

    initalMapCameraPosition = LatLng(latitude, longitude).obs;
    log('getLocationAndCreateMap Initial --> $initalMapCameraPosition');
    final GoogleMapController controller = await mapController.future;
    controller.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 14.4746)),
    );

    location.onLocationChanged.listen(
      (newLoc) {
        longitude = newLoc.longitude ?? 0;
        latitude = newLoc.latitude ?? 0;

        controller.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(newLoc.latitude!, newLoc.longitude!), zoom: 13.4746)),
        );
      },
    );
    refresh();
  }
}
