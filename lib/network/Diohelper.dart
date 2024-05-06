import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class dioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: {"Content-Type": "application/json"}));
  }

  static Future<Response> getData(
      {@required url, @required Map<String, dynamic>? query}) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({@required url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token}) async {
    dio.options.headers = {"lang": lang, "Authorization": token};


    return dio.post(url, queryParameters: query, data: data);
  }
}
