import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/home/business_controller.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/widget/angle_clipper.dart';
import 'package:estraightwayapp/widget/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../service/home/business_service.dart';
import '../../widget/snackbars.dart';

class BusinessByService extends StatefulWidget {
  const BusinessByService({Key? key}) : super(key: key);

  @override
  State<BusinessByService> createState() => _BusinessByServiceState();
}

class _BusinessByServiceState extends State<BusinessByService> {
  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(BusinessController());
    NumberFormat formatCurrency = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: 'INR', decimalDigits: 0);
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                child: GestureDetector(
                  onTap: () async {
                    if (businessController.selectedBusiness.value.uid != null) {
                      var bookingStatus =
                          await BusinessServices().verifyBookings({
                        "bookedDate": DateTime.parse(DateTime.now().toString()),
                        "businessId": businessController
                            .selectedBusiness.value.uid
                            .toString(),
                        "serviceName": "",
                      });
                      if (bookingStatus["status"] == "success") {
                        Get.toNamed(
                          '/verifyOrder',
                          parameters: {
                            "uid": businessController.selectedBusiness.value.uid
                                .toString(),
                            "businessImage": businessController
                                .selectedBusiness.value.businessImage
                                .toString(),
                            "price": businessController
                                .selectedBusiness.value.serviceCharge
                                .toString(),
                            "tokenAdvance": businessController
                                .selectedBusiness.value.tokenAdvance
                                .toString(),
                            "businessName": businessController
                                .selectedBusiness.value.businessName
                                .toString(),
                            "businessContactNumber": businessController
                                .selectedBusiness.value.phoneNumber
                                .toString(),
                            "serviceName": "",
                            "bookingDate": DateTime.now().toString(),
                          },
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        showErrorSnackbar(context,
                            "Service is alreday booked by you/someone else");
                      }
                    }
                    //   businessController.paymentOptions.first['amount'] = 1 * 100;
                    //   if (businessController.paymentOptions.first['method'] ==
                    //       null) {
                    //     businessController.paymentOptions = await Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => PaymentSelectionPage(
                    //                 1 * 100,
                    //               )),
                    //     );
                    //     // Get.toNamed('/bookingsuccessful', arguments: ["date"]);
                    //   } else {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => PaymentInitiationPage(
                    //               double.parse(businessController
                    //                   .paymentOptions.first['amount']
                    //                   .toString()),
                    //               '',
                    //               businessController.paymentOptions.first)),
                    //     );
                    //   }
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
          preferredSize: Size.fromHeight(.2.sw),
          child: Stack(
            children: [
              Hero(
                tag: businessController.subCategory.uid!,
                child: ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: 1.sw,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                            Colors.black26, BlendMode.darken),
                        image: CachedNetworkImageProvider(
                            businessController.subCategory.subCategoryImage!),
                      ),
                    ),
                  ),
                ),
              ),
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
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    businessController
                                        .selectBusiness(snapshot.data![index]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: businessController
                                                      .selectedBusiness
                                                      .value
                                                      .uid ==
                                                  snapshot.data![index].uid
                                              ? kPrimaryColor
                                              : Colors.grey.withOpacity(0.5),
                                          width: 2),
                                    ),
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
                                          ),
                                        ),
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  "Experience ${snapshot.data![index].experience!} years",
                                                  style: GoogleFonts.inter(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
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
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 2),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data![index]
                                                                      .rating ==
                                                                  null
                                                              ? "0"
                                                              : snapshot
                                                                  .data![index]
                                                                  .rating
                                                                  .toString(),
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons.star,
                                                          size: 15,
                                                          color:
                                                              Color(0xffFFC700),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  "Basic Service charge",
                                                  style: GoogleFonts.inter(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  formatCurrency.format(snapshot
                                                      .data![index]
                                                      .serviceCharge!),
                                                  style: GoogleFonts.inter(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
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
                              );
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
      ),
    );
  }
}
