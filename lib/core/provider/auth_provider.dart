import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/provider/login_data_provider.dart';
import 'package:shop_app/core/services/local_storage.dart';
import 'package:shop_app/core/services/locator_services.dart';
import 'package:shop_app/core/services/navigation_service.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import '../models/user_profile.dart';

class AuthProvider extends ChangeNotifier {
  UserProfile? _userProfile;
  UserProfile? get getUserProfile => _userProfile;

  static String? _token;
  static String? get userToken => _token;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(val) {
    _loading = val;
    notifyListeners();
  }

  setUserProfile(UserProfile val) {
    _userProfile = val;
    notifyListeners();
  }

  static setUserToken(String? val) {
    _token = val;
  }

  LoginDataProvider authenticationServices = LoginDataProvider();

  void loginWithEmailAndPassword({String? email, String? password}) async {
    print("------------------");
    print(email);
    print(password);
    print("------------------");
    setLoading(true);
    try {
      var response = await authenticationServices.loginWithEmail(
          email: email!, password: password!);
      //print("response : ${response.body}");
      print("response : ${response.statusCode}");

      if (response.statusCode == 200) {
        final retrievedData = jsonDecode(response.body);
        print("Profile Retrived : $retrievedData");
        var profileData = retrievedData;
        UserProfile profile = UserProfile.fromJson(profileData);
        print(_userProfile);
        setUserProfile(profile);
        setUserToken(profile.token!);
        await LocalStorage().saveUserProfile(userProfile: profile);
        Fluttertoast.showToast(
          msg: "Welcome!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: kGreenColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setLoading(false);
        locator<NavigationService>().navigateTo(InitScreen.routeName);
      } else if (response.statusCode != 200) {
        setLoading(false);
        print("loading => " + loading.toString());
        final retrievedData = response.body;
        print("Profile Retrived : $retrievedData");
        Fluttertoast.showToast(
          msg: retrievedData,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        setLoading(false);
        final retrievedData = response.body;
        print("Profile Retrived : $retrievedData");
        Fluttertoast.showToast(
          msg: retrievedData,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("error from login $e");
      setLoading(false);
      Fluttertoast.showToast(
        msg: "ERROR OCCURRED",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: kSecondaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<int> register({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) async {
    print("------------------");
    print(firstName);
    print(lastName);
    print(email);
    print(password);
    print("------------------");
    setLoading(true);
    try {
      var response = await authenticationServices.register(
          email: email!,
          firstName: firstName!,
          lastName: lastName!,
          password: password!);
      print("response : ${response.body}");
      print("response : ${response.statusCode}");
      if (response.statusCode == 200) {
        final retrievedData = jsonDecode(response.body);
        print("Profile Retrived : $retrievedData");
        var profileData = retrievedData;
        UserProfile profile = UserProfile.fromJson(profileData);
        print(_userProfile);
        setUserProfile(profile);
        setUserToken(profile.token!);
        await LocalStorage().saveUserProfile(userProfile: profile);
        Fluttertoast.showToast(
          msg: "Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: kGreenColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setLoading(false);
        locator<NavigationService>().navigateTo(LoginSuccessScreen.routeName);
        return 1;
      } else if (response.statusCode == 400) {
        setLoading(false);
        print("loading => " + loading.toString());
        final retrievedData = response.body;
        print("Profile Retrived : $retrievedData");
        Fluttertoast.showToast(
          msg: retrievedData,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return 0;
      } else {
        setLoading(false);
        final retrievedData = response.body;
        print("Profile Retrived : $retrievedData");
        Fluttertoast.showToast(
          msg: retrievedData,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return 0;
      }
    } catch (e) {
      print("error from login $e");
      setLoading(false);
      Fluttertoast.showToast(
        msg: "ERROR OCCURRED",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: kSecondaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return 0;
    }
  }
}
