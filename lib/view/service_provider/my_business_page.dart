import 'package:estraightwayapp/controller/service_provider/my_business_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBusinesPage extends StatelessWidget {
  const MyBusinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(MyBusinessController());

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFCEEED9),
      body: Obx(
        () => (businessController.isLoading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  ListView(
                    children: [
                      Image.asset('assets/icons/wave.png'),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //App Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              size: 30.0,
                              color: Color(0xFF3F5C9F),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/logo/estraightway_logo_service_provider.png',
                                width: MediaQuery.of(context).size.width * 0.40,
                              ),
                              Center(
                                child: Text(
                                  "Service Provider",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3F5C9F),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                        ],
                      ),

                      //App Bar Ends Here
                      const SizedBox(
                        height: 20.0,
                      ),

                      (businessController.businessData[0]["addedServices"] !=
                              null)
                          ? Column(
                              children: businessController.businessData[0]
                                      ["addedServices"]
                                  .map<Widget>(
                                    (ele) => Container(
                                      width: size.width,
                                      padding: const EdgeInsets.all(10.0),
                                      margin: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ele["addedServiceName"],
                                            style: GoogleFonts.inter(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            ele["addedServiceDescription"],
                                            style: GoogleFonts.inter(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            "Price: ₹ ${ele["addedServicePrice"]}",
                                            style: GoogleFonts.inter(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 35.0,
                                                width: size.width * 0.42,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Disable Service",
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(
                                                      '/editDateBusiess',
                                                      parameters: {
                                                        "index": businessController
                                                            .businessData[0][
                                                                "addedServices"]
                                                            .indexOf(ele)
                                                            .toString(),
                                                      });
                                                },
                                                child: Container(
                                                  height: 35.0,
                                                  width: size.width * 0.42,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue.shade900,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Edit Service",
                                                      style: GoogleFonts.inter(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                          : Container(
                              width: size.width,
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    businessController.businessData[0]
                                        ["businessName"],
                                    style: GoogleFonts.inter(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    (businessController.businessData[0]
                                                ["description"] !=
                                            null)
                                        ? businessController.businessData[0]
                                            ["description"]
                                        : "",
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Price: ₹ ${businessController.businessData[0]["serviceCharge"]}",
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 35.0,
                                        width: size.width * 0.42,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Disable Service",
                                            style: GoogleFonts.inter(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                            '/editMapAndSlot',
                                          );
                                        },
                                        child: Container(
                                          height: 35.0,
                                          width: size.width * 0.42,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade900,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Edit Service",
                                              style: GoogleFonts.inter(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                  (businessController.businessData[0]["subCategoryType"] ==
                          "date")
                      ? Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 45.0,
                              width: size.width * 0.95,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Center(
                                child: Text(
                                  "Add Service",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
      ),
    );
  }
}
