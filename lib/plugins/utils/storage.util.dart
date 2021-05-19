import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///SharedPreferences 本地存储
class StorageManager {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    sharedPreferences!.setString(key, value);
  }

  static setInt(String key, int value) {
    sharedPreferences!.setInt(key, value);
  }

  static setBool(String key, bool value) {
    sharedPreferences!.setBool(key, value);
  }

  static setJson(String key, Map<String, dynamic> value) {
    sharedPreferences!.setString(key, json.encode(value));
  }

  static setStringList(String key, List<String> value) {
    sharedPreferences!.setStringList(key, value);
  }

  static T get<T>(String key) {
    return sharedPreferences!.get(key) as T;
  }

  static List<String>? getStringList(String key) {
    return sharedPreferences!.getStringList(key);
  }

  static bool? getBool(String key) {
    return sharedPreferences!.getBool(key);
  }

  static String? getString(String key) {
    return sharedPreferences!.getString(key);
  }



  static getJson(String key) {
    var value = sharedPreferences!.get(key);
    return value != null ? json.decode(value as String) : null;
  }

  static remove(String key) {
    sharedPreferences!.remove(key);
  }
}
