import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estraightwayapp/model/business_model.dart';
import 'package:estraightwayapp/model/categories_model.dart';
import 'package:estraightwayapp/model/single_course_model.dart';
import 'package:estraightwayapp/model/sub_category_model.dart';
import 'package:estraightwayapp/model/user_model.dart';
import 'package:estraightwayapp/service/auth/login_service.dart';
import 'package:estraightwayapp/service/home/home_page_service.dart';
import 'package:estraightwayapp/service/home/sub_category_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SignUpServiceProviderController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<UserModel> userData = UserModel().obs;
  final CarouselController carouselController = CarouselController();
  var isMainPageLoading = false.obs;
  var isMainError = false.obs;
  var mainErrorMessage = "".obs;
  int i = 0;
  RxList categories = [].obs;
  final userNameController = TextEditingController();
  final categoryController = TextEditingController();
  CategoryModel? category;
  SubCategoryModel? subCategory;
  BusinessModel? business;
  final subCategoryController = TextEditingController();

  final businessNameConroller = TextEditingController();

  final businessPhoneController = TextEditingController();

  final serviceChargeController = TextEditingController();

  final experienceController = TextEditingController();

  Rx<File> profilePhoto = File('').obs;
  Rx<File> aadharPhoto = File('').obs;
  Rx<File> vehicleRegistrationPhoto = File('').obs;
  Rx<File> licencePhoto = File('').obs;
  var serviceImages = <File>[].obs;

  final addressController = TextEditingController();

  final bankAccountNumberController = TextEditingController();

  final ifscCodeController = TextEditingController();

  final upiIdController = TextEditingController();

  final vehiceRegistrationController = TextEditingController();

  var currentIndex = 0.obs;

  var isGstRegistered = "".obs;

  var areas = [].obs;

  var choosenArea = "Select Area".obs;

  var businessDescriptionConroller = TextEditingController();
  var addedServiceModel = <AddedServiceModel>[AddedServiceModel()].obs;
  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void updateIndex(index) {
    currentIndex.value = index;
    currentIndex.update((val) {});
    notifyChildrens();
  }

  void setGstRegistered(String value) {
    isGstRegistered(value);
  }

  void getUserData() async {
    isMainPageLoading(true);
    var response = await HomePageService().getUserData();
    if (response["status"] == "success") {
      userData.value = UserModel.fromJson(response["user"]);
      userNameController.text = userData.value.userName!;
      businessPhoneController.text = userData.value.phoneNumber!;
    } else {
      businessPhoneController.text = response["phone"];
      mainErrorMessage.value = response["message"];
    }

    var areaData = await HomePageService().getAreaData();

    if (areaData["status"] == "success") {
      var responseData = areaData["data"];

      areas.insert(0, "Select Area");
      for (var data in responseData) {
        areas.add(data["areaName"]);
      }
    } else {
      businessPhoneController.text = response["phone"];
      mainErrorMessage.value = response["message"];
    }

    isMainPageLoading(false);
  }

  void selectArea(String value) {
    choosenArea.value = value;
  }

  Future<List<CategoryModel>> getCategories() async {
    isMainPageLoading(true);
    isMainError(false);
    // REQUESTING FOR DATA
    List<CategoryModel>? response = await HomePageService().getCategories();
    // VERIFYING RESPONSE
    if (response != null) {
      isMainPageLoading(false);
      return response;
    } else {
      isMainError(true);
    }
    isMainPageLoading(false);
    isMainPageLoading.obs.update((val) {});
    return [];
  }

  Future<List<SubCategoryModel>> getSubCategory() async {
    isMainPageLoading(true);
    // REQUESTING FOR DATA
    List<SubCategoryModel>? response =
        await SubCategoryServices().getSubCategory(category!.uid!);

    // VERIFYING RESPONSE
    if (response != null) {
      isMainPageLoading(false);
      return response;
    } else {
      isMainError(true);
    }
    isMainPageLoading(false);
    return [];
  }

  getFromGalleryProfile(Rx<File> picture) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      picture.value = File(pickedFile.path);
      picture.obs.update((val) {});
    }
  }

  /// Get from Camera
  getFromCameraProfile(Rx<File> picture) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      picture.value = File(pickedFile.path);
      picture.obs.update((val) {});
      notifyChildrens();
    }
  }

  getFromGalleryServiceImage() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      serviceImages.add(File(pickedFile.path));
      currentIndex.obs.update((val) {});
    }
  }

  /// Get from Camera
  getFromCameraServiceImage() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      serviceImages.add(File(pickedFile.path));
      currentIndex.obs.update((val) {});
      notifyChildrens();
    }
  }

  Future submitFormDirectBooking() async {
    isMainPageLoading(true);
    var businessUID = const Uuid().v4().trimRight();
    business = BusinessModel(
      uid: businessUID,
      address: addressController.text,
      businessName: businessNameConroller.text,
      categoryUID: category!.uid,
      subCategoryUID: subCategory!.uid,
      serviceCharge: double.parse(serviceChargeController.text),
      phoneNumber: businessPhoneController.text,
      creationTime: Timestamp.now(),
      subCategoryType: subCategory!.subCategoryType,
      experience: experienceController.text,
    );
    ServiceProviderModel serviceProvider = ServiceProviderModel(
      serviceProviderCategory: category!.name,
      serviceProviderCategoryUID: category!.uid,
      serviceProviderSubCategory: subCategory!.subCategoryName,
      serviceProviderSubCategoryUID: subCategory!.uid,
      businessUID: businessUID,
      businessType: subCategory!.subCategoryType,
      userAddress: addressController.text,
      bankAccountName: bankAccountNumberController.text,
      ifscCode: ifscCodeController.text,
      bankName: '',
    );
    var businessJSON = business!.toJson();
    businessJSON["area"] = choosenArea.value;
    await LoginService()
        .addUserServiceProvider(userNameController.text, serviceProvider);
    await LoginService().addBusiness(businessJSON).whenComplete(() async {
      await LoginService()
          .uploadDocument(aadharPhoto, 'aadharDocument', businessUID);
      await LoginService()
          .uploadBusinessPhoto(profilePhoto, 'businessImage', businessUID);
    });

    isMainPageLoading(false);
    return true;
  }

  Future submitFormMapBasedBooking() async {
    isMainPageLoading(true);
    var businessUID = const Uuid().v4().trimRight();
    business = BusinessModel(
        uid: businessUID,
        address: addressController.text,
        businessName: businessNameConroller.text,
        categoryUID: category!.uid,
        subCategoryUID: subCategory!.uid,
        serviceCharge: double.parse(serviceChargeController.text),
        phoneNumber: businessPhoneController.text,
        creationTime: Timestamp.now(),
        subCategoryType: subCategory!.subCategoryType,
        experience: experienceController.text,
        vehicleRegistrationNo: vehiceRegistrationController.text);
    ServiceProviderModel serviceProvider = ServiceProviderModel(
      serviceProviderCategory: category!.name,
      serviceProviderCategoryUID: category!.uid,
      serviceProviderSubCategory: subCategory!.subCategoryName,
      serviceProviderSubCategoryUID: subCategory!.uid,
      businessUID: businessUID,
      businessType: subCategory!.subCategoryType,
      userAddress: addressController.text,
      bankAccountName: bankAccountNumberController.text,
      ifscCode: ifscCodeController.text,
      bankName: '',
    );
    var businessJSON = business!.toJson();
    businessJSON["area"] = choosenArea.value;
    await LoginService()
        .addUserServiceProvider(userNameController.text, serviceProvider);
    await LoginService().addBusiness(businessJSON).whenComplete(() async {
      await LoginService()
          .uploadDocument(aadharPhoto, 'aadharDocument', businessUID);
      await LoginService()
          .uploadBusinessPhoto(profilePhoto, 'businessImage', businessUID);
      await LoginService()
          .uploadDocument(licencePhoto, 'drivingLicenceDocument', businessUID);
      await LoginService().uploadDocument(
          vehicleRegistrationPhoto, 'vehicleRegistrationDocument', businessUID);
    });
    isMainPageLoading(false);
    return true;
  }

  Future submitFormSlotBasedBooking() async {
    isMainPageLoading(true);
    var businessUID = const Uuid().v4().trimRight();
    List<Map<String, dynamic>>? list = [];
    addedServiceModel.forEach((element) {
      list.add(element.toJson());
    });

    business = BusinessModel(
        uid: businessUID,
        address: addressController.text,
        businessName: businessNameConroller.text,
        categoryUID: category!.uid,
        subCategoryUID: subCategory!.uid,
        description: businessDescriptionConroller.text,
        phoneNumber: businessPhoneController.text,
        creationTime: Timestamp.now(),
        subCategoryType: subCategory!.subCategoryType,
        addedServices: list);
    ServiceProviderModel serviceProvider = ServiceProviderModel(
      serviceProviderCategory: category!.name,
      serviceProviderCategoryUID: category!.uid,
      serviceProviderSubCategory: subCategory!.subCategoryName,
      serviceProviderSubCategoryUID: subCategory!.uid,
      businessUID: businessUID,
      businessType: subCategory!.subCategoryType,
      userAddress: addressController.text,
      bankAccountName: bankAccountNumberController.text,
      ifscCode: ifscCodeController.text,
      bankName: '',
    );
    var businessJSON = business!.toJson();
    businessJSON["gstRegisteredStatus"] = isGstRegistered.value;
    businessJSON["area"] = choosenArea.value;
    await LoginService()
        .addUserServiceProvider(userNameController.text, serviceProvider);
    await LoginService().addBusiness(businessJSON).whenComplete(() async {
      await LoginService()
          .uploadDocument(aadharPhoto, 'aadharDocument', businessUID);
      await LoginService().uploadBusinessPhoto(
          serviceImages[0].absolute.obs, 'businessImage', businessUID);
      await LoginService()
          .uploadServiceImages(serviceImages, 'serviceImage', businessUID);
    });

    isMainPageLoading(false);
    return true;
  }

  void addNewService() {
    addedServiceModel.add(AddedServiceModel());
  }

  void removeNewService(service) {
    if (addedServiceModel.length > 1) {
      addedServiceModel.remove(service);
    }
  }
}
