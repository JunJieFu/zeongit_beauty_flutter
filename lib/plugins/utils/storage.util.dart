import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///SharedPreferences 本地存储
class StorageManager {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    sharedPreferences.setString(key, value);
  }

  static setInt(String key, int value) {
    sharedPreferences.setInt(key, value);
  }

  static setBool(String key, bool value) {
    sharedPreferences.setBool(key, value);
  }

  static setJson(String key, Map<String, dynamic> value) {
    sharedPreferences.setString(key, json.encode(value));
  }

  static T get<T>(String key) {
    return sharedPreferences.get(key) as T;
  }

  static getJson(String key) {
    var value = sharedPreferences.get(key);
    return value != null ? json.decode(value) : null;
  }

  static remove(String key) {
    sharedPreferences.remove(key);
  }
}
