import 'package:estraightwayapp/service/home/user_services.dart';
import 'package:estraightwayapp/service/home/wallet_service.dart';
import 'package:estraightwayapp/widget/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../controller/home/add_money_controller.dart';

class AddMoney extends StatelessWidget {
  AddMoney({super.key});

  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addMoneyController = Get.put(AddMoneyController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 1,
                  blurRadius: 15,
                )
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Enter the amount",
                      style: GoogleFonts.inter(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: size.width * 0.50,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        var amount = _amountController.text;
                        if (amount.isNotEmpty) {
                          _addMoney(context, amount, addMoneyController);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            "Add Money",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.toNamed("/refer");
      }),
    );
  }
}

void _addMoney(
    BuildContext context, String amount, AddMoneyController controller) async {
  var transactionId = const Uuid().v4();
  var transactionData = {
    "amount": int.parse(amount),
    "fromUserId": "",
    "message": "Wallet",
    "type": "Credit",
    "createdDate": DateTime.now(),
    "id": transactionId,
    "userId": FirebaseAuth.instance.currentUser?.uid,
  };

  var userResponse = await UserServices().getUserData();

  if (userResponse["status"] == "success") {
    var userId = userResponse["data"][0]["uid"];
    var walletAmount = userResponse["data"][0]["wallet"];
    Map<String, int> data;

    if (walletAmount != null) {
      data = {
        "wallet": walletAmount + int.parse(amount),
      };
    } else {
      data = {
        "wallet": int.parse(amount),
      };
    }

    var userData = {
      "userName": userResponse["data"][0]["userName"],
      "userId": userId,
      "phoneNumber": userResponse["data"][0]["phoneNumber"]
    };

    // ignore: use_build_context_synchronously
    controller.pay(context, transactionData, data, userData);
  } else {
    Get.back();
    // ignore: use_build_context_synchronously
    showErrorSnackbar(context, userResponse["message"]);
  }
}
