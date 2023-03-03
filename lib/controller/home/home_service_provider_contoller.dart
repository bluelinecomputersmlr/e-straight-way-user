import 'package:carousel_slider/carousel_slider.dart';
import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/model/single_course_model.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:estraightwayapp/service/service_provider/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ntp/ntp.dart';

class HomeServiceProviderController extends GetxController {
  Rx<UserModel> userData = UserModel().obs;
  var isMainPageLoading = false.obs;
  final CarouselController carouselController = CarouselController();
  var currentIndex = 0;
  var isMainError = false.obs;
  List<String>? banners = [];
  var mainErrorMessage = "".obs;
  DateTime dateTime = DateTime.now();

  RxList categories = [].obs;

  var lastLocationUpdated = DateTime.now();

  var dashboardDataCount = {
    "receivedBookingCount": 0,
    "newBookingCount": 0,
    "todaysConfirmedBookingCount": 0,
    "todaysCancelledBookingCount": 0,
    "customerReviewsCount": 0,
  }.obs;

  @override
  void onInit() {
    getUserData();

    super.onInit();
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

  void getUserData() async {
    isMainPageLoading(true);
    var response = await HomePageService().getUserData();
    if (response["status"] == "success") {
      userData.value = UserModel.fromJson(response["user"]);
      dateTime = await NTP.now();

      if (userData.value.isInitialPaymentDone == null &&
          userData.value.lastLoggedAsUser == false) {
        Get.offAllNamed('/doPayment');
      }
    } else {
      isMainError(true);
      mainErrorMessage.value = response["message"];
    }
    if (userData.value.isServiceProvider == true &&
        userData.value.lastLoggedAsUser == false) {
      if (userData.value.serviceProviderDetails!.businessType == "map") {
        getLocation();
      }
    }
    Map<String, int> dashboardData =
        await BusinessServices().getAllDasboardData();
    dashboardDataCount.value = dashboardData;
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
}
