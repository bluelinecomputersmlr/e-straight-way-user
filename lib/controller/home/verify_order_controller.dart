import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class VerifyOrderController extends GetxController {
  var selectedOrder = {}.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() {
    selectedOrder["uid"] = Get.parameters["uid"];
    selectedOrder["businessImage"] = Get.parameters["businessImage"];
    selectedOrder["price"] = Get.parameters["price"];
    selectedOrder["businessName"] = Get.parameters["businessName"];
    selectedOrder["serviceName"] = Get.parameters["serviceName"];
  }

  void submitData(BuildContext context) async {
    isLoading(true);
    Map<String, dynamic> bookingData = {};

    var userData = await HomePageService().getUserData();

    if (userData["status"] == "success") {
      bookingData["businessId"] = selectedOrder["uid"];
      bookingData["businessName"] = selectedOrder["businessName"];
      bookingData["price"] = selectedOrder["price"];
      bookingData["serviceName"] = selectedOrder["serviceName"];
      bookingData["basicChargePaid"] = 100;
      bookingData["userId"] = userData["user"]["uid"];
      bookingData["userName"] = userData["user"]["userName"];
      bookingData["phoneNumber"] = userData["user"]["phoneNumber"];
      bookingData["bookedDate"] = DateTime.now();
      bookingData["isServiceProviderAccepted"] = false;
      bookingData["id"] = const Uuid().v4();
    }

    var response = await BusinessServices().bookService(bookingData);

    if (response["status"] == "success") {
      print("Order Placed");
    } else {
      final snackBar = SnackBar(
        content: Text(
          response["message"],
        ),
        action: SnackBarAction(
          label: 'Okay',
          onPressed: () {},
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    isLoading(false);
  }
}
