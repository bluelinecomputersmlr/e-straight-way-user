// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) =>
    SubCategoryModel(
      uid: json['uid'] as String?,
      subCategoryName: json['subCategoryName'] as String?,
      subCategoryImage: json['subCategoryImage'] as String?,
      categoryUID: json['categoryUID'] as String?,
      categoryName: json['categoryName'] as String?,
    )..subCategoryType = json['subCategoryType'] as String?;

Map<String, dynamic> _$SubCategoryModelToJson(SubCategoryModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'subCategoryName': instance.subCategoryName,
      'subCategoryImage': instance.subCategoryImage,
      'categoryUID': instance.categoryUID,
      'categoryName': instance.categoryName,
      'subCategoryType': instance.subCategoryType,
    };
