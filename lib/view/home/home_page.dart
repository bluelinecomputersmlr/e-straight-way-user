import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/controller/home/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(HomePageController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: kMainBackgroundColor,
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 100),
          height: 55,
          backgroundColor: kBottonNavbarColor,
          color: Colors.white,
          items: <Widget>[
            SvgPicture.asset('assets/icons/icon1.svg'),
            SvgPicture.asset('assets/icons/icon2.svg'),
            SvgPicture.asset('assets/icons/icon3.svg'),
            SvgPicture.asset('assets/icons/icon4.svg'),
          ],
          onTap: (index) {
            if (index == 3) {
              Get.toNamed('/profile');
            }
            //Handle button tap
          },
        ),
        body: Obx(
          () => SafeArea(
            child: (homePageController.isMainPageLoading.value)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (homePageController.isMainError.value)
                    ? Center(
                        child: Text(
                          homePageController.mainErrorMessage.value,
                          style: GoogleFonts.inter(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView(
                        children: [
                          // WELCOME TEXT
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffF2F6FF),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/location_icon.svg'),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              homePageController
                                                  .userData.value.userName
                                                  .toString(),
                                              style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Text(
                                          '456, 56th lane, Puttur, Mangalore',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed("/profile");
                                    },
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            homePageController.userData.value
                                                        .profilePhoto !=
                                                    null
                                                ? homePageController.userData
                                                    .value.profilePhoto!
                                                : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhQ0ZF4v6iA_zXWvSLobRHuPGHh3MX3kirJ0jkuM_Q&s",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          //WHITE SPACE
                          const SizedBox(
                            height: 8.0,
                          ),

                          //DESCRIPTION TEXT
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: 1.sw,
                              height: .12.sw,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 1)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      'Search Service',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        color: Colors.grey.withOpacity(0.5),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: .28.sw,
                                      height: .25.sw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ]),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              'https://firebasestorage.googleapis.com/v0/b/e-straightway.appspot.com/o/intro_images%2F5385957.png?alt=media&token=e6e0c7a4-b9b6-4622-b94b-8d8c2c72df4a',
                                          fit: BoxFit.fill),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        'Efficient',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: .28.sw,
                                      height: .25.sw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ]),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              'https://firebasestorage.googleapis.com/v0/b/e-straightway.appspot.com/o/intro_images%2FHand%20of%20cartoon%20person%20holding%20cell%20phone%20with%20map%20application.png?alt=media&token=1122fd4f-d7c5-45c8-b231-b4a3441f629b',
                                          fit: BoxFit.fill),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        'Simple',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: .28.sw,
                                      height: .25.sw,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ]),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              'https://firebasestorage.googleapis.com/v0/b/e-straightway.appspot.com/o/intro_images%2Fbest-quality-guarantee-assurance-concept.png?alt=media&token=77551c4c-f9a2-421b-8883-bf29d715ed9b',
                                          fit: BoxFit.fill),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        'Rich Experience',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          homePageController.banners!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: .45.sw,
                                        child: CarouselSlider(
                                          carouselController: homePageController
                                              .carouselController,
                                          options: CarouselOptions(
                                              viewportFraction: 0.9,
                                              height: .4.sh,
                                              autoPlay: true,
                                              onPageChanged: (index, reason) {
                                                homePageController
                                                    .updateIndex(index);
                                              }),
                                          items: homePageController.banners
                                              ?.map((item) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      child: CachedNetworkImage(
                                                        imageUrl: item,
                                                        width: 1.sw,
                                                        fit: BoxFit.fill,
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          valueColor:
                                                              const AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                        )),
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

                          // CATEGORIES SUBSCRIBED
                          const SizedBox(
                            height: 10.0,
                          ),

                          // ALL CATEGORY TEXT
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Category',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          (homePageController.categories!.value.isEmpty)
                              ? Center(
                                  child: Text(
                                    "No Categories To Display.",
                                    style: GoogleFonts.inter(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GridView.builder(
                                    itemCount:
                                        homePageController.categories.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 0.6,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            '/subCategory?categoryUID=${homePageController.categories[index].uid}',
                                            arguments: homePageController
                                                .categories[index]);
                                      },
                                      child: ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                          Hero(
                                            tag:
                                                '${homePageController.categories[index].uid}',
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    homePageController
                                                        .categories[index]
                                                        .photoUrl!,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            homePageController
                                                .categories[index].name!,
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                          const SizedBox(
                            height: 40.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Image.asset('assets/icons/logo_text.png'),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
