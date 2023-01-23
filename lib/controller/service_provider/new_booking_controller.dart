import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:get/get.dart';

class NewBookingController extends GetxController {
  Stream<List?> getBookingsStream() {
    // REQUESTING FOR DATA
    var response = BusinessServices().getBookingsStreamServiceProvider();

    return response;
  }
}
