// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:estraightwayapp/constants.dart';
// import 'package:estraightwayapp/controller/home/sub_category_controller.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class CourseDetailsPage extends StatelessWidget {
//   const CourseDetailsPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final courseDetailsController = Get.put(CourseDetailsController());
//     return Scaffold(
//       backgroundColor: kMainBackgroundColor,
//       body: Obx(
//         () => (courseDetailsController.isLoading.value)
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : (courseDetailsController.isError.value)
//                 ? Center(
//                     child: Text(
//                       courseDetailsController.errorMessage.value,
//                       style: GoogleFonts.inter(
//                         fontSize: 16.0,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
//                 : (courseDetailsController.courseData.value.id == null)
//                     ? Center(
//                         child: Text(
//                           "Course not found",
//                           style: GoogleFonts.inter(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       )
//                     : SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // NEED A CONTAINER FOR ONLY HOLDING THE INNER THUMBNAIL
//                             // AND INSIDE THAT AT THE BOTTOM OF THE CONTAINER ONE MORE FOR HOLDING THE PLAY BUTTON
//                             Container(
//                               height: MediaQuery.of(context).size.height * 0.50,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 image: DecorationImage(
//                                   image: CachedNetworkImageProvider(
//                                     courseDetailsController
//                                         .courseData.value.insideThumbnailUrl
//                                         .toString(),
//                                   ),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               child: Stack(
//                                 children: [
//                                   // BOTTOM MOST CONTAINER
//                                   //WHICH IS BEHIND THE PLAY BUTTON
//                                   Positioned(
//                                     bottom: MediaQuery.of(context).size.height *
//                                         0.01,
//                                     right: 50.0,
//                                     child: Container(
//                                       height: 100.0,
//                                       width: 100.0,
//                                       decoration: BoxDecoration(
//                                         color: kMainBackgroundColor
//                                             .withOpacity(0.50),
//                                         borderRadius:
//                                             BorderRadius.circular(50.0),
//                                       ),
//                                     ),
//                                   ),
//
//                                   //MIDDLE CONTAINER
//                                   //BOTTOM MOST WHITE CONTAINER
//                                   Positioned(
//                                     bottom: 0,
//                                     child: Container(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.08,
//                                       width: MediaQuery.of(context).size.width,
//                                       decoration: const BoxDecoration(
//                                         color: kMainBackgroundColor,
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(50.0),
//                                           topRight: Radius.circular(50.0),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                   //TOP CONTAINER
//                                   // PLAY BUTTON CONTAINER
//                                   Positioned(
//                                     bottom: 18,
//                                     right: 60.0,
//                                     child: InkWell(
//                                       onTap: () {
//                                         Get.toNamed('/video', arguments: {
//                                           "videoUrl": courseDetailsController
//                                               .courseData.value.videoUrl
//                                               .toString()
//                                         });
//                                       },
//                                       borderRadius: BorderRadius.circular(50.0),
//                                       child: Container(
//                                         height: 80.0,
//                                         width: 80.0,
//                                         decoration: BoxDecoration(
//                                           color: kPlayButtonColor,
//                                           borderRadius:
//                                               BorderRadius.circular(50.0),
//                                         ),
//                                         child: const Center(
//                                           child: Icon(
//                                             Icons.play_arrow,
//                                             color: Colors.white,
//                                             size: 50.0,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                   // BACK BUTTON
//                                   Positioned(
//                                     left: 20.0,
//                                     top: 20.0,
//                                     child: SafeArea(
//                                       child: InkWell(
//                                         onTap: () {
//                                           Get.back();
//                                         },
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                         child: Container(
//                                           height: 35.0,
//                                           width: 35.0,
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: kOtherextFontColor,
//                                                 width: 2.0),
//                                             borderRadius:
//                                                 BorderRadius.circular(10.0),
//                                           ),
//                                           child: const Center(
//                                             child: Icon(
//                                               Icons.arrow_back,
//                                               color: kOtherextFontColor,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             //COURSE DETAILS GOES HERE
//
//                             // COURSE TITLE GOES HERE
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20.0),
//                               child: Text(
//                                 courseDetailsController.courseData.value.name
//                                     .toString(),
//                                 style: GoogleFonts.rubik(
//                                   color: kHeaderTextFontColor,
//                                   fontSize: 24.0,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//
//                             // WHITESPACE
//                             const SizedBox(
//                               height: 25.0,
//                             ),
//
//                             // COURSE CONTENT TEXT GOES HERE
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20.0),
//                               child: Text(
//                                 "COURSE CONTENTS",
//                                 style: GoogleFonts.inter(
//                                   color: kHeaderTextFontColor,
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ),
//
//                             // WHITESPACE
//                             const SizedBox(
//                               height: 20.0,
//                             ),
//
//                             // WHAT YOU'LL LEARN TEXT GOES HERE
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20.0),
//                               child: Row(
//                                 children: [
//                                   Image.asset("assets/images/edu.png"),
//                                   // WHITESPACE
//                                   const SizedBox(
//                                     width: 15.0,
//                                   ),
//                                   Text(
//                                     "WHAT YOU'LL LEARN",
//                                     style: GoogleFonts.inter(
//                                       color: kHeaderTextFontColor,
//                                       fontSize: 18.0,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             // WHITESPACE
//                             const SizedBox(
//                               height: 20.0,
//                             ),
//
//                             // COURSE DESCRIPTION FILED
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20.0),
//                               child: Text(
//                                 courseDetailsController
//                                     .courseData.value.description
//                                     .toString(),
//                                 style: GoogleFonts.inter(
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w500,
//                                   height: 1.5,
//                                 ),
//                               ),
//                             ),
//
//                             // WHITESPACE
//                             const SizedBox(
//                               height: 20.0,
//                             ),
//                           ],
//                         ),
//                       ),
//       ),
//     );
//   }
// }
