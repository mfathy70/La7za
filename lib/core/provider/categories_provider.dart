import 'dart:convert';
import 'package:shop_app/core/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/core/models/category.dart';
import 'package:shop_app/core/models/sub_category.dart';

class CategoriesProvider {
  static const String categoires = "categories";
  static const String categoriesEndPoint = ApiConfig.baseApiUrl + categoires;
  static const String subCategory = "subCategory";

  Future<List<Category>> getCategories() async {
    var url = Uri.parse(categoriesEndPoint);
    print(url);
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var retrivedData = json.decode(response.body);
    List data = retrivedData['categories'];
    return data.map((e) => Category.fromJson(e)).toList();
  }

  Future<List<Category>> getSingleCategorie() async {
    var url = Uri.parse(categoriesEndPoint);
    print(url);
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var retrivedData = json.decode(response.body);
    List data = retrivedData['categories'];
    return data.map((e) => Category.fromJson(e)).toList();
  }

  Future<List<SubCategory>> getSubCategory(String catId) async {
    var url = Uri.parse("$categoriesEndPoint/$catId/$subCategory");
    print(url);
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var retrivedData = json.decode(response.body);
    List data = retrivedData['subcategories'];
    return data.map((e) => SubCategory.fromJson(e)).toList();
  }
}
