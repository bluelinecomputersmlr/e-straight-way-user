import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/controller/home/home_controller.dart';
import 'package:estraightwayapp/controller/home/home_service_provider_contoller.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class BusinessServices extends GetConnect {
  Stream<List<BusinessModel>?> getBusiness(
      String id, String? subCategoryType) async* {
    try {
      // yield* FirebaseFirestore.instance
      //     .collection("Businesses")
      //     .where('subCategoryUID', isEqualTo: id)
      //     .snapshots()
      //     .map((snapshot) {
      //   return snapshot.docs
      //       .map((doc) => BusinessModel.fromJson(doc.data()))
      //       .toList();
      // });

      var homePageController = Get.put(HomePageController());

      final geo = GeoFlutterFire();
      var collectionReference = FirebaseFirestore.instance
          .collection('Businesses')
          .where('subCategoryUID', isEqualTo: id)
          .where('isApproved', isEqualTo: true);
      GeoFirePoint center = geo.point(
          latitude: homePageController.latitude.value,
          longitude: homePageController.longitude.value);

      print(center.longitude);

      yield* geo
          .collection(collectionRef: collectionReference)
          .within(center: center, radius: 10.0, field: "location")
          .map((snapshot) {
        return snapshot
            .map((doc) =>
                BusinessModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
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
          response.data()!["serviceProviderDetails"]["businessUID"];

      var businessType =
          response.data()!["serviceProviderDetails"]["businessType"];

      if (businessType != "map") {
        yield* FirebaseFirestore.instance
            .collection("Bookings")
            .where("businessId", isEqualTo: businessId)
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

  Future<Map<String, int>> getAllDasboardData() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      var businessId =
          response.data()!["serviceProviderDetails"]["businessUID"];

      var businessType =
          response.data()!["serviceProviderDetails"]["businessType"];

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
          .where("businessId", isEqualTo: businessId)
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

  Future<Map> createOrder(
      String customerName,
      String customerId,
      String customerPhone,
      String orderNote,
      double amount,
      String orderId) async {
    try {
      var response = await post(
        "http://181.215.79.5/api/v1/createOrder",
        // "http://10.0.2.2:3000/api/v1/createOrder",
        {
          "amount": amount,
          "customer_id": customerId,
          "customer_name": customerName,
          "order_note": orderNote,
          "customer_phone": customerPhone,
        },
      );
      if (response.statusCode == 200) {
        return {"status": "success", "data": response.body["data"]};
      } else {
        return {"status": "error", "message": response.body["message"]};
      }
    } catch (e) {
      return {"status": "error", "message": e};
    }
  }
}
