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

      return {"status": "success"};
    } catch (e) {
      print(e);
      return {"status": "error"};
    }
  }
}
