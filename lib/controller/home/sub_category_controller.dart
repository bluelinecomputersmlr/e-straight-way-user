import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:estraightwayapp/service/home/sub_category_services.dart';
import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  var isLoading = false.obs;
  CategoryModel category = Get.arguments;
  var categoryUID = "".obs;
  var isError = false.obs;
  var errorMessage = "".obs;

  Future<List<SubCategoryModel>> getSubCategory() async {
    isLoading(true);
    var id = Get.parameters["categoryUID"];

    // JUST FOR BACKUP
    categoryUID.value = id.toString();

    // REQUESTING FOR DATA
    List<SubCategoryModel>? response =
        await SubCategoryServices().getSubCategory(categoryUID.value);

    // VERIFYING RESPONSE
    if (response != null) {
      return response;
    } else {
      isError(true);
    }
    isLoading(false);
    return [];
  }
}
