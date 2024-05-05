import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_config.dart';

class LoginDataProvider {
  static const String login = "auth/signin";
  static const String signUp = "auth/signup";
  static const String loginEndPoint = ApiConfig.baseApiUrl + login;
  static const String registerEndPoint = ApiConfig.baseApiUrl + signUp;

  Future<http.Response> loginWithEmail(
      {required String email, required String password}) async {
    print(email + ', ' + password);
    final uri = Uri.parse(loginEndPoint);
    print(uri);

    return http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }

  Future<http.Response> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse(registerEndPoint);
    print(uri);
    return http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'name': "$firstName $lastName",
        'password': password,
        'rePassword': password,
      }),
    );
  }
}
