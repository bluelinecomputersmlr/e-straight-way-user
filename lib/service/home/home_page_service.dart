import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:estraightwayapp/main.dart';
import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomePageService extends GetConnect {
  Future<Map> getUserData() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("straightWayUsers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (response.data() != null) {
        return {"status": "success", "user": response.data()};
      } else {
        return {
          "status": "error",
          "message": "Some error occurred",
          "phone": FirebaseAuth.instance.currentUser!.phoneNumber
        };
      }
    } catch (e) {
      return {"status": "error", "message": "Some error occurred"};
    }
  }

  Future<Map> getAreaData() async {
    try {
      var response = await FirebaseFirestore.instance.collection("Areas").get();

      var data = response.docs.toList();

      var responseData = [];

      for (var doc in data) {
        responseData.add(doc.data());
      }
      return {"status": "success", "data": responseData};
    } catch (e) {
      return {"status": "error", "message": "Some error occurred"};
    }
  }

  Future<List<String>> getBanners() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("banners")
          .doc('banners')
          .get();
      if (response.data() != null) {
        return List.from(response.get('bannerUrls'));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("Categories")
          .doc('categories')
          .get();
      if (response.data() != null) {
        return List.from(response.get('categories'))
            .map((e) => CategoryModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<SubCategoryModel>> getSubCategories() async {
    try {
      var response =
          await FirebaseFirestore.instance.collection("subCategories").get();
      if (response.docs.isNotEmpty) {
        return response.docs
            .map((e) => SubCategoryModel.fromJson(e.data()))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
  // Future<Map> getCourseData(String id, int page, int limit) async {
  //   var jwt = box.read('jwt');
  //
  //   try {
  //     var response = await get(
  //         '$kBaseUrl/student/courses/categoryCourse?categoryId=$id&page=$page&limit=$limit',
  //         headers: {"auth-token": jwt});
  //
  //     if (response.statusCode == 200) {
  //       return {"status": "success", "courses": response.body};
  //     } else {
  //       return {"status": "success", "message": response.body["message"]};
  //     }
  //   } catch (e) {
  //     print(e);
  //     return {"status": "error", "message": "Some error occured"};
  //   }
  // }
}
