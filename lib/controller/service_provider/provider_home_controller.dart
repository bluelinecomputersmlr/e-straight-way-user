import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:get/get.dart';

class ProviderHomeController extends GetxController {
  var isLoading = false.obs;
  var dashboardDataCount = {
    "receivedBookingCount": 0,
    "newBookingCount": 0,
    "todaysConfirmedBookingCount": 0,
    "todaysCancelledBookingCount": 0,
    "customerReviewsCount": 0,
  }.obs;

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  void getAllData() async {
    isLoading(true);
    Map<String, int> dashboardData =
        await BusinessServices().getAllDasboardData();

    dashboardDataCount.value = dashboardData;
    isLoading(false);
  }
}
