// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  double? price;
  int? proceAfterDiscount;
  int? rateCount;
  int? quantity;
  String? catigory;
  Category? subCategory;
  String? brand;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? productId;

  Product({
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
    this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        subCategory: json["subCategory"] == null
            ? null
            : Category.fromJson(json["subCategory"]),
        brand: json["brand"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        productId: json["id"],
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
        "subCategory": subCategory?.toJson(),
        "brand": brand,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": productId,
      };
}

class Category {
  String? id;
  String? name;
  String? slug;
  Category? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? categoryId;
  String? image;

  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
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

List<Product> demoProducts = [
  Product(
    id: "1",
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Wireless Controller for PS4™",
    price: 64,
    description: "description",
  ),
  Product(
    id: "2",
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    title: "Nike Sport White - Man Pant",
    price: 50,
    description: "description",
  ),
  Product(
    id: "3",
    images: [
      "assets/images/glap.png",
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36,
    description: "description",
  ),
  Product(
    id: "4",
    images: [
      "assets/images/wireless headset.png",
    ],
    title: "Logitech Head",
    price: 20,
  ),
  Product(
    id: "1",
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    title: "Wireless Controller for PS4™",
    price: 64,
    description: "description",
  ),
  Product(
    id: "2",
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    title: "Nike Sport White - Man Pant",
    price: 50,
    description: "description",
  ),
  Product(
    id: "3",
    images: [
      "assets/images/glap.png",
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36,
    description: "description",
  ),
  Product(
    id: "4",
    images: [
      "assets/images/wireless headset.png",
    ],
    title: "Logitech Head",
    price: 20,
    description: "description",
  ),
];
