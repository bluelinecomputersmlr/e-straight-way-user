import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentConfirmService {
  Future<Map> updateServiceProviderPaymentStatus(
      Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

      var res = await FirebaseFirestore.instance
          .collection("Businesses")
          .where('userUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        for (var element in value.docs) {
          await FirebaseFirestore.instance
              .collection("Businesses")
              .doc(element.id)
              .update({'isInitialPaymentDone': true});
        }
      });

      return {"status": "success"};
    } catch (e) {
      print(e);
      return {"status": "error"};
    }
  }
}
