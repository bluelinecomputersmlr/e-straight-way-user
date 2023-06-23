import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:get/get.dart';

class ReceivedBookingController extends GetxController {
  UserModel? userModel;

  Future<void> getStraightWayUser() async {
    Map response = await HomePageService().getUserData();
    if (response["status"] == "success") {
      userModel = UserModel.fromJson(response["user"]);
    }
  }

  // int recivedBookings = 0;
  Stream<List?> getBookingsStream() {
    // REQUESTING FOR DATA
    var response = BusinessServices().getRecievedBookingsStreamServiceProvider();
    // recivedBookings = response.length;
    return response;
  }

  Stream<List?> getTodaysAcceptedBookingsStream() {
    // REQUESTING FOR DATA
    var response = BusinessServices().getTodaysAcceptedBookingsStreamServiceProvider();

    return response;
  }

  Stream<List?> getTodaysCancelledBookingsStream() {
    // REQUESTING FOR DATA
    var response = BusinessServices().getTodaysRejectedBookingsStreamServiceProvider();
    return response;
  }

  Stream<List?> getCustomerReviews() {
    // REQUESTING FOR DATA
    var response = BusinessServices().getCustomerReviewsStreamServiceProvider();

    return response;
  }
}
