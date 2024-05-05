// To parse this JSON data, do
//
//     final subCategory = subCategoryFromJson(jsonString);

import 'dart:convert';

List<SubCategory> subCategoryFromJson(String str) => List<SubCategory>.from(
    json.decode(str).map((x) => SubCategory.fromJson(x)));

String subCategoryToJson(List<SubCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategory {
  String? id;
  String? name;
  String? slug;
  SubCategory? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? categoryId;
  String? image;

  SubCategory({
    this.id,
    this.name,
    this.slug,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.categoryId,
    this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        category: json["category"] == null
            ? null
            : SubCategory.fromJson(json["category"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        categoryId: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "category": category?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": categoryId,
        "image": image,
      };
}
