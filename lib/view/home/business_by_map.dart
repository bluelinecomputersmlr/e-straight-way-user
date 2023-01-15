import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/home/business_controller.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/payment/payment_methods.dart';
import 'package:estraightwayapp/widget/angle_clipper.dart';
import 'package:estraightwayapp/widget/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../payment/paymentInitiationPage.dart';

class BusinessByMap extends StatefulWidget {
  const BusinessByMap({Key? key}) : super(key: key);

  @override
  State<BusinessByMap> createState() => _BusinessByMapState();
}

class _BusinessByMapState extends State<BusinessByMap> {
  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(BusinessController());

    NumberFormat formatCurrency = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: 'INR', decimalDigits: 0);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () async {
                  var paymentOptions = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentSelectionPage(
                        0,
                      ),
                    ),
                  );
                  businessController.updateval(paymentOptions);
                  setState(() {});

                  if (businessController.paymentOptions.first['method'] ==
                      'wallet') {
                    businessController.getWalletLogo();
                  }
                },
                child: Container(
                  width: 0.3.sw,
                  height: .15.sw,
                  child: Obx(
                    () => Column(
                      children: [
                        Visibility(
                            visible: businessController.paymentOptions
                                    .first['upi_app_package_name'] !=
                                null,
                            child: const Text("Pay using")),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: businessController.paymentOptions
                                          .first['upi_app_package_name'] ==
                                      "com.google.android.apps.nbu.paisa.user"
                                  ? Image.asset(
                                      "assets/icons/googlepay.png",
                                      width: 0.08.sw,
                                      height: 0.075.sw,
                                    )
                                  : businessController.paymentOptions
                                              .first['upi_app_package_name'] ==
                                          "com.phonepe.app"
                                      ? Image.asset(
                                          "assets/icons/phonepe.png",
                                          width: 0.08.sw,
                                          height: 0.075.sw,
                                        )
                                      : businessController.paymentOptions.first[
                                                  'upi_app_package_name'] ==
                                              "in.org.npci.upiapp"
                                          ? Image.asset(
                                              "assets/icons/bhim.png",
                                              width: 0.08.sw,
                                              height: 0.075.sw,
                                            )
                                          : businessController
                                                          .paymentOptions.first[
                                                      'upi_app_package_name'] ==
                                                  "net.one97.paytm"
                                              ? Image.asset(
                                                  "assets/icons/paytm.png",
                                                  width: 0.08.sw,
                                                  height: 0.075.sw,
                                                )
                                              : businessController.paymentOptions.first['method'] ==
                                                          'upi' &&
                                                      businessController
                                                              .paymentOptions
                                                              .first['_[flow]'] ==
                                                          'collect'
                                                  ? Image.asset(
                                                      "assets/icons/bhim.png",
                                                      width: 0.08.sw,
                                                      height: 0.075.sw,
                                                    )
                                                  : businessController.paymentOptions.first['method'] == 'card'
                                                      ? Image.asset(
                                                          "assets/icons/creditcard.png",
                                                          width: 0.08.sw,
                                                          height: 0.075.sw,
                                                        )
                                                      : businessController.paymentOptions.first['method'] == 'netbanking'
                                                          ? Icon(Icons.account_balance)
                                                          : businessController.paymentOptions.first['method'] == 'wallet'
                                                              ? businessController.walletLogo != null
                                                                  ? Image.network(
                                                                      businessController
                                                                          .walletLogo!,
                                                                      width: 0.15
                                                                          .sw,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      height:
                                                                          0.15.sw,
                                                                    )
                                                                  : Icon(Icons.account_balance_wallet_rounded)
                                                              : Text(
                                                                  "Choose\npayment\nmethod",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                            ),
                            Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () async {
                  businessController.paymentOptions.first['amount'] = 1 * 100;
                  if (businessController.paymentOptions.first['method'] ==
                      null) {
                    businessController.paymentOptions = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentSelectionPage(
                                1 * 100,
                              )),
                    );
                    // Get.toNamed('/bookingsuccessful', arguments: ["date"]);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentInitiationPage(
                              double.parse(businessController
                                  .paymentOptions.first['amount']
                                  .toString()),
                              '',
                              businessController.paymentOptions.first)),
                    );
                  }
                },
                child: Container(
                  width: .65.sw,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kPrimaryColor,
                  ),
                  child: Center(
                    child: Text(
                      "Book Now",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(.7.sw),
        child: Stack(
          children: [
            Obx(
              () => StreamBuilder(
                  stream: businessController.getBusiness(),
                  builder:
                      (context, AsyncSnapshot<List<BusinessModel>?> snapshot) {
                    return GoogleMap(
                      mapType: MapType.terrain,
                      initialCameraPosition: CameraPosition(
                        target:
                            businessController.initalMapCameraPosition.value,
                        zoom: 14.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        businessController.mapController.complete(controller);
                      },
                      markers: (snapshot.hasData)
                          ? snapshot.data!
                              .map(
                                (e) => (e.location != null)
                                    ? Marker(
                                        markerId: MarkerId(
                                          '${e.location!["geopoint"].latitude}-${e.location!["geopoint"].longitude}',
                                        ),
                                        position: LatLng(
                                          e.location!["geopoint"].latitude,
                                          e.location!["geopoint"].longitude,
                                        ),
                                      )
                                    : Marker(
                                        markerId: MarkerId(const Uuid().v4()),
                                      ),
                              )
                              .toSet()
                          : {},
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                    );
                  }),
            ),
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                height: .3.sw,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(
                      width: .3.sw,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        businessController.subCategory.subCategoryName!,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          child: CustomLoadingIndicator(
            isBusy: businessController.isLoading.isTrue,
            hasError: businessController.isError.isTrue,
            child: StreamBuilder(
              stream: businessController.getBusiness(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<BusinessModel>?> snapshot) {
                if (snapshot.hasData) {
                  print("**********************************");
                  print(snapshot.data!.toList());
                  return (snapshot.data!.isEmpty)
                      ? Center(
                          child: Text(
                            "No service found",
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 4),
                                  child: GestureDetector(
                                    onTap: () {
                                      businessController.selectedBusiness(
                                          snapshot.data![index]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: businessController
                                                          .selectedBusiness
                                                          .value
                                                          .uid ==
                                                      snapshot.data![index].uid
                                                  ? kPrimaryColor
                                                  : Colors.grey
                                                      .withOpacity(0.5),
                                              width: 2)),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              width: 60,
                                              height: 60,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                image: (snapshot.data![index]
                                                            .businessImage !=
                                                        null)
                                                    ? DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          snapshot.data![index]
                                                              .businessImage!,
                                                        ),
                                                      )
                                                    : null,
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: .4.sw,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    snapshot.data![index]
                                                        .businessName!,
                                                    style: GoogleFonts.inter(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Experience ${snapshot.data![index].experience!} years",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        color: kPrimaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 2),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                          .data![
                                                                              index]
                                                                          .rating ==
                                                                      null
                                                                  ? "0"
                                                                  : snapshot
                                                                      .data![
                                                                          index]
                                                                      .rating
                                                                      .toString(),
                                                              style: GoogleFonts
                                                                  .inter(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons.star,
                                                              size: 15,
                                                              color: Color(
                                                                  0xffFFC700),
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: .25.sw,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    "Basic Service charge",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 10,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    formatCurrency.format(
                                                        snapshot.data![index]
                                                            .serviceCharge!),
                                                    style: GoogleFonts.inter(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          });
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
