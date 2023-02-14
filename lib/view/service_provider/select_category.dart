import 'package:cached_network_image/cached_network_image.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/auth/login_controller.dart';
import 'package:estraightwayapp/controller/auth/sign_up_service_provider_contoller.dart';
import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/service/auth/login_service.dart';
import 'package:estraightwayapp/widget/custom_loading_indicator.dart';
import 'package:estraightwayapp/widget/text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectCategoryPage extends StatelessWidget {
  SelectCategoryPage({Key? key}) : super(key: key);

  final _userNameController = TextEditingController();

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
        future: signUpController.getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              itemCount: snapshot.data!.length,
              shrinkWrap: false,
              primary: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  signUpController.category = snapshot.data![index];
                  signUpController.categoryController.text =
                      snapshot.data![index].name!;
                  signUpController.subCategoryController.text = '';
                  signUpController.subCategory = null;
                  Get.back();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            snapshot.data![index].photoUrl!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        snapshot.data![index].name!,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
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
