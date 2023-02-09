import 'package:estraightwayapp/controller/home/profile_page_controller.dart';
import 'package:estraightwayapp/service/service_provider/service_provider.dart';
import 'package:get/get.dart';

class MyBusinessController extends GetxController {
  var isLoading = false.obs;
  var businessData = [].obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var isInitialValueSet = false.obs;
  var businessId = "".obs;

  var editBusinessButtonText = "Save".obs;

  var addNewServiceButtonText = "Add Service".obs;

  @override
  void onInit() {
    getBusinessData();
    super.onInit();
  }

  void getBusinessData() async {
    isLoading(true);
    var profileController = Get.put(ProfilePageController());
    businessId.value = profileController
        .userData.value.serviceProviderDetails!.businessUID
        .toString();

    var response = await ServiceProviderService().getBusiness(businessId.value);

    if (response["status"] == "success") {
      businessData.value = response["data"];
    }

    isLoading(false);
  }

  void changeEditButtonText(String text) {
    editBusinessButtonText.value = text;
  }

  void toggleInitialValueStatus(bool val) {
    isInitialValueSet(val);
  }

  void toggleAddServiceButton(String val) {
    addNewServiceButtonText(val);
  }
}
