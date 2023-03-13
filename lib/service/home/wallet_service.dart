import 'package:cloud_firestore/cloud_firestore.dart';

class WalletService {
  Future<Map> createTransactions(String id, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection("transactions").doc(id).set(
            data,
            SetOptions(merge: true),
          );

      return {
        "status": "success",
        "message": "Transaction created successfully"
      };
    } catch (e) {
      print(e);
      return {"status": "error", "message": "Unable to create transaction"};
    }
  }
}
