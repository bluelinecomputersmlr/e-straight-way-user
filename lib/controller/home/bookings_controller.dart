import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:get/get.dart';

class BookingsController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;

  var bookingsData = [].obs;

  var givenRating = 0.obs;

  @override
  void onInit() {
    getBookings();
    super.onInit();
  }

  void getBookings() async {
    isLoading(true);
    var response = await BusinessServices().getBookedService();

    if (response["status"] == "success") {
      bookingsData.value = response["data"];
    } else {
      isError(true);
      errorMessage.value = "Something went wrong!";
    }
    isLoading(false);
  }

  Stream<List?> getBookingsStream() {
    // REQUESTING FOR DATA
    var response = BusinessServices().getBookingsStream();

    return response;
  }

  void setRating(int rating) {
    givenRating.value = rating;
  }
}
