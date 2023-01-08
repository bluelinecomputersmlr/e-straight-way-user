import 'package:flutter/material.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';

import 'models/card_info_model.dart';

class NetBanking extends StatefulWidget {
  const NetBanking({Key? key}) : super(key: key);

  @override
  State<NetBanking> createState() => _NetBankingState();
}

class _NetBankingState extends State<NetBanking> {
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
  List<WalletModel>? walletsList;
  late Razorpay _razorpay;
  Map<String, dynamic>? commonPaymentOptions;

  var apps;
  String paymentMethod = 'GOOGLEPAY';

  String phoneNo = '';

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.initilizeSDK(key);

    fetchAllPaymentMethods();

    netBankingOptions = {
      'key': key,
      'amount': 100,
      'currency': 'INR',
      'email': 'ramprasad179@gmail.com',
      'contact': '9663976539',
      'method': 'netbanking',
    };

    commonPaymentOptions = {};

    super.initState();
  }

  fetchAllPaymentMethods() {
    _razorpay.getPaymentMethods().then((value) {
      paymentMethods = value;

      configureNetbanking();
    }).onError((error, stackTrace) {
      //print('Error Fetching payment methods: $error');
    });
  }

  configureNetbanking() {
    netBankingList = [];
    final nbDict = paymentMethods?['netbanking'];
    nbDict.entries.forEach(
      (element) {
        netBankingList?.add(
          NetBankingModel(bankKey: element.key, bankName: element.value),
        );
        setState(() {});
      },
    );
  }

  void _handlePaymentSuccess(Map<dynamic, dynamic> response) {
    final snackBar = SnackBar(
      content: Text(
        'Payment Success : ${response.toString()}',
      ),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //print('Payment Success Response : $response');
  }

  void _handlePaymentError(Map<dynamic, dynamic> response) {
    final snackBar = SnackBar(
      content: Text(
        'Payment Error : ${response.toString()}',
      ),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //print('Payment Error Response : $response');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        centerTitle: false,
        title: Text(
          'Net Banking',
          style: Theme.of(context)
              .appBarTheme
              .titleTextStyle!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: buildBanksList(),
    );
  }

  Widget buildBanksList() {
    return ListView.builder(
      itemCount: netBankingList?.length,
      itemBuilder: (context, item) {
        return ListTile(
          title: Text(netBankingList?[item].bankName ?? ''),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            netBankingOptions?['bank'] = netBankingList?[item].bankKey;
            if (netBankingOptions != null) {
              Navigator.pop(context, netBankingOptions);
              Navigator.pop(context, netBankingOptions);
            }
          },
        );
      },
    );
  }
}
