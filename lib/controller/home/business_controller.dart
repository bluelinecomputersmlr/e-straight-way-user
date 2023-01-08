import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/model/single_course_model.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:estraightwayapp/service/home/business_service.dart';
import 'package:estraightwayapp/service/home/sub_category_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';

class BusinessController extends GetxController {
  var isLoading = false.obs;
  SubCategoryModel subCategory = Get.arguments;
  var subCategoryUID = "".obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  Rx<BusinessModel> selectedBusiness = BusinessModel().obs;
  RxList paymentOptions = [
    {
      "key": 'rzp_test_HjmiukVH13l5u3',
      "currency": "INR",
      "contact":
          "${(FirebaseAuth.instance.currentUser != null ? (FirebaseAuth.instance.currentUser!.phoneNumber != null && FirebaseAuth.instance.currentUser!.phoneNumber != "") : false) ? FirebaseAuth.instance.currentUser!.phoneNumber! : "9999999999"}",
      "email":
          "${(FirebaseAuth.instance.currentUser != null ? (FirebaseAuth.instance.currentUser!.email != null && FirebaseAuth.instance.currentUser!.email != "") : false) ? FirebaseAuth.instance.currentUser!.email! : "info@estraightwayapp.com"}",
      '_[flow]': 'intent',
    }
  ].obs;
  late Razorpay _razorpay;

  String? walletLogo;

  @override
  void onInit() {
    _razorpay = Razorpay();
    _razorpay.initilizeSDK('rzp_test_HjmiukVH13l5u3');
    notifyChildrens();
    super.onInit();
  }

  Stream<List<BusinessModel>?> getBusiness() {
    isLoading(true);
    var id = Get.parameters["subCategoryUID"];

    print(subCategory.subCategoryType);

    // JUST FOR BACKUP
    subCategoryUID.value = id.toString();

    // REQUESTING FOR DATA
    var response = BusinessServices()
        .getBusiness(subCategoryUID.value, subCategory.subCategoryType);

    // VERIFYING RESPONSE
    //   selectedBusiness.value = response.first;
    selectedBusiness.update((val) {});
    isLoading(false);
    return response;
  }

  selectBusiness(selectBusiness) {
    selectedBusiness.value = selectBusiness;
    selectedBusiness.update((val) {});
  }

  void getWalletLogo() async {
    walletLogo =
        await _razorpay.getWalletLogoUrl(paymentOptions.first['wallet']);
  }

  void updateval(Map<String, dynamic> payments) {
    paymentOptions = [].obs;
    paymentOptions.add(payments);
  }
}
