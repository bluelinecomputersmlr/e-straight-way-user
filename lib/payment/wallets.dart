import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';
import 'models/card_info_model.dart';

class Wallets extends StatefulWidget {
  const Wallets({Key? key}) : super(key: key);

  @override
  State<Wallets> createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  List<WalletModel>? walletsList;
  String phoneNo = '';
  String key = "rzp_live_Bm7fhzUxrM1frD";
  String? availableUpiApps;
  bool showVPAMethod = false;

  //rzp_test_1DP5mmOlF5G5ag  ---> Debug Key
  //rzp_live_6KzMg861N1GUS8  ---> Live Key
  //rzp_live_cepk1crIu9VkJU  ---> Pay with Cred

  Map<String, dynamic>? netBankingOptions;
  Map<String, dynamic>? walletOptions;
  String? upiNumber;

  Map<dynamic, dynamic>? paymentMethods;
  List<NetBankingModel>? netBankingList;
  late Razorpay _razorpay;
  Map<String, dynamic>? commonPaymentOptions;

  var apps;
  String paymentMethod = 'GOOGLEPAY';

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.initilizeSDK(key);

    fetchAllPaymentMethods();

    walletOptions = {
      'key': key,
      'amount': 100,
      'currency': 'INR',
      'email': 'ramprasad179@gmail.com',
      'contact': '+919999999999',
      'method': 'wallet',
    };

    commonPaymentOptions = {};

    super.initState();
  }

  fetchAllPaymentMethods() {
    _razorpay.getPaymentMethods().then((value) {
      paymentMethods = value;

      configurePaymentWallets();
    }).onError((error, stackTrace) {
      //print('Error Fetching payment methods: $error');
    });
  }

  configurePaymentWallets() {
    walletsList = [];
    final walletsDict = paymentMethods?['wallet'];
    walletsDict.entries.forEach(
      (element) async {
        if (element.value == true) {
          walletsList?.add(
            WalletModel(
                walletName: element.key,
                walletIcon: await _razorpay.getWalletLogoUrl(element.key)),
          );
          setState(() {});
          //print(element.value);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Wallets',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: buildWalletsList(),
        ));
  }

  Widget buildWalletsList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemCount: walletsList?.length,
      itemBuilder: (context, item) {
        return GestureDetector(
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
                walletsList?[item].walletIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 0.2.sw,
                          width: 0.2.sw,
                          child: CachedNetworkImage(
                              imageUrl: "${walletsList?[item].walletIcon!}"),
                        ),
                      )
                    : Container(),
                Text(walletsList?[item].walletName ?? ''),
              ],
            ),
          ),
          onTap: () {
            dialogBox(context, item);
          },
        );
      },
    );
  }

  dialogBox(context, int item) {
    showDialog(
        context: context,
        builder: (BuildContext contxt) {
          return Container(
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.grey, width: 2.0),
                          // ),
                          hintText: 'Mobile No',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        onChanged: (String value) {
                          phoneNo = value;
                        },
                      ),
                    ],
                  ),
                  actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        child: Container(
                          width: 0.65.sw,
                          height: .12.sw,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: kPrimaryColor),
                          child: Center(
                            child: Text(
                              "Continue",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 30.sp),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (phoneNo.length != 10) {
                            Fluttertoast.showToast(
                                msg: "Please enter a valid Number",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1);
                          } else {
                            Navigator.of(contxt).pop();
                            walletOptions?['wallet'] =
                                walletsList?[item].walletName;
                            walletOptions?['contact'] = phoneNo;
                            if (walletOptions != null) {
                              Navigator.pop(context, walletOptions);
                              Navigator.pop(context, walletOptions);
                            }
                          }
                        })),
              ]));
        });
  }
}
