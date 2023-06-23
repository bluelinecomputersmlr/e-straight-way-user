import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/bookings_model.dart';
import 'package:estraightwayapp/notification_service.dart';
import 'package:estraightwayapp/view/auth/admin_service.dart';
import 'package:estraightwayapp/view/auth/sos_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class BookingService {
  static CollectionReference bookingServices = FirebaseFirestore.instance.collection('Bookings');

  static Future<bool> getBookingData() async {
    try {
      QuerySnapshot querySnapshot = await bookingServices.get();
      String userId = FirebaseAuth.instance.currentUser!.uid;
      print('UserId --> $userId');
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          Map<String, dynamic> map = element.data() as Map<String, dynamic>;
          BookingModel categoryModel = BookingModel.fromJson(map);
          if (categoryModel.userId == userId && !categoryModel.isCancelled && !categoryModel.isCompleted && !categoryModel.isOrderCompleted && categoryModel.isServiceProviderAccepted && categoryModel.acceptedDate.day == DateTime.now().day) {
            return true;
          }
        }
      }
      return false;
    } on FirebaseException catch (e) {
      print('Catch error in get booking data : ${e.message}');
      return false;
    }
  }

  static Future<void> sendSosCall() async {
    QuerySnapshot querySnapshot = await bookingServices.get();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    BookingModel? currentBookingModel;
    if (querySnapshot.docs.isNotEmpty) {
      for (var element in querySnapshot.docs) {
        Map<String, dynamic> map = element.data() as Map<String, dynamic>;
        BookingModel categoryModel = BookingModel.fromJson(map);
        if (categoryModel.userId == userId && !categoryModel.isCancelled && !categoryModel.isCompleted && !categoryModel.isOrderCompleted && categoryModel.isServiceProviderAccepted && categoryModel.acceptedDate.day == DateTime.now().day) {
          currentBookingModel = categoryModel;
        }
      }
    }
    if (currentBookingModel != null) {
      String? adminToken = await AdminService.getAdmins();
      if (adminToken != null && adminToken.isNotEmpty) {
        log('FCM Token --> ${await FirebaseMessaging.instance.getToken()}');
        await NotificationService.instance.sendNotification(
          adminToken,
          'URGENT: I require immediate assistance. This is an emergency situation and I am in danger. Please respond as soon as possible. Thank you.',
        );
        await SosService.createSosRequest(currentBookingModel);
      }
    }
  }

  static Future<String> getBusinessRattingData(String businessId) async {
    int ratting = 0;
    int count = 0;
    try {
      QuerySnapshot querySnapshot = await bookingServices.get();
      print('BusinessId --> $businessId');
      if (querySnapshot.docs.isNotEmpty) {
        for (var element in querySnapshot.docs) {
          Map<String, dynamic> map = element.data() as Map<String, dynamic>;
          BookingModel categoryModel = BookingModel.fromJson(map);
          print('BookingModel --> ${categoryModel.toJson()}');
          if (categoryModel.businessId == businessId) {
            ratting += categoryModel.rating.toInt();
            count++;
            print('Ratting --> ${ratting/count}');
          }
        }
      }
    } on FirebaseException catch (e) {
      print('Catch error in getBusinessRattingData : ${e.message}');
    }
    return (ratting/count).round().toStringAsFixed(1);
  }
}