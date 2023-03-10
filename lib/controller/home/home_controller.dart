import 'package:carousel_slider/carousel_slider.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocoding/geocoding.dart' as GeoCoding;
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

  var currentTabIndex = 0.obs;

  @override
  void onInit() {
    getUserData();
    getBanners();
    getCategories();
    notifyChildrens();
    getLocation();
    getSubCategories();
    super.onInit();
  }

  void toggleTabIndex(int index) {
    currentTabIndex.value = index;
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

    longitude.value = _locationData.longitude!;
    latitude.value = _locationData.latitude!;

    List<GeoCoding.Placemark> placemarks =
        await GeoCoding.placemarkFromCoordinates(
            _locationData.latitude!, _locationData.longitude!);

    currentPlace.value =
        "${placemarks[0].toString().split(",")[9].split(":")[1]} ${placemarks[0].toString().split(",")[8].split(":")[1]} ${placemarks[0].toString().split(",")[7].split(":")[1]}";

    location.onLocationChanged.listen((newLoc) async {
      longitude.value = newLoc.longitude!;
      latitude.value = newLoc.latitude!;
      List<GeoCoding.Placemark> placemarks =
          await GeoCoding.placemarkFromCoordinates(
              newLoc.latitude!, newLoc.longitude!);
      currentPlace.value =
          "${placemarks[0].toString().split(",")[9].split(":")[1]} ${placemarks[0].toString().split(",")[8].split(":")[1]} ${placemarks[0].toString().split(",")[7].split(":")[1]}";
    });
  }

  void getUserData() async {
    isMainPageLoading(true);
    var response = await HomePageService().getUserData();
    if (response["status"] == "success") {
      userData.value = UserModel.fromJson(response["user"]);
    } else {
      isMainError(true);
      mainErrorMessage.value = response["message"];
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

  void getSubCategories() async {
    isMainPageLoading(true);
    subCategories.value =
        await HomePageService().getSubCategories().whenComplete(() {
      subCategories.obs.update((val) {});
    });
    isMainPageLoading(false);
  }
}
