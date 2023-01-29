import 'dart:io';

import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:estraightwayapp/service/home/profile_page_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePageController extends GetxController {
  var isLoading = false.obs;
  Rx<UserModel> userData = UserModel().obs;
  var isError = false.obs;
  var errorMessage = "".obs;

  File? profilePhoto;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void getUserData() async {
    isLoading(true);
    var response = await HomePageService().getUserData();
    if (response["status"] == "success") {
      userData.value = UserModel.fromJson(response["user"]);
      userData.update((val) {});
      isLoading(false);
      isLoading.update((val) {});
    } else {
      notifyChildrens();
    }
    isLoading(false);
  }

  getFromGalleryProfile() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      profilePhoto = File(pickedFile.path);
      await updateProfilePhoto(profilePhoto);
      notifyChildrens();
    }
  }

  /// Get from Camera
  getFromCameraProfile() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      profilePhoto = File(pickedFile.path);
      await updateProfilePhoto(profilePhoto);
      notifyChildrens();
    }
  }

  updateProfilePhoto(profilePhoto) async {
    isLoading(true);
    var result = await ProfilePageService().uploadProfilePhoto(profilePhoto);
    getUserData();
  }

  Future logoutUser() async {
    var result = await ProfilePageService().logoutUser();
    print(result);
  }
}
