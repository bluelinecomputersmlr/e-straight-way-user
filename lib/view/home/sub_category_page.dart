import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/controller/home/sub_category_controller.dart';
import 'package:estraightwayapp/widget/angle_clipper.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estraightwayapp/widget/custom_loading_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class SubCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subCategoryController = Get.put(SubCategoryController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(.4.sw),
        child: Stack(
          children: [
            Hero(
              tag: '${subCategoryController.category.uid}',
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
                              subCategoryController.category.photoUrl!))),
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
                subCategoryController.category.name!,
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
            isBusy: subCategoryController.isLoading.isTrue,
            hasError: subCategoryController.isError.isTrue,
            child: FutureBuilder(
              future: subCategoryController.getSubCategory(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<SubCategoryModel>> snapshot) {
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
                          if (snapshot.data![index].subCategoryType == "date") {
                            Get.toNamed('/businessByDate?subCategoryUID=${snapshot.data![index].uid}',
                                arguments: snapshot.data![index]);
                          } else if (snapshot.data![index].subCategoryType == "service") {
                            Get.toNamed('/businessByService?subCategoryUID=${snapshot.data![index].uid}',
                                arguments: snapshot.data![index]);
                          } else if (snapshot.data![index].subCategoryType == "maps") {
                            Get.toNamed('/businessByMap?subCategoryUID=${snapshot.data![index].uid}',
                                arguments: snapshot.data![index]);
                          }
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
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
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(14),
                                      bottomRight: Radius.circular(14)),
                                ),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data![index].subCategoryName ?? '',
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
