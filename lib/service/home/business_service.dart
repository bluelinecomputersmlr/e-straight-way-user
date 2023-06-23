import 'dart:developer' as dev;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/controller/home/home_controller.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/home/user_services.dart';
import 'package:estraightwayapp/service/home/wallet_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer';

class BusinessServices extends GetConnect {
  Stream<List<BusinessModel>?> getBusiness(String id, String? subCategoryType) async* {
    try {
      var homePageController = Get.put(HomePageController());

      final geo = GeoFlutterFire();
      print('subCategoryUID --> $id');
      await homePageController.getLocation();
      var collectionReference = FirebaseFirestore.instance.collection('Businesses').where('subCategoryUID', isEqualTo: id).where('isApproved', isEqualTo: true);
      GeoFirePoint center = geo.point(latitude: homePageController.latitude.value, longitude: homePageController.longitude.value);

      print('lat${homePageController.latitude.value}');
      print('lats${center.latitude}');
      print(center.longitude);

      yield* geo
          .collection(collectionRef: collectionReference)
          .within(center: center, radius: 10.0, field: "location", strictMode: true)
          .map((snapshot) => snapshot.map((doc) => BusinessModel.fromJson(doc.data() as Map<String, dynamic>)).toList());
    } catch (e) {
      print(e);
      yield null;
    }
  }

  // Future<Map> getBusinessData()async{
  //   try {
  //     var response = await
  //   } catch (e) {

  //   }
  // }

  Future<Map> verifyBookings(Map<String, dynamic> orderData) async {
    try {
      var endDate = DateTime(
        orderData["bookedDate"].year,
        orderData["bookedDate"].month,
        orderData["bookedDate"].day,
        23,
        59,
        59,
      );

      var startDate = DateTime(
        orderData["bookedDate"].year,
        orderData["bookedDate"].month,
        orderData["bookedDate"].day,
        00,
        00,
        00,
      );

      if (orderData["serviceName"] != "Map") {
        var response = await FirebaseFirestore.instance
            .collection("Bookings")
            .where("bookedDate", isLessThanOrEqualTo: endDate)
            .where("bookedDate", isGreaterThanOrEqualTo: startDate)
            .where("businessId", isEqualTo: orderData["businessId"])
            .where("serviceName", isEqualTo: orderData["serviceName"])
            .where("isCompleted", isEqualTo: false)
            .get();

        if (response.size > 0) {
          return {"status": "error", "message": "Service is already booked!"};
        } else {
          return {"status": "success"};
        }



      } else {
        return {"status": "success"};
      }
    } catch (e) {
      print(e);
      return {"status": "error", "message": "Some error occoured"};
    }
  }

  Future<Map> bookService(Map<String, dynamic> orderData) async {
    try {
      var endDate = DateTime(
        orderData["bookedDate"].year,
        orderData["bookedDate"].month,
        orderData["bookedDate"].day,
        23,
        59,
        59,
      );

      var startDate = DateTime(
        orderData["bookedDate"].year,
        orderData["bookedDate"].month,
        orderData["bookedDate"].day,
        00,
        00,
        00,
      );

      if (orderData["serviceName"] != "Map") {
        var response = await FirebaseFirestore.instance
            .collection("Bookings")
            .where("bookedDate", isLessThanOrEqualTo: endDate)
            .where("bookedDate", isGreaterThanOrEqualTo: startDate)
            .where("businessId", isEqualTo: orderData["businessId"])
            .where("serviceName", isEqualTo: orderData["serviceName"])
            .where("isCompleted", isEqualTo: false)
            .get();

        if (response.size > 0) {
          return {"status": "error", "message": "Service is already booked!"};
        }
      }
      await FirebaseFirestore.instance
          .collection("Bookings")
          .doc(orderData["id"])
          .set(orderData, SetOptions(merge: true));
      return {
        "status": "success",
      };
    } catch (e) {
      print(e);

      return {"status": "error", "message": "Unable to place the order"};
    }
  }

  Future<Map> getBookedService() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("Bookings")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy("bookedDate")
          .get();

      var data = response.docs.toList();

      var responseData = [];

      for (var doc in data) {
        responseData.add(doc.data());
      }

