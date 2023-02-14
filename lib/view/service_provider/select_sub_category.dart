import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/auth/login_controller.dart';
import 'package:estraightwayapp/controller/auth/sign_up_service_provider_contoller.dart';
import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:estraightwayapp/service/auth/login_service.dart';
import 'package:estraightwayapp/widget/custom_loading_indicator.dart';
import 'package:estraightwayapp/widget/text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectSubCategoryPage extends StatelessWidget {
  const SelectSubCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CONTROLLER
    final signUpController = Get.put(SignUpServiceProviderController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(.4.sw),
          child: Stack(children: [
            Positioned(
                top: -.5.sh,
                child: Image.asset(
                  'assets/icons/images/login/login_background_image.png',
                  fit: BoxFit.fitWidth,
                  width: 1.sw,
                )),
            Positioned(
                top: .09.sh,
                left: .26.sw,
                child: Image.asset(
                  'assets/icons/images/login/login_home_center_logo.png',
                  height: .3.sw,
                  width: .45.sw,
                  fit: BoxFit.fitWidth,
                )),
          ])),
      body: FutureBuilder(
        future: signUpController.getSubCategory(),
        builder: (BuildContext context,
            AsyncSnapshot<List<SubCategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              itemCount: snapshot.data!.length,
              shrinkWrap: false,
              primary: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.67,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemBuilder: (BuildContext context, int index) => Hero(
                tag: '${snapshot.data![index].uid}',
                child: GestureDetector(
                  onTap: () {
                    signUpController.subCategory = snapshot.data![index];
                    signUpController.subCategoryController.text =
                        snapshot.data![index].subCategoryName!;
                    Get.back();
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Color(0xffF7F9FF),
                      border: Border.all(color: Color(0xffF7F9FF)),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              height: .5.sw,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    snapshot.data![index].subCategoryImage!,
                                  ),
                                ),
                                border: Border.all(color: Color(0xffD0DFFF)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14)),
                          ),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              snapshot.data![index].subCategoryName!,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14)),
                          ),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              snapshot.data![index].subCategoryType == 'date'
                                  ? 'Slot based booking'
                                  : snapshot.data![index].subCategoryType ==
                                          'map'
                                      ? 'Map based booking'
                                      : "Direct booking",
                              style: GoogleFonts.inter(
                                fontSize: 12,
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
    );
  }
}
