import 'package:carousel_slider/carousel_slider.dart';
import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/model/single_course_model.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  Rx<UserModel> userData = UserModel().obs;
  var isMainPageLoading = false.obs;
  final CarouselController carouselController = CarouselController();
  var currentIndex = 0;
  var isMainError = false.obs;
  List<String>? banners = [];
  var mainErrorMessage = "".obs;

  RxList categories = [].obs;

  @override
  void onInit() {
    getUserData();
    getBanners();
    getCategories();
    notifyChildrens();
    super.onInit();
  }

  void getUserData() async {
    isMainPageLoading(true);
    var response = await HomePageService().getUserData();
    if (response["status"] == "success") {
      userData.value = UserModel.fromJson(response["user"]);
    } else {
      isMainError(true);
      mainErrorMessage.value = response["message"];
    }
    isMainPageLoading(false);
  }

  void updateIndex(index) {
    currentIndex = index;
    notifyChildrens();
  }

  void getBanners() async {
    banners = await HomePageService().getBanners().whenComplete(() {
      notifyChildrens();
    });
  }

  void getCategories() async {
    isMainPageLoading(true);
    categories.value = await HomePageService().getCategories().whenComplete(() {
      categories.obs.update((val) {});
    });
    isMainPageLoading(false);
  }
}
