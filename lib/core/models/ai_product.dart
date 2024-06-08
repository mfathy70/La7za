// To parse this JSON data, do
//
//     final aiProduct = aiProductFromJson(jsonString);

import 'dart:convert';

List<AiProduct> aiProductFromJson(String str) =>
    List<AiProduct>.from(json.decode(str).map((x) => AiProduct.fromJson(x)));

String aiProductToJson(List<AiProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AiProduct {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final double? price;
  final int? proceAfterDiscount;
  final int? rateCount;
  final int? quantity;
  final String? catigory;
  final String? subCategory;
  final String? brand;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final double? sold;

  AiProduct({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.proceAfterDiscount,
    this.rateCount,
    this.quantity,
    this.catigory,
    this.subCategory,
    this.brand,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.sold,
  });

  factory AiProduct.fromJson(Map<String, dynamic> json) => AiProduct(
        id: json["_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        imgCover: json["imgCover"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        price: json["price"]?.toDouble(),
        proceAfterDiscount: json["proceAfterDiscount"],
        rateCount: json["rateCount"],
        quantity: json["quantity"],
        catigory: json["catigory"],
        subCategory: json["subCategory"],
        brand: json["brand"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        sold: json["sold"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "slug": slug,
        "description": description,
        "imgCover": imgCover,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "price": price,
        "proceAfterDiscount": proceAfterDiscount,
        "rateCount": rateCount,
        "quantity": quantity,
        "catigory": catigory,
        "subCategory": subCategory,
        "brand": brand,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "sold": sold,
      };
}
