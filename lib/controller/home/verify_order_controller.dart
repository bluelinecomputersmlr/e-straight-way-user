import 'package:get/get.dart';

class VerifyOrderController extends GetxController {
  var selectedOrder = {}.obs;

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
}
