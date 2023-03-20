import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/home/business_controller.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/payment/paymentInitiationPage.dart';
import 'package:estraightwayapp/payment/payment_methods.dart';
import 'package:estraightwayapp/widget/angle_clipper.dart';
import 'package:estraightwayapp/widget/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import '../../controller/home/business_details_controller.dart';
import '../../service/home/business_service.dart';
import '../../widget/snackbars.dart';

class BusinessesByDateDetailsPage extends StatefulWidget {
  const BusinessesByDateDetailsPage({Key? key}) : super(key: key);

  @override
  State<BusinessesByDateDetailsPage> createState() =>
      _BusinessesByDateDetailsPageState();
}

class _BusinessesByDateDetailsPageState
    extends State<BusinessesByDateDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(BusinessDetailsController());
    NumberFormat formatCurrency = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: 'INR', decimalDigits: 0);
    Widget _eventIcon = Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(1000)),
          border: Border.all(color: Colors.blue, width: 2.0)),
      child: const Icon(
        Icons.person,
        color: Colors.amber,
      ),
    );

    EventList<Event> markedDateMap = EventList<Event>(
      events: {
        DateTime(2019, 2, 10): [
          Event(
            date: DateTime(2019, 2, 10),
            title: 'Event 1',
            icon: _eventIcon,
            dot: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              color: Colors.red,
              height: 5.0,
              width: 5.0,
            ),
          ),
          Event(
            date: DateTime(2019, 2, 10),
            title: 'Event 2',
            icon: _eventIcon,
          ),
          Event(
            date: DateTime(2019, 2, 10),
            title: 'Event 3',
            icon: _eventIcon,
          ),
        ],
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(.2.sw),
        child: Stack(
          children: [
            Hero(
              tag: businessController.business.uid!,
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
                              businessController.business.businessImage!))),
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
              child: Container(
                width: 1.sw,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      businessController.business.businessName!,
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          businessController.business.serviceImages!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        height: .7.sw,
                        child: CarouselSlider(
                          carouselController:
                              businessController.carouselController,
                          options: CarouselOptions(
                              viewportFraction: 0.9,
                              height: 1.sw,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                businessController.updateIndex(index);
                              }),
                          items: businessController.business.serviceImages!
                              .map((item) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: CachedNetworkImage(
                                        imageUrl: item,
                                        width: 1.sw,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      "assets/icons/placing_image.jpg",
                      width: 1.sw,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
          Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: businessController.business.serviceImages!
                  .asMap()
                  .entries
                  .map((entry) {
                return GestureDetector(
                  onTap: () => businessController.carouselController
                      .animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(
                                businessController.currentIndex == entry.key
                                    ? 0.9
                                    : 0.4)),
                  ),
                );
              }).toList())),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "About",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            businessController.business.rating == null
                                ? "0"
                                : businessController.business.rating.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Color(0xffFFC700),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ReadMoreText(
              businessController.business.description!,
              trimLines: 2,
              colorClickableText: kPrimaryColor,
              trimMode: TrimMode.Line,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              lessStyle: const TextStyle(
                  fontSize: 14,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
              trimCollapsedText: 'more',
              trimExpandedText: 'Show less',
              moreStyle: const TextStyle(
                  fontSize: 14,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Select your date",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffF4F7FF),
              ),
              child: Column(
                children: [
                  Obx(() => Container(
                        margin: const EdgeInsets.only(
                          top: 30.0,
                          bottom: 10.0,
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              businessController.currentMonth.value,
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_circle_left_rounded,
                                size: 40,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                businessController.onPreviousPressed();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_circle_right_rounded,
                                size: 40,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                businessController.onNextPressed();
                                businessController.update();
                              },
                            )
                          ],
                        ),
                      )),
                  Obx(() => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: CalendarCarousel<Event>(
                          todayBorderColor: kPrimaryColor,
                          isScrollable: false,
                          onDayPressed: (date, events) {
                            businessController.onDayPressed(date, events);
                          },
                          weekDayBackgroundColor: kPrimaryColor,
                          weekDayPadding: EdgeInsets.symmetric(vertical: 8),
                          weekdayTextStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                          daysHaveCircularBorder: true,
                          showOnlyCurrentMonthDate: true,
                          weekendTextStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          daysTextStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),

                          thisMonthDayBorderColor: Colors.transparent,
                          weekFormat: false,
//      firstDayOfWeek: 4,
                          markedDatesMap: markedDateMap,
                          height: 350.0,
                          selectedDateTime:
                              businessController.currentDate2.value,
                          targetDateTime:
                              businessController.targetDateTime.value,
                          customGridViewPhysics:
                              const NeverScrollableScrollPhysics(),
                          markedDateCustomShapeBorder: const CircleBorder(
                              side: BorderSide(color: Colors.yellow)),
                          markedDateCustomTextStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),

                          showHeader: false,
                          todayTextStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          // markedDateShowIcon: true,
                          // markedDateIconMaxShown: 2,
                          // markedDateIconBuilder: (event) {
                          //   return event.icon;
                          // },
                          // markedDateMoreShowTotal:
                          //     true,
                          todayButtonColor: Colors.white,
                          selectedDayTextStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                          selectedDayButtonColor: kPrimaryColor,
                          selectedDayBorderColor: kPrimaryColor,

                          minSelectedDate: businessController.currentDate.value
                              .subtract(const Duration(days: 360)),
                          maxSelectedDate: businessController.currentDate.value
                              .add(const Duration(days: 360)),
                          prevDaysTextStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          inactiveDaysTextStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                          ),
                          onCalendarChanged: (DateTime date) {
                            businessController.onCalanderChanged(date);
                          },
                          onDayLongPressed: (DateTime date) {
                            print('long pressed date $date');
                          },
                        ),
                      )),
                ],
              ),
            ),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  DateFormat.yMMMMd('en_US')
                      .format(businessController.currentDate2.value),
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )),
          ListView.builder(
            itemCount: businessController.business.addedServices!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      businessController.selectedBusinessIndex.value = index;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color:
                              businessController.selectedBusinessIndex.value ==
                                      index
                                  ? kPrimaryColor
                                  : Colors.grey.withOpacity(0.5),
                          width: 3,
                        ),
                      ),
                      child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: .55.sw,
                                    child: Text(
                                      businessController
                                              .business.addedServices![index]
                                          ['addedServiceName'],
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: .25.sw,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffF4F7FF),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          formatCurrency.format(
                                            businessController.business
                                                    .addedServices![index]
                                                ['addedServicePrice'],
                                          ),
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: Container(
                                width: .6.sw,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffF4F7FF),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    businessController
                                            .business.addedServices![index]
                                        ['addedServiceDescription'],
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              );
            },
          ),
          Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (val) {},
                checkColor: kPrimaryColor,
                fillColor: MaterialStateProperty.resolveWith((Set states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.white;
                  }
                  return Colors.white;
                }),
                side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(width: 1.0, color: kPrimaryColor),
                ),
              ),
              Text(
                "I agree, to all the Terms & Conditions",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
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
                            )),
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
                            child: Text("Pay using")),
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
                                                                  : const Icon(Icons.account_balance_wallet_rounded)
                                                              : const Text(
                                                                  "Choose\npayment\nmethod",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                            ),
                            const Icon(Icons.arrow_drop_down_sharp)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  onTap: () async {
                    var bookingDate = businessController.currentDate2.value;
                    var bookingStatus =
                        await BusinessServices().verifyBookings({
                      "bookedDate": DateTime.parse(bookingDate.toString()),
                      "businessId": businessController.business.uid.toString(),
                      "serviceName": businessController.business.addedServices![
                              businessController.selectedBusinessIndex.value]
                          ['addedServiceName']
                    });

                    if (bookingStatus["status"] == "success") {
                      Get.toNamed(
                        '/verifyOrder',
                        parameters: {
                          "uid": businessController.business.uid.toString(),
                          "businessImage": businessController
                              .business.businessImage
                              .toString(),
                          "price": businessController
                              .business
                              .addedServices![businessController
                                  .selectedBusinessIndex
                                  .value]['addedServicePrice']
                              .toString(),
                          "tokenAdvance": businessController
                              .business.tokenAdvance
                              .toString(),
                          "businessName": businessController
                              .business.businessName
                              .toString(),
                          "businessContactNumber": businessController
                              .business.phoneNumber
                              .toString(),
                          "serviceName":
                              businessController.business.addedServices![
                                  businessController.selectedBusinessIndex
                                      .value]['addedServiceName'],
                          "bookingDate": bookingDate.toString(),
                        },
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      showErrorSnackbar(context,
                          "Service is alreday booked by you/someone else");
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
                        "Confirm",
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
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
