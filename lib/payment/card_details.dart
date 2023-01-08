import 'package:flutter/material.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'models/card_info_model.dart';

class CardPaymentsPage extends StatefulWidget {
  const CardPaymentsPage({Key? key}) : super(key: key);

  @override
  State<CardPaymentsPage> createState() => _CardPaymentsPageState();
}

class _CardPaymentsPageState extends State<CardPaymentsPage> {
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
    cardInfoModel = CardInfoModel();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.initilizeSDK(key);

    super.initState();
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

  String validateCardFields() {
    if ((cardInfoModel?.cardNumber == '') ||
        (cardInfoModel?.cardNumber == null)) {
      return 'Card Number Cannot be Empty';
    }
    if ((cardInfoModel?.expiryMonth == '') ||
        (cardInfoModel?.expiryMonth == null)) {
      return 'Expiry Month / Year Cannot be Empty';
    }
    if ((cardInfoModel?.cvv == '') || (cardInfoModel?.cvv == null)) {
      return 'CVV Cannot be Empty';
    }
    if ((cardInfoModel?.mobileNumber == '') ||
        (cardInfoModel?.mobileNumber == null)) {
      return 'Mobile number cannot be Empty';
    }
    if ((cardInfoModel?.email == '') || (cardInfoModel?.email == null)) {
      return 'Email cannot be Empty';
    }
    return '';
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
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        centerTitle: false,
        title: Text(
          'Credit/Debit Card Payment',
          style: Theme.of(context)
              .appBarTheme
              .titleTextStyle!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildCardDetailsForm(),
      ),
    );
  }

  Widget buildCardDetailsForm() {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Text('Card Number :'),
                SizedBox(width: 8.0),
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Card Number',
                    ),
                    onChanged: (newValue) =>
                        cardInfoModel?.cardNumber = newValue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Expiry :'),
                SizedBox(width: 8.0),
                Flexible(
                  child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '12/23',
                      ),
                      onChanged: (newValue) {
                        final month = newValue.split('/').first;
                        final year = newValue.split('/').last;
                        cardInfoModel?.expiryYear = year;
                        cardInfoModel?.expiryMonth = month;
                      }),
                ),
                SizedBox(width: 8.0),
                Text('CVV'),
                SizedBox(width: 8.0),
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '***',
                    ),
                    onChanged: (newValue) => cardInfoModel?.cvv = newValue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Name :'),
                SizedBox(width: 8.0),
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Card Holder Name',
                    ),
                    onChanged: (newValue) =>
                        cardInfoModel?.cardHolderName = newValue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Phone :'),
                SizedBox(width: 8.0),
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Mobile Number',
                    ),
                    onChanged: (newValue) =>
                        cardInfoModel?.mobileNumber = newValue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Email :'),
                SizedBox(width: 8.0),
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Email-ID',
                    ),
                    onChanged: (newValue) => cardInfoModel?.email = newValue,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Container(
                width: 0.65.sw,
                height: .12.sw,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    "Pay",
                    style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.headline6!.fontFamily,
                        color: Theme.of(context).textTheme.headline6!.color,
                        fontSize: 30.sp),
                  ),
                ),
              ),
              onTap: () async {
                var error = validateCardFields();
                if (error != '') {
                  //print(error);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error)));
                  return;
                }
                var options = {
                  'key': key,
                  'amount': 100,
                  "card[cvv]": cardInfoModel?.cvv,
                  "card[expiry_month]": cardInfoModel?.expiryMonth,
                  "card[expiry_year]": cardInfoModel?.expiryYear,
                  "card[name]": cardInfoModel?.cardHolderName,
                  "card[number]": cardInfoModel?.cardNumber,
                  "contact": cardInfoModel?.mobileNumber,
                  "currency": "INR",
                  "display_logo": "0",
                  'email': cardInfoModel?.email,
                  'description': 'Fine T-Shirt',
                  "method": "card"
                };
                Navigator.pop(context, options);
                Navigator.pop(context, options);
              },
            ))
      ],
    );
  }
}
