import 'package:json_annotation/json_annotation.dart';

part 'sub_category_model.g.dart';

@JsonSerializable()
class SubCategoryModel {
  String? uid;
  String? subCategoryName;
  String? subCategoryImage;
  String? categoryUID;
  String? categoryName;
  String? subCategoryType;

  SubCategoryModel({
    this.uid,
    this.subCategoryName,
    this.subCategoryImage,
    this.categoryUID,
    this.categoryName,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryModelToJson(this);
}
