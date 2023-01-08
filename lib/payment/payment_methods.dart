//import 'package:rentl/payment/card_details.dart';

import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/payment/wallets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';
import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart' as http;
import '../widget/text_form_feild.dart';
import 'models/card_info_model.dart';
//import 'net_banking.dart';

class PaymentSelectionPage extends StatefulWidget {
  PaymentSelectionPage(this.grandTotal);
  double grandTotal;
  @override
  _PaymentSelectionPageState createState() => _PaymentSelectionPageState();
}

class _PaymentSelectionPageState extends State<PaymentSelectionPage> {
  String selectedPaymentType = 'CARD';
  CardInfoModel? cardInfoModel;
  String key = "rzp_live_Bm7fhzUxrM1frD";
  String? availableUpiApps;
  bool showVPAMethod = false;

  //rzp_test_1DP5mmOlF5G5ag  ---> Debug Key
  //rzp_live_6KzMg861N1GUS8  ---> Live Key
  //rzp_live_cepk1crIu9VkJU  ---> Pay with Cred

  Map<String, dynamic>? netBankingOptions;
  Map<String, dynamic>? walletOptions;
  TextEditingController upiNumber = TextEditingController();

  Map<dynamic, dynamic>? paymentMethods;
  List<NetBankingModel>? netBankingList;
  List<WalletModel>? walletsList;
  late Razorpay _razorpay;
  Map<String, dynamic>? commonPaymentOptions;

  var apps;
  String paymentMethod = 'GOOGLEPAY';

  String phoneNo = '';

  @override
  void initState() {
    cardInfoModel = CardInfoModel();
    _razorpay = Razorpay();
    _razorpay.initilizeSDK(key);

    fetchAllPaymentMethods();

    walletOptions = {
      'key': key,
      'amount': widget.grandTotal,
      'currency': 'INR',
      "contact":
          "${(FirebaseAuth.instance.currentUser!.phoneNumber != null && FirebaseAuth.instance.currentUser!.phoneNumber != "") ? FirebaseAuth.instance.currentUser!.phoneNumber! : "9999999999"}",
      "email":
          "${(FirebaseAuth.instance.currentUser!.email != null && FirebaseAuth.instance.currentUser!.email != "") ? FirebaseAuth.instance.currentUser!.email! : "info@estraightwayapp.com"}",
      'method': 'upi',
    };

    commonPaymentOptions = {};

    super.initState();
  }

  void _verifyUPI() async {
    var uname = 'rzp_live_Bm7fhzUxrM1frD';
    var pword = 'rATj0FwTR2oCwFEGUF66yA3B';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': authn,
    };

    var data = '{"vpa": "${upiNumber.text}"}';

    var url = Uri.parse('https://api.razorpay.com/v1/payments/validate/vpa');
    var res = await http.post(url, headers: headers, body: data);
    //print(res.body);
    if (res.statusCode != 200) {
      Fluttertoast.showToast(
        msg: "Enter valid upi id",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    } else {
      //print(upiNumber);
      walletOptions!['_[flow]'] = 'collect';
      walletOptions!['vpa'] = upiNumber.text;
      Navigator.pop(context, walletOptions);
    }
    //print(res.body);
  }

  fetchAllPaymentMethods() {
    _razorpay.getPaymentMethods().then((value) {
      paymentMethods = value;
      getsupportedUPI();
      configureNetbanking();
      configurePaymentWallets();
    }).onError((error, stackTrace) {
      //print('Error Fetching payment methods: $error');
    });
  }

  void getsupportedUPI() async {
    apps = await _razorpay.getAppsWhichSupportUpi();
    //print(apps);
    setState(() {});
  }

  configureNetbanking() {
    netBankingList = [];
    final nbDict = paymentMethods?['netbanking'];
    nbDict.entries.forEach(
      (element) {
        netBankingList?.add(
          NetBankingModel(bankKey: element.key, bankName: element.value),
        );
      },
    );
  }