      return {"status": "success", "data": responseData};
    } catch (e) {
      print(e);

      return {"status": "error", "message": "Unable to get the booked service"};
    }
  }

  Stream<List?> getBookingsStream() async* {
    try {
      yield* FirebaseFirestore.instance
          .collection("Bookings")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .orderBy("bookedDate", descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      yield null;
    }
  }

  Stream<List?> getBookingsStreamServiceProvider() async* {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var businessId =
          response.data()!["serviceProviderDetails"]["businessUID"] ?? '';

      var businessType =
          response.data()!["serviceProviderDetails"]["businessType"] ?? '';

      if (businessType != "maps") {
        yield* FirebaseFirestore.instance
            .collection("Bookings")
            // .where("businessId", isEqualTo: businessId)
            .where("isServiceProviderAccepted", isEqualTo: false)
            .where("isOrderCompleted", isEqualTo: false)
            .where("isRejected", isEqualTo: false)
            .orderBy("bookedDate")
            .snapshots()
            .map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
      } else {
        Location location = Location();

        bool serviceEnabled = false;
        PermissionStatus _permissionGranted;
        LocationData _locationData;

        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) {
            yield null;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            yield null;
          }
        }

        _locationData = await location.getLocation();

        final geo = GeoFlutterFire();

        GeoFirePoint center = geo.point(
            latitude: _locationData.latitude!,
            longitude: _locationData.longitude!);

        var collectionReference = FirebaseFirestore.instance
            .collection("Bookings")
            .where("serviceName", isEqualTo: "Map")
            .where("businessId", isEqualTo: "")
            .where("isServiceProviderAccepted", isEqualTo: false)
            .where("isOrderCompleted", isEqualTo: false)
            .where("isRejected", isEqualTo: false);
        // .orderBy("bookedDate");

        yield* geo
            .collection(collectionRef: collectionReference)
            .within(center: center, radius: 10.0, field: "location")
            .map((snapshot) {
          return snapshot.map((doc) => doc.data()).toList();
        });
      }
    } catch (e) {
      yield null;
    }
  }

  Stream<List?> getRecievedBookingsStreamServiceProvider() async* {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var businessId =
          response.data()!["serviceProviderDetails"]["businessUID"];
      yield* FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("isServiceProviderAccepted", isEqualTo: true)
          .orderBy("bookedDate")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      yield null;
    }
  }

  Stream<List?> getTodaysAcceptedBookingsStreamServiceProvider() async* {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var businessId =
          response.data()!["serviceProviderDetails"]["businessUID"];

      var endDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
        59,
      );

      var startDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        00,
        00,
        00,
      );

      yield* FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("isServiceProviderAccepted", isEqualTo: true)
          .where("acceptedDate", isLessThanOrEqualTo: endDate)
          .where("acceptedDate", isGreaterThanOrEqualTo: startDate)
          .orderBy("acceptedDate")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print(e);
      yield null;
    }
  }

  Stream<List?> getTodaysRejectedBookingsStreamServiceProvider() async* {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var businessId =
          response.data()!["serviceProviderDetails"]["businessUID"];

      var endDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
        59,
      );

      var startDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        00,
        00,
        00,
      );

      yield* FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("isServiceProviderAccepted", isEqualTo: false)
          .where("isRejected", isEqualTo: true)
          .where("rejectedDate", isLessThanOrEqualTo: endDate)
          .where("rejectedDate", isGreaterThanOrEqualTo: startDate)
          .orderBy("rejectedDate")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print(e);
      yield null;
    }
  }

  Stream<List?> getCustomerReviewsStreamServiceProvider() async* {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var businessId =
          response.data()!["serviceProviderDetails"]["businessUID"];

      yield* FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("rating", isGreaterThan: 0)
          .orderBy("rating")
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } catch (e) {
      print(e);
      yield null;
    }
  }

  Future<Map> updateBookingsData(String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection("Bookings")
          .doc(id)
          .update(data);
      return {"status": "success"};
    } catch (e) {
      print(e);
      return {"status": "error"};
    }
  }

  Future<Map> updateBusinessData(String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection("Businesses")
          .doc(id)
          .update(data);

      return {"status": "success"};
    } catch (e) {
      print(e);
      return {"status": "error"};
    }
  }

  static Stream<List> acceptedBookings({required String businessId}) {
    print('acceptedBookings id --> $businessId');
    Query<Map<String, dynamic>> receivedBooking = FirebaseFirestore.instance
        .collection("Bookings")
        .where("businessId", isEqualTo: businessId)
        .where("isServiceProviderAccepted", isEqualTo: true)
        .orderBy("bookedDate");

    return receivedBooking.snapshots().map((event) => event.docs.map((e) => e.data()).toList());
  }

  static Stream<List<BusinessModel>> newBookings() {
    Query<Map<String, dynamic>> newBooking = FirebaseFirestore.instance
        .collection("Bookings")
        .where("isServiceProviderAccepted", isEqualTo: false)
        .where("isOrderCompleted", isEqualTo: false)
        .where("isRejected", isEqualTo: false)
        .orderBy("bookedDate");

    return newBooking.snapshots().map((event) => event.docs.map((e) => BusinessModel.fromJson(e.data())).toList());
  }

  static Stream<List<BusinessModel>> todayCompletedOrders({required String businessId}) {
    DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
    DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 00, 00);

    Query<Map<String, dynamic>> todayCompletedOrder = FirebaseFirestore.instance
        .collection("Bookings")
        .where("businessId", isEqualTo: businessId)
        .where("isServiceProviderAccepted", isEqualTo: true)
        .where("acceptedDate", isLessThanOrEqualTo: endDate)
        .where("acceptedDate", isGreaterThanOrEqualTo: startDate)
        .orderBy("acceptedDate");

    return todayCompletedOrder.snapshots().map((event) => event.docs.map((e) => BusinessModel.fromJson(e.data())).toList());
  }

  static Stream<List<BusinessModel>> todayCancelledOrders({required String businessId}) {
    DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
    DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 00, 00, 00);

    Query<Map<String, dynamic>> todayCompletedOrder = FirebaseFirestore.instance
        .collection("Bookings")
        .where("businessId", isEqualTo: businessId)
        .where("isServiceProviderAccepted", isEqualTo: false)
        .where("isRejected", isEqualTo: true)
        .where("rejectedDate", isLessThanOrEqualTo: endDate)
        .where("rejectedDate", isGreaterThanOrEqualTo: startDate)
        .orderBy("rejectedDate");

    return todayCompletedOrder.snapshots().map((event) => event.docs.map((e) => BusinessModel.fromJson(e.data())).toList());
  }

  static Stream<List<BusinessModel>> reviewedOrders({required String businessId}) {
    Query<Map<String, dynamic>> todayCompletedOrder = FirebaseFirestore.instance
        .collection("Bookings")
        .where("businessId", isEqualTo: businessId)
        .where("rating", isGreaterThan: 0)
        .orderBy("rating");

    return todayCompletedOrder.snapshots().map((event) => event.docs.map((e) => BusinessModel.fromJson(e.data())).toList());
  }

  Future<Map<String, int>> getAllDasboardData() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var businessId = response.data()!["serviceProviderDetails"]["businessUID"];

      var businessType = response.data()!["serviceProviderDetails"]["businessType"];

      var endDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        23,
        59,
        59,
      );

      var startDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        00,
        00,
        00,
      );

      var receivedBooking = await FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("isServiceProviderAccepted", isEqualTo: true)
          .orderBy("bookedDate")
          .get();

      QuerySnapshot<Map<String, dynamic>> newBooking;

      // if (businessType != "map") {
      newBooking = await FirebaseFirestore.instance
          .collection("Bookings")
          // .where("businessId", isEqualTo: businessId)
          .where("isServiceProviderAccepted", isEqualTo: false)
          .where("isOrderCompleted", isEqualTo: false)
          .where("isRejected", isEqualTo: false)
          .orderBy("bookedDate")
          .get();
      // }
      // else {
      // Location location = Location();

      // bool serviceEnabled = false;
      // PermissionStatus _permissionGranted;
      // LocationData _locationData;

      // if (!serviceEnabled) {
      //   serviceEnabled = await location.requestService();
      //   if (!serviceEnabled) {}
      // }

      // _permissionGranted = await location.hasPermission();
      // if (_permissionGranted == PermissionStatus.denied) {
      //   _permissionGranted = await location.requestPermission();
      //   if (_permissionGranted != PermissionStatus.granted) {}
      // }

      // _locationData = await location.getLocation();

      // final geo = GeoFlutterFire();

      // GeoFirePoint center = geo.point(
      //     latitude: _locationData.latitude!,
      //     longitude: _locationData.longitude!);

      // var collectionReference = FirebaseFirestore.instance
      //     .collection("Bookings")
      //     .where("serviceName", isEqualTo: "Map")
      //     .where("businessId", isEqualTo: "")
      //     .where("isServiceProviderAccepted", isEqualTo: false)
      //     .where("isOrderCompleted", isEqualTo: false)
      //     .where("isRejected", isEqualTo: false);
      // .orderBy("bookedDate");

      // newBooking =await geo
      //     .collection(collectionRef: collectionReference)
      //     .within(center: center, radius: 500.0, field: "location").;
      // newBooking = await FirebaseFirestore.instance
      //     .collection("Bookings")
      //     .where("serviceName", isEqualTo: "Map")
      //     .where("businessId", isEqualTo: "")
      //     .where("isServiceProviderAccepted", isEqualTo: false)
      //     .where("isOrderCompleted", isEqualTo: false)
      //     .where("isRejected", isEqualTo: false)
      //     .get();
      // }

      var todaysConfirmedBooking = await FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("isServiceProviderAccepted", isEqualTo: true)
          .where("acceptedDate", isLessThanOrEqualTo: endDate)
          .where("acceptedDate", isGreaterThanOrEqualTo: startDate)
          .orderBy("acceptedDate")
          .get();

      var todaysCancelledBooking = await FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("isServiceProviderAccepted", isEqualTo: false)
          .where("isRejected", isEqualTo: true)
          .where("rejectedDate", isLessThanOrEqualTo: endDate)
          .where("rejectedDate", isGreaterThanOrEqualTo: startDate)
          .orderBy("rejectedDate")
          .get();

      var customerReviews = await FirebaseFirestore.instance
          .collection("Bookings")
          .where("businessId", isEqualTo: businessId)
          .where("rating", isGreaterThan: 0)
          .orderBy("rating")
          .get();

      var receivedBookingCount = receivedBooking.size;
      var newBookingCount = newBooking.size;
      var todaysConfirmedBookingCount = todaysConfirmedBooking.size;
      var todaysCancelledBookingCount = todaysCancelledBooking.size;
      var customerReviewsCount = customerReviews.size;

      return {
        "receivedBookingCount": receivedBookingCount,
        "newBookingCount": newBookingCount,
        "todaysConfirmedBookingCount": todaysConfirmedBookingCount,
        "todaysCancelledBookingCount": todaysCancelledBookingCount,
        "customerReviewsCount": customerReviewsCount,
      };
    } catch (e) {
      print(e);
      return {
        "receivedBookingCount": 0,
        "newBookingCount": 0,
        "todaysConfirmedBookingCount": 0,
        "todaysCancelledBookingCount": 0,
        "customerReviewsCount": 0,
      };
    }
  }

  Future<Map> createOrder(String customerName, String customerId, String customerPhone, String orderNote, double amount, String orderId) async {
    try {
      Map bodyMap = {
        "customer_details": {
          "customer_id": customerId,
          "customer_email": "${customerName.trim().replaceAll(' ', '')}@gmail.com",
          "customer_phone": customerPhone
        },
        "order_amount": amount,
        "order_currency": "INR"
      };
      Map<String, String> headerMap = {
        'accept': 'application/json',
        'content-type': 'application/json',
        'x-api-version': '2022-09-01',
        'x-client-id': '37308335488d0d4bc488e8f376380373',
        'x-client-secret': 'd6074d362e4f73b15c025a774cb399e0ccf80829',
      };
      print('bodyMap --> $bodyMap');
      print('headerMap --> $headerMap');
      var response = await post("https://api.cashfree.com/pg/orders", bodyMap, headers: headerMap);
      print('Response body --> ${response.statusCode}');
      print('Response body --> ${response.body}');
      if (response.statusCode == 200) {
        return {"status": "success", "data": response.body};
      } else if (response.statusCode == 404) {
        return {"status": "error", "data": 'Server error.! Please wait...'};
      } else {
        return {"status": "error", "message": response.body["message"]};
      }
    } catch (e) {
      return {"status": "error", "message": e};
    }
  }

  Future<Map> depositReferEarnToWallet(String fromUserId) async {
    try {
      var inviteTransactions = await FirebaseFirestore.instance
          .collection("transactions")
          .where("fromUserId", isEqualTo: fromUserId)
          .where("addedToWallet", isEqualTo: false)
          .get();

      if (inviteTransactions.size > 0) {
        var data = inviteTransactions.docs.toList();

        var responseData = [];

        for (var doc in data) {
          responseData.add(doc.data());
        }

        var transactionId = responseData[0]["id"];
        var toUserId = responseData[0]["userId"];
        var updateData = {"addedToWallet": true};

        var userDataResponse =
            await UserServices().getUserData(userId: toUserId);

        var walletAmount = userDataResponse["data"][0]["wallet"];
        Map<String, int> walletdata;

        if (walletAmount != null) {
          walletdata = {
            "wallet": walletAmount + 20,
          };
        } else {
          walletdata = {
            "wallet": 20,
          };
        }
        await UserServices().updateUserData(toUserId, walletdata);

        await FirebaseFirestore.instance
            .collection("transactions")
            .doc(transactionId)
            .update(updateData);
      }

      return {"status": "success"};
    } catch (e) {
      return {"status": "error", "message": e};
    }
  }

  Future<Map> refundMoney(String userId, int amount) async {
    try {
      var transactionId = const Uuid().v4();

      var userDataResponse = await UserServices().getUserData(userId: userId);

      var walletAmount = userDataResponse["data"][0]["wallet"];

      Map<String, int> walletdata;

      if (walletAmount != null) {
        walletdata = {
          "wallet": walletAmount + amount,
        };
      } else {
        walletdata = {
          "wallet": amount,
        };
      }
      await UserServices().updateUserData(userId, walletdata);

      var transactionData = {
        "amount": amount,
        "fromUserId": "",
        "message": "Refund",
        "type": "Credit",
        "createdDate": DateTime.now(),
        "id": transactionId,
        "userId": userId,
      };

      await WalletService().createTransactions(transactionId, transactionData);

      return {"status": "success"};
    } catch (e) {
      return {"status": "error", "message": e};
    }
  }
}
