// import 'package:animated_widgets/widgets/scale_animated.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// //import 'package:share/share.dart';
//
// class PaymentPageRentl extends StatefulWidget {
//   const PaymentPageRentl(this.card, {Key? key}) : super(key: key);
//
//   final AssetDetailsObject card;
//   @override
//   State<PaymentPageRentl> createState() => _PaymentPageRentlState();
// }
//
// class _PaymentPageRentlState extends State<PaymentPageRentl> {
//   Map<String, dynamic> paymentOptions = {
//     "key": 'rzp_live_Bm7fhzUxrM1frD',
//     "currency": "INR",
//     "contact":
//         "${(FirebaseAuth.instance.currentUser != null ? (FirebaseAuth.instance.currentUser!.phoneNumber != null && FirebaseAuth.instance.currentUser!.phoneNumber != "") : false) ? FirebaseAuth.instance.currentUser!.phoneNumber! : "9999999999"}",
//     "email":
//         "${(FirebaseAuth.instance.currentUser != null ? (FirebaseAuth.instance.currentUser!.email != null && FirebaseAuth.instance.currentUser!.email != "") : false) ? FirebaseAuth.instance.currentUser!.email! : "info@estraightwayapp.com"}",
//     '_[flow]': 'intent',
//   };
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Payment page',
//           style: Theme.of(context).appBarTheme.titleTextStyle,
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.secondary,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 3,
//                         blurRadius: 2,
//                         offset: Offset(0, 2), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   width: 1.sw,
//                   child: Padding(
//                     padding: Theme.of(context).textTheme.paddingAll10,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: 5,
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                       width: 0.4.sw,
//                                       child: ParkingName(rentlName: "")),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Padding(
//                                     padding: Theme.of(context)
//                                         .textTheme
//                                         .paddingSymmetricOnlyB10,
//                                     child: Container(
//                                       width: 0.6.sw,
//                                       child: Text(
//                                         widget
//                                             .card.locationDetails!.addressLine,
//                                         maxLines: 2,
//                                         style: TextStyle(
//                                           color:
//                                               Theme.of(context).iconTheme.color,
//                                           fontSize: 26.sp,
//                                           fontWeight: FontWeight.w500,
//                                           fontFamily: Theme.of(context)
//                                               .textTheme
//                                               .subtitle1!
//                                               .fontFamily,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Visibility(
//                               visible: widget.card.isVerified == true,
//                               child: Center(
//                                 child: ScaleAnimatedWidget.tween(
//                                     enabled: true,
//                                     duration: Duration(milliseconds: 600),
//                                     scaleDisabled: 0.5,
//                                     scaleEnabled: 1,
//                                     child: Icon(
//                                       Icons.check_circle,
//                                       color: Colors.green,
//                                       size: 0.25.sw,
//                                     ) /* your widget */
//                                     ),
//                               ),
//                             )
//                           ],
//                         ),
//                         Visibility(
//                           visible: widget.card.isVerified != true,
//                           child: Padding(
//                             padding: Theme.of(context)
//                                 .textTheme
//                                 .paddingSymmetricOnlyB10,
//                             child: Container(
//                               width: 0.65.sw,
//                               child: Text(
//                                 "your space will be visible to the users once you complete the payment",
//                                 maxLines: 2,
//                                 style: TextStyle(
//                                   color: Theme.of(context).iconTheme.color,
//                                   fontSize: 26.sp,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: Theme.of(context)
//                                       .textTheme
//                                       .subtitle1!
//                                       .fontFamily,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Visibility(
//                           visible: widget.card.isVerified != true,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               GestureDetector(
//                                 onTap: () async {
//                                   paymentOptions = await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             PaymentSelectionPage(
//                                               500,
//                                             )),
//                                   );
//                                   setState(() {});
//                                 },
//                                 child: Container(
//                                   width: 0.3.sw,
//                                   height: .12.sw,
//                                   child: Column(
//                                     children: [
//                                       Visibility(
//                                           visible: paymentOptions.first[
//                                                   'upi_app_package_name'] !=
//                                               null,
//                                           child: Text("Pay using")),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 8.0),
//                                             child: paymentOptions.first[
//                                                         'upi_app_package_name'] ==
//                                                     "com.google.android.apps.nbu.paisa.user"
//                                                 ? Image.asset(
//                                                     "assets/icons/googlepay.png",
//                                                     width: 0.08.sw,
//                                                     height: 0.075.sw,
//                                                   )
//                                                 : paymentOptions.first[
//                                                             'upi_app_package_name'] ==
//                                                         "com.phonepe.app"
//                                                     ? Image.asset(
//                                                         "assets/icons/phonepe.png",
//                                                         width: 0.08.sw,
//                                                         height: 0.075.sw,
//                                                       )
//                                                     : paymentOptions.first[
//                                                                 'upi_app_package_name'] ==
//                                                             "in.org.npci.upiapp"
//                                                         ? Image.asset(
//                                                             "assets/icons/bhim.png",
//                                                             width: 0.08.sw,
//                                                             height: 0.075.sw,
//                                                           )
//                                                         : paymentOptions.first[
//                                                                     'upi_app_package_name'] ==
//                                                                 "net.one97.paytm"
//                                                             ? Image.asset(
//                                                                 "assets/icons/paytm.png",
//                                                                 width: 0.08.sw,
//                                                                 height:
//                                                                     0.075.sw,
//                                                               )
//                                                             : paymentOptions.first[
//                                                                             'method'] ==
//                                                                         'upi' &&
//                                                                     paymentOptions.first[
//                                                                             '_[flow]'] ==
//                                                                         'collect'
//                                                                 ? Image.asset(
//                                                                     "assets/icons/bhim.png",
//                                                                     width:
//                                                                         0.08.sw,
//                                                                     height:
//                                                                         0.075
//                                                                             .sw,
//                                                                   )
//                                                                 : paymentOptions.first[
//                                                                             'method'] ==
//                                                                         'card'
//                                                                     ? Image
//                                                                         .asset(
//                                                                         "assets/icons/creditcard.png",
//                                                                         width: 0.08
//                                                                             .sw,
//                                                                         height:
//                                                                             0.075.sw,
//                                                                       )
//                                                                     : paymentOptions.first['method'] ==
//                                                                             'netbanking'
//                                                                         ? Icon(Icons
//                                                                             .account_balance)
//                                                                         : paymentOptions.first['method'] ==
//                                                                                 'wallet'
//                                                                             ? Icon(Icons.account_balance_wallet)
//                                                                             : Text(
//                                                                                 "select\npayment\nmethod",
//                                                                                 textAlign: TextAlign.center,
//                                                                               ),
//                                           ),
//                                           Icon(Icons.arrow_drop_down_sharp)
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 child: Container(
//                                   width: .55.sw,
//                                   height: .13.sw,
//                                   decoration: new BoxDecoration(
//                                     color: Theme.of(context).primaryColor,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.2),
//                                         spreadRadius: 3,
//                                         blurRadius: 5,
//                                         offset: Offset(
//                                             0, 3), // changes position of shadow
//                                       ),
//                                     ],
//                                   ),
//                                   child: Center(
//                                     child: Text("Pay \u{20B9}500",
//                                         style: TextStyle(
//                                           fontFamily: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1!
//                                               .fontFamily,
//                                           color: Theme.of(context)
//                                               .textTheme
//                                               .headline6!
//                                               .color,
//                                           fontSize: 28.sp,
//                                           fontWeight: FontWeight.w500,
//                                           fontStyle: FontStyle.normal,
//                                           letterSpacing: 0,
//                                         )),
//                                   ),
//                                 ),
//                                 onTap: () async {
//                                   paymentOptions.first['amount'] = 2.5 * 100;
//                                   if (paymentOptions.first['method'] == null) {
//                                     paymentOptions = await Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               PaymentSelectionPage(
//                                                 2.5 * 100,
//                                               )),
//                                     );
//                                     setState(() {});
//                                   } else {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               PaymentInitiationPage(
//                                                   2.5,
//                                                   widget.card.markerID!,
//                                                   paymentOptions)),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         Visibility(
//                           visible: widget.card.isVerified == true,
//                           child: Text(
//                             "Your place is active",
//                             maxLines: 2,
//                             style: TextStyle(
//                               color: Colors.green,
//                               fontSize: 30.sp,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: Theme.of(context)
//                                   .textTheme
//                                   .subtitle1!
//                                   .fontFamily,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
