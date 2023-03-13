import 'package:estraightwayapp/service/home/user_services.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  var walletAmount = 0.obs;
  var transactionData = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() async {
    isLoading(true);

    var userDataResponse = await UserServices().getUserData();

    if (userDataResponse["status"] == "success") {
      var walletAmountData = userDataResponse["data"][0]["wallet"];

      if (walletAmountData != null) {
        walletAmount.value = walletAmountData;
      } else {
        walletAmount.value = 0;
      }

      var transactionDataResponse = await UserServices().getTransactions();

      if (transactionDataResponse["status"] == "success") {
        transactionData.value = transactionDataResponse["data"];
      } else {
        transactionData.value = [];
      }
    } else {
      walletAmount.value = 0;
    }

    isLoading(false);
  }
}
