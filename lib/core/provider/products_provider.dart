import 'dart:convert';
import 'package:shop_app/core/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/core/provider/auth_provider.dart';
import '../models/product.dart';

class ProductsProvider {
  static const String products = "product";
  static const String productsEndPoint = ApiConfig.baseApiUrl + products;
  static const String subCatProduct = "subCategory";
  static const String subCatProductEndPoint =
      ApiConfig.baseApiUrl + subCatProduct;
  static const String wishlist = "wishlist";
  static const String wishlistEndPoint = ApiConfig.baseApiUrl + wishlist;

  Future<List<Product>> getProducts() async {
    var url = Uri.parse(productsEndPoint);
    print(url);

    try {
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      var retrivedData = json.decode(response.body);
      List data = retrivedData['product'];
      return data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Product>> getSubCatProducts(String id) async {
    var url = Uri.parse("$subCatProductEndPoint/$id");
    print(url);
    try {
      var response =
          await http.get(url, headers: {"Content-Type": "application/json"});
      var retrivedData = json.decode(response.body);
      List data = retrivedData['subcategory']['AllProduct'];
      return data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Product>> getWishlest() async {
    var url = Uri.parse(wishlistEndPoint);
    print(url);
    try {
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "token": AuthProvider.userToken.toString()
      });
      var retrivedData = json.decode(response.body);
      print(retrivedData);
      List data = retrivedData['wishlist'];
      return data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
