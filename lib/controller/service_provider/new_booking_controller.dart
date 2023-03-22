import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/home/user_services.dart';
import 'package:get/get.dart';

class NewBookingController extends GetxController {
  var isMapBasedUser = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void getUserData() async {
    var response = await UserServices().getUserData();

    if (response["status"] == "success") {
      if (response["data"][0]["serviceProviderDetails"]["businessType"] ==
          "Map") {
        isMapBasedUser.value = true;
      } else {
        isMapBasedUser.value = false;
      }
    }
  }

  Stream<List?> getBookingsStream() {
    // REQUESTING FOR DATA
    var response = BusinessServices().getBookingsStreamServiceProvider();

    return response;
  }
}
