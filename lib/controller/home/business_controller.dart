// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Rx<LatLng> initalMapCameraPosition =
      LatLng(37.42796133580664, -122.085749655962).obs;

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  late Razorpay _razorpay;

  String? walletLogo;

  @override
  void onInit() {
    _razorpay = Razorpay();
    _razorpay.initilizeSDK('rzp_test_HjmiukVH13l5u3');
    notifyChildrens();
    getLocationAndCreateMap();
    super.onInit();
  }

  Stream<List<BusinessModel>?> getBusiness() {
    isLoading(true);
    var id = Get.parameters["subCategoryUID"];

    // JUST FOR BACKUP
    subCategoryUID.value = id.toString();

    // REQUESTING FOR DATA
    var response = BusinessServices()
        .getBusiness(subCategoryUID.value, subCategory.subCategoryType);

    // VERIFYING RESPONSE
    //   selectedBusiness.value = response.first;
    selectedBusiness.update((val) {});
    isLoading(false);
    return response;
  }

  selectBusiness(selectBusiness) {
    selectedBusiness.value = selectBusiness;
    // selectedBusiness.update((val) {});
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

  void getLocationAndCreateMap() async {
    Location location = Location();

    bool serviceEnabled = false;
    PermissionStatus permissionGranted;
    LocationData locationData;

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    var longitude = locationData.longitude!;
    var latitude = locationData.latitude!;

    initalMapCameraPosition.value = LatLng(
      latitude,
      longitude,
    );

    final GoogleMapController controller = await mapController.future;
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            latitude,
            longitude,
          ),
          zoom: 14.4746,
        ),
      ),
    );

    location.onLocationChanged.listen((newLoc) {
      longitude = newLoc.longitude!;
      latitude = newLoc.latitude!;

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newLoc.latitude!, newLoc.longitude!),
            zoom: 13.4746,
          ),
        ),
      );
    });
  }
}
