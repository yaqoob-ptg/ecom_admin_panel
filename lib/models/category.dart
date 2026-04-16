import 'package:admin/utility/app_config.dart';

class Category {
  String? sId;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Category({this.sId, this.name, this.image, this.createdAt, this.updatedAt});

  String get fullUrl {
    if (image == null || image!.isEmpty) return '';

    // If already full Cloudinary URL → return as is
    if (image!.startsWith('http')) {
      return image!;
    }

    // Otherwise treat as backend relative path
    return '${AppConfig.baseUrl}$image';
  }

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
