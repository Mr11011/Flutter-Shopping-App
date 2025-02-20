import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key, // Change String? to String
    required bool value, // Change bool? to bool
  }) async {
    return await sharedPreferences?.setBool(key, value) ??
        false; // Ensure sharedPreferences is not null
  }

  static dynamic getData({required String key}) {
    return sharedPreferences?.get(key) ?? false;
  }

  static Future<bool> saveData({required String key, required value}) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> removeData({required key}) async {
    return await sharedPreferences!.remove(key);
  }
}
