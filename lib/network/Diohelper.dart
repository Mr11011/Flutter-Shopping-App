import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData(
      {@required url,
      Map<String, dynamic>? query,
      String lang = 'en',
      dynamic? token}) async {
    dio.options.headers = {
      "lang": lang,
      "Content-Type": "application/json",
      "Authorization": token ?? 'Empty Token'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {@required url,
      required Map<String, dynamic>? data,
      Map<String, dynamic>? query,
      String lang = 'en',
      dynamic? token}) async {
    dio.options.headers = {
      "lang": lang,
      "Content-Type": "application/json",
      "Authorization": token
    };

    return dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {@required url,
      required Map<String, dynamic>? data,
      Map<String, dynamic>? query,
      String lang = 'en',
      dynamic? token}) async {
    dio.options.headers = {
      "lang": lang,
      "Content-Type": "application/json",
      "Authorization": token
    };

    return dio.put(url, queryParameters: query, data: data);
  }

  static SharedPreferences? sharedPreferences;
}
