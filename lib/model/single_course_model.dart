class SingleCourse {
  String? sId;
  String? name;
  String? description;
  String? thumbnailUrl;
  String? insideThumbnailUrl;
  String? videoUrl;
  Category? category;
  String? createdDate;
  int? iV;
  String? id;

  SingleCourse(
      {this.sId,
      this.name,
      this.description,
      this.thumbnailUrl,
      this.insideThumbnailUrl,
      this.videoUrl,
      this.category,
      this.createdDate,
      this.iV,
      this.id});

  SingleCourse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    thumbnailUrl = json['thumbnailUrl'];
    insideThumbnailUrl = json['insideThumbnailUrl'];
    videoUrl = json['videoUrl'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    createdDate = json['createdDate'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['thumbnailUrl'] = thumbnailUrl;
    data['insideThumbnailUrl'] = insideThumbnailUrl;
    data['videoUrl'] = videoUrl;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['createdDate'] = createdDate;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? description;
  String? id;

  Category({this.sId, this.name, this.description, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['id'] = id;
    return data;
  }
}
