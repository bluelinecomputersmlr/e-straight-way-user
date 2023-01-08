import 'package:estraightwayapp/controller/home/profile_page_controller.dart';
import 'package:estraightwayapp/service/service_provider/service_provider.dart';
import 'package:get/get.dart';

class MyBusinessController extends GetxController {
  var isLoading = false.obs;
  var businessData = [].obs;
  var isError = false.obs;
  var errorMessage = "".obs;

  @override
  void onInit() {
    getBusinessDate();
    super.onInit();
  }

  void getBusinessDate() async {
    isLoading(true);
    var profileController = Get.put(ProfilePageController());
    var businessId = profileController
        .userData.value.serviceProviderDetails!.businessUID
        .toString();

    var response = await ServiceProviderService().getBusiness(businessId);

    if (response["status"] == "success") {
      businessData.value = response["data"];
    }

    isLoading(false);
  }
}