  configurePaymentWallets() {
    walletsList = [];
    final walletsDict = paymentMethods?['wallet'];
    walletsDict.entries.forEach(
      (element) {
        if (element.value == true) {
          walletsList?.add(
            WalletModel(walletName: element.key),
          );
          //print(element.value);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Choose payment method',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            buildUPIForm(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 2,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Text(
                        "Wallets",
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_rounded,
                              ),
                            ],
                          ),
                          title: Text("Pay via Wallets"),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Wallets()),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            //   child: Text(
            //     "Cards",
            //     style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.2),
            //           spreadRadius: 3,
            //           blurRadius: 2,
            //           offset: Offset(0, 2), // changes position of shadow
            //         ),
            //       ],
            //     ),
            //     child: ListTile(
            //       leading: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Icon(
            //             Icons.credit_card_outlined,
            //           ),
            //         ],
            //       ),
            //       title: Text("Pay via Credit/Debit Card"),
            //       trailing: Icon(Icons.arrow_forward_ios),
            //       onTap: () async {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => CardPaymentsPage()),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            //   child: Text(
            //     "Net Banking",
            //     style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.2),
            //           spreadRadius: 3,
            //           blurRadius: 2,
            //           offset: Offset(0, 2), // changes position of shadow
            //         ),
            //       ],
            //     ),
            //     child: ListTile(
            //       leading: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Icon(
            //             Icons.account_balance,
            //           ),
            //         ],
            //       ),
            //       title: Text("Pay via NetBanking"),
            //       trailing: Icon(Icons.arrow_forward_ios),
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => NetBanking()),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildUPIForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Text(
                    "UPI",
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/icons/bhim.png",
                            width: 0.08.sw,
                            height: 0.075.sw,
                          ),
                        ],
                      ),
                      title: Text("Pay via UPI ID"),
                      onTap: () {
                        paymentMethod = "UPIID";
                        showVPAMethod = true;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: showVPAMethod,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          MyTextFormField(
                            controller: upiNumber,
                            opacity: 1,
                            heading: "",
                            isMandatory: false,
                            hintText: 'Enter UPI ID',
                            textAction: TextInputAction.next,
                            validator: (String? value) {
                              String pattern = r"[\w\.\-_]{3,}@[a-zA-Z]{3,}";
                              RegExp regExp = new RegExp(pattern);
                              if (value!.isEmpty) {
                                return 'Enter Your UPI ID';
                              } else if (!regExp.hasMatch(value)) {
                                return 'Please enter valid UPI ID';
                              }
                              return null;
                            },
                            // validator: (_) => context
                            //     .read<FormBloc>()
                            //     .state
                            //     .accNo
                            //     .value
                            //     .fold(
                            //         (f) => f.maybeMap(
                            //             invalidAccNo: (_) => 'Invalid Account Number',
                            //             orElse: () => null),
                            //         (r) => null),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                child: Container(
                                  width: 0.65.sw,
                                  height: .12.sw,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: kPrimaryColor),
                                  child: Center(
                                    child: Text(
                                      "Continue",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 30.sp),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (upiNumber.text != '') {
                                    _verifyUPI();
                                  }
                                }),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Text(
                    "For easier payments & To display UPI payments apps here",
                    style: GoogleFonts.poppins(
                        color: Colors.grey.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Visibility(
                  visible: apps != null
                      ? apps.length > 0
                          ? true
                          : false
                      : false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: apps != null
                              ? apps.length > 0
                                  ? apps.containsValue("GPay")
                                  : false
                              : false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8),
                            child: Container(
                              width: .25.sw,
                              height: .25.sw,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/googlepay.png",
                                        width: 0.08.sw,
                                        height: 0.075.sw,
                                      ),
                                      Text("Google Pay"),
                                    ]),
                                onTap: () {
                                  setState(() {});
                                  walletOptions!['_[flow]'] = 'intent';
                                  walletOptions!['upi_app_package_name'] =
                                      'com.google.android.apps.nbu.paisa.user';
                                  Navigator.pop(context, walletOptions);
                                },
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: apps != null
                              ? apps.length > 0
                                  ? apps.containsValue("PhonePe")
                                  : false
                              : false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8),
                            child: Container(
                              width: .25.sw,
                              height: .25.sw,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/icons/phonepe.png",
                                      width: 0.08.sw,
                                      height: 0.075.sw,
                                    ),
                                    Text("PhonePe"),
                                  ],
                                ),
                                onTap: () {
                                  walletOptions!['_[flow]'] = 'intent';
                                  walletOptions!['upi_app_package_name'] =
                                      'com.phonepe.app';
                                  Navigator.pop(context, walletOptions);
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: apps != null
                              ? apps.length > 0
                                  ? apps.containsValue("Paytm")
                                  : false
                              : false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8),
                            child: Container(
                              width: .25.sw,
                              height: .25.sw,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/icons/paytm.png",
                                      width: 0.08.sw,
                                      height: 0.075.sw,
                                    ),
                                    Text("Paytm"),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {});
                                  walletOptions!['_[flow]'] = 'intent';
                                  walletOptions!['upi_app_package_name'] =
                                      'net.one97.paytm';
                                  Navigator.pop(context, walletOptions);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: apps != null
                      ? apps.length > 0
                          ? true
                          : false
                      : false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: apps != null
                              ? apps.length > 0
                                  ? apps.containsValue("Bhim")
                                  : false
                              : false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8),
                            child: Container(
                              width: .25.sw,
                              height: .25.sw,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/icons/bhim.png",
                                      width: 0.08.sw,
                                      height: 0.075.sw,
                                    ),
                                    Text("BHIM UPI"),
                                  ],
                                ),
                                onTap: () {
                                  setState(() {});
                                  walletOptions!['_[flow]'] = 'intent';
                                  walletOptions!['upi_app_package_name'] =
                                      'in.org.npci.upiapp';
                                  Navigator.pop(context, walletOptions);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
