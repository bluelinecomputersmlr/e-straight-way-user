import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:get/get.dart';

class BusinessServices extends GetConnect {
  Stream<List<BusinessModel>?> getBusiness(
      String id, String? subCategoryType) async* {
    try {
      yield* FirebaseFirestore.instance
          .collection("Businesses")
          .where('subCategoryUID', isEqualTo: id)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => BusinessModel.fromJson(doc.data()))
                .toList(),
          );
    } catch (e) {
      yield null;
    }
  }
}
