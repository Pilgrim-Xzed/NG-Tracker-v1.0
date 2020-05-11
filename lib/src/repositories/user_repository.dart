import 'dart:convert';

import 'package:kdresponse/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
User currentUser = new User();

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.clear();
  if (prefs.containsKey('current_user')) {
    currentUser = User.fromJson(json.decode(await prefs.get('current_user')));
  }
  return currentUser;
}


  void setUserData(jsonString) async {
    if (json.decode(jsonString) != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'current_user', json.encode(json.decode(jsonString)));
    }
  }

