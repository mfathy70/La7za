// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  String? id;
  String? user;
  List<CartItem>? cartItems;
  double? totalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Cart({
    this.id,
    this.user,
    this.cartItems,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["_id"],
        user: json["user"],
        cartItems: json["cartItems"] == null
            ? []
            : List<CartItem>.from(
                json["cartItems"]!.map((x) => CartItem.fromJson(x))),
        totalPrice: json["totalPrice"]?.toDouble(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "cartItems": cartItems == null
            ? []
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class CartItem {
  Product? product;
  int? quantity;
  double? price;
  String? id;

  CartItem({
    this.product,
    this.quantity,
    this.price,
    this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "quantity": quantity,
        "price": price,
        "_id": id,
      };
}

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
