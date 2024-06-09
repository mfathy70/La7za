import 'dart:convert';
import 'package:shop_app/core/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/core/models/ai_product.dart';

class AiModelProvider {
  static const String aiModelUrl = ApiConfig.aiModelUrl;
  static final List<AiProduct> _recommendations = [];
  static List<AiProduct> get recommendations => _recommendations;

  static setRecommendations(List<AiProduct>? val) {
    _recommendations.addAll(val!);
  }

  Future<List<AiProduct>> sendToAi(String product) async {
    var url = Uri.parse(aiModelUrl);
    print(url);
    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          'name': product,
        }),
      );
      var retrivedData = json.decode(response.body);
      List data = retrivedData;
      print(data);
      setRecommendations(data.map((e) => AiProduct.fromJson(e)).toList());
      print(_recommendations);
      return data.map((e) => AiProduct.fromJson(e)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
