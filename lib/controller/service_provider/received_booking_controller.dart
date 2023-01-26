import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:get/get.dart';

class ReceivedBookingController extends GetxController {
  Stream<List?> getBookingsStream() {
    // REQUESTING FOR DATA
    var response =
        BusinessServices().getRecievedBookingsStreamServiceProvider();

    return response;
  }

  Stream<List?> getTodaysAcceptedBookingsStream() {
    // REQUESTING FOR DATA
    var response =
        BusinessServices().getTodaysAcceptedBookingsStreamServiceProvider();

    return response;
  }
}
