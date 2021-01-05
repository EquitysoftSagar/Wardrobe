import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class SaveValue {
  SaveValue._();

  static Future<void> string(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
  static Future<void> integer(String key, int value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }
  static Future<void> boolean(String key, bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }
  static Future<void> doubleLong(String key, double value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble(key, value);
  }
}

class GetValue {
  GetValue._();

  static Future<String> string(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }
  static Future<int> integer(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }
  static Future<bool> boolean(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }
  static Future<double> doubleLong(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getDouble(key);
  }
}
class Value{
  Value._();

  static Future<bool> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
class Keys{

  Keys._();

  static String user = "user";
  static String token = "token";
  static String isLogin = "isLogin";
}
