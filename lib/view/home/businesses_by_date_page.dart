import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/controller/home/business_controller.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/widget/angle_clipper.dart';
import 'package:estraightwayapp/widget/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessesByDatePage extends StatelessWidget {
  const BusinessesByDatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final businessController = Get.put(BusinessController());
    NumberFormat formatCurrency = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: 'INR', decimalDigits: 0);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(.4.sw),
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
                          colorFilter: ColorFilter.mode(
                              Colors.black26, BlendMode.darken),
                          image: CachedNetworkImageProvider(businessController
                              .subCategory.subCategoryImage!))),
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
      body: SafeArea(
        child: Container(
          child: CustomLoadingIndicator(
            isBusy: businessController.isLoading.isTrue,
            hasError: businessController.isError.isTrue,
            child: StreamBuilder(
              stream: businessController.getBusiness(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<BusinessModel>?> snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: false,
                    primary: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemBuilder: (BuildContext context, int index) => Hero(
                      tag: '${snapshot.data![index].uid}',
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              '/businessByDateDetails?subCategoryUID=${snapshot.data![index].uid}',
                              arguments: snapshot.data![index]);
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                snapshot.data![index].businessImage!,
                              ),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(14),
                                      bottomRight: Radius.circular(14)),
                                ),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data![index].businessName!,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
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
