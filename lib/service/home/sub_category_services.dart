import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/main.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:get/get.dart';

class SubCategoryServices extends GetConnect {
  Future<List<SubCategoryModel>?> getSubCategory(String id) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("subCategories")
          .where('categoryUID', isEqualTo: id)
          .get();
      if (response.size > 0) {
        return response.docs
            .map((e) => SubCategoryModel.fromJson(e.data()))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
