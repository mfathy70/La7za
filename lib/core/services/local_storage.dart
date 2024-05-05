import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';
import '../provider/auth_provider.dart';

class LocalStorage {
  saveUserProfile({UserProfile? userProfile}) async {
    Map<String, dynamic> mappedProfileData = userProfile!.toJson();
    String encodedProfileData = jsonEncode(mappedProfileData);
    try {
      AuthProvider.setUserToken(userProfile.token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profileData', encodedProfileData);
    } catch (err) {
      print(
        'Unable to save Profile data'.toUpperCase() + err.toString(),
      );
    }
  }

  static Future<UserProfile?> loadUserProfileFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String? encodedProfileMap = prefs.getString('profileData');
      if (encodedProfileMap != null) {
        Map<String, dynamic> mappedProfile = jsonDecode(encodedProfileMap);
        UserProfile profile = UserProfile.fromJson(mappedProfile);
        AuthProvider.setUserToken(profile.token);
        print("token ${profile.token}");
        return profile;
      } else {
        return null;
      }
    } catch (err) {
      print(
        'Unable to load Profile data'.toUpperCase() + err.toString(),
      );
    }
  }

  static clearDataFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.clear();
      print("Profile data has been cleared");
    } catch (err) {
      print(
        'Unable to clear Profile data'.toUpperCase() + err.toString(),
      );
    }
  }
}
