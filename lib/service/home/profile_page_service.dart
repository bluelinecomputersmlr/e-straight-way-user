import 'package:cloud_firestore/cloud_firestore.dart';
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

  logoutUser() {
    return FirebaseAuth.instance.signOut();
  }
}
