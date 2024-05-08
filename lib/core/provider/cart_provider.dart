import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/core/api_config.dart';
import 'package:shop_app/core/models/Cart.dart';
import 'package:http/http.dart' as http;
import 'auth_provider.dart';

class CartProvider extends ChangeNotifier {
  static const String cart = "cart";
  static const String cartEndPoint = ApiConfig.baseApiUrl + cart;

  Future<Cart> getCart() async {
    var url = Uri.parse(cartEndPoint);
    print(url);
    try {
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "token": AuthProvider.userToken.toString()
      });
      var retrivedData = json.decode(response.body);
      var data = retrivedData["cart"];
      Cart cartData = Cart.fromJson(data);
      return cartData;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void addToCart(String id, int quantity) async {
    var url = Uri.parse(cartEndPoint);
    print(url);
    try {
      var response = await http.post(
        url,
        body: jsonEncode(<String, String>{
          'product': id,
        }),
        headers: {
          "Content-Type": "application/json",
          "token": AuthProvider.userToken.toString()
        },
      );
      var retrivedData = json.decode(response.body);
      print(retrivedData);
      Fluttertoast.showToast(
          msg: 'Product added to cart.', backgroundColor: Colors.green);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<int> getCartLength() async {
    var url = Uri.parse(cartEndPoint);
    print(url);
    try {
      var response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "token": AuthProvider.userToken.toString()
      });
      var retrivedData = json.decode(response.body);
      var data = retrivedData["cartItems"];
      int length = data;
      return length;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void removeCartItem(String id) async {
    var url = Uri.parse("$cartEndPoint/$id");
    print(url);
    try {
      var response = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "token": AuthProvider.userToken.toString()
      });
      var retrivedData = json.decode(response.body);
      print("response : $retrivedData");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void updateItemQuantity(String id, int quantity) async {
    var url = Uri.parse("$cartEndPoint/$id");
    print(url);
    try {
      var response = await http.put(
        url,
        body: jsonEncode(<String, String>{
          'quantity': quantity.toString(),
        }),
        headers: {
          "Content-Type": "application/json",
          "token": AuthProvider.userToken.toString()
        },
      );
      var retrivedData = json.decode(response.body);
      print("response : $retrivedData");
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
