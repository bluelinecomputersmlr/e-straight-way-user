import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:estraightwayapp/controller/auth/login_controller.dart';
import 'package:get/get.dart';

class LoginService extends GetConnect {
  Future loginUser() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (response.data() != null) {
        updateToken();
        return {"status": "success", "user": response.data()};
      } else {
        return {"status": "error", "message": "Some error occurred"};
      }
    } catch (e) {
      return {"status": "error", "message": "Some error occurred"};
    }
  }

//Adding firebase token to the user account to trigger notification
  Future<void> updateToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    var id = FirebaseAuth.instance.currentUser?.uid;
    try {
      await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(id)
          .update({"token": fcmToken});
    } catch (e) {
      print(e);
    }
  }

  // CREATING OTP AND TRIGGERING

  Future verifyPhone(String number, LoginController controller) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91 $number",
        timeout: const Duration(seconds: 0),
        verificationCompleted: (PhoneAuthCredential credential) async {
          var response = await LoginService().loginUser();
          if (response["status"] == "success") {
            LoginService().updateUser();
            Get.offAllNamed('/home');
          } else {
            Get.offAllNamed('/signUp');
          }
        },
        verificationFailed: (FirebaseAuthException e) async {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar(
              "Oops",
              e.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            Get.snackbar(
              "Oops",
              e.toString(),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          controller.setVerificationCode(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      return {"status": "error", "message": "Some unknown error occurred"};
    }
  }

  // CONFIRMING OTP
  Future submitOtp(String verificationId, smsCode) async {
    final phoneCredentials = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      final credentials =
          await FirebaseAuth.instance.signInWithCredential(phoneCredentials);
      if (credentials.user != null) {
        return {"status": "success", "credentials": credentials};
      }
      return {"status": "error", "message": "Some unknown error occurred"};
    } on FirebaseAuthException catch (e) {
      return {"status": "error", "message": "Some unknown error occurred"};
    }
  }

  addUser(String userName) {
    UserModel user = UserModel();
    User? userCredentials = FirebaseAuth.instance.currentUser;
    user.userName = userName;
    user.uid = userCredentials!.uid;
    user.phoneNumber = userCredentials.phoneNumber;
    user.lastLoggedAsUser = true;
    user.createdDate = Timestamp.now();
    user.lastOpenDate = Timestamp.now();
    FirebaseFirestore.instance
        .collection("straightWayUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson());
    updateToken();
  }

  Future addUserServiceProvider(
      String userName, ServiceProviderModel serviceProvider) async {
    UserModel user = UserModel();
    User? userCredentials = FirebaseAuth.instance.currentUser;
    user.userName = userName;
    user.uid = userCredentials!.uid;
    user.phoneNumber = userCredentials.phoneNumber;
    user.createdDate = Timestamp.now();
    user.lastOpenDate = Timestamp.now();
    user.isServiceProvider = true;
    user.lastLoggedAsUser = false;
    user.isServiceProviderRegistered = true;
    user.serviceProviderDetails = serviceProvider;
    await FirebaseFirestore.instance
        .collection("straightWayUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson());
    updateToken();
  }

  updateUser([bool? isServiceProvider]) {
    FirebaseFirestore.instance
        .collection("straightWayUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'lastOpenDate': Timestamp.now(),
      'lastLoggedAsUser': isServiceProvider == true ? false : true
    }, SetOptions(merge: true));
  }

  Future addBusiness(business) async {
    try {
      await FirebaseFirestore.instance
          .collection("Businesses")
          .doc(business["uid"])
          .set(business);
      await FirebaseFirestore.instance
          .collection("Businesses")
          .doc(business["uid"])
          .update({"isApproved": false});
    } catch (e) {
      print(e);
    }
  }

  Future addBusinessSlot(
      AddedServiceModelList addedServiceModelList, String uid) async {
    await FirebaseFirestore.instance.collection("Businesses").doc(uid).set({
      'addedServices': FieldValue.arrayUnion([addedServiceModelList.toJson()])
    }, SetOptions(merge: true));
  }

  Future uploadDocument(
      Rx<File> document, String type, String businessUID) async {
    return await FirebaseFirestore.instance
        .collection("straightWayUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        Reference reference = FirebaseStorage.instance
            .ref()
            .child("/business/$businessUID/$type");
        UploadTask uploadTask = reference.putFile(document.value);
        TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
        String url = (await downloadUrl.ref.getDownloadURL());
        value.reference.set({
          'serviceProviderDetails': {type: url}
        }, SetOptions(merge: true));
      }
    });
  }

  Future uploadBusinessPhoto(
      Rx<File> document, String type, String businessUID) async {
    return await FirebaseFirestore.instance
        .collection("Businesses")
        .doc(businessUID)
        .get()
        .then((value) async {
      if (value.exists) {
        Reference reference = FirebaseStorage.instance
            .ref()
            .child("/business/$businessUID/businessImage");
        UploadTask uploadTask = reference.putFile(document.value);
        TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
        String url = (await downloadUrl.ref.getDownloadURL());
        value.reference.set({'businessImage': url}, SetOptions(merge: true));
      }
    });
  }

  Future uploadServiceImages(
      RxList<File> documents, String type, String businessUID) async {
    return await FirebaseFirestore.instance
        .collection("Businesses")
        .doc(businessUID)
        .get()
        .then((value) async {
      if (value.exists) {
        for (int i = 0; i < documents.length; i++) {
          Reference reference = FirebaseStorage.instance
              .ref()
              .child("/business/$businessUID/serviceImages/serviceImage$i");
          UploadTask uploadTask = reference.putFile(documents[i]);
          TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
          String url = (await downloadUrl.ref.getDownloadURL());
          value.reference.set({
            'serviceImages': FieldValue.arrayUnion([url])
          }, SetOptions(merge: true));
        }
      }
    });
  }
}
