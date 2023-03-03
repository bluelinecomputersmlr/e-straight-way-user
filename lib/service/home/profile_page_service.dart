import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/service/service_provider/payment_confirmation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_connect/connect.dart';

class ProfilePageService extends GetConnect {
  uploadProfilePhoto(profilePhoto) async {
    return await FirebaseFirestore.instance
        .collection("straightWayUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        Reference reference = FirebaseStorage.instance.ref().child(
            "/users/${FirebaseAuth.instance.currentUser!.uid}/${profilePhoto.path.toString()}");
        UploadTask uploadTask = reference.putFile(profilePhoto);
        TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
        String url = (await downloadUrl.ref.getDownloadURL());
        value.reference.set({'profilePhoto': url}, SetOptions(merge: true));
      }
    });
  }

  Future<Map> getReferalCode() async {
    try {
      var userData = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userData.exists) {
        if (userData.data()!["referCode"] != null) {
          return {
            "status": "success",
            "referCode": userData.data()!["referCode"]
          };
        } else {
          var userName = userData.data()!["userName"];
          var referalCode =
              userName + (Random.secure().nextInt(200) + 100).toString();
          var data = {"referCode": referalCode};
          var updateResponse = await PaymentConfirmService()
              .updateServiceProviderPaymentStatus(data);

          if (updateResponse["status"] == "success") {
            return {"status": "success", "referCode": data["referCode"]};
          } else {
            return {
              "status": "error",
              "message": "Unable to create referal code"
            };
          }
        }
      } else {
        return {"status": "error", "message": "User not found"};
      }
    } catch (e) {
      return {"status": "error", "message": "Some error ocured"};
    }
  }

  logoutUser() {
    return FirebaseAuth.instance.signOut();
  }
}
