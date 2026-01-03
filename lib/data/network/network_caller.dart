import 'dart:convert';
import 'package:car_hub/data/network/network_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkCaller {
  /// ==============================Get Request=======================================

  static Future<NetworkResponse> getRequest({
    required String url,
    String? token,
  }) async {
    Uri uri = Uri.parse(url);
    try {
      Response response = await get(
        uri,
        headers: {"Content-TYpe": "application/json", "token": token ?? ""},
      );
      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          success: true,
          message: "data getting success",
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          success: false,
          message: "something went wrong ${response.body}",
        );
      }
    } catch (e) {
      debugPrint("Data getting failed $e");
      return NetworkResponse(
        statusCode: null,
        success: false,
        message: "data getting failed $e",
      );
    }
  }

  /// ==============================Post Request=======================================

  static Future<NetworkResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    Uri uri = Uri.parse(url);

    try {
      Response response = await post(
        uri,
        headers: {"Content-Type": "application/json", "token": token ?? ""},
        body: jsonEncode(body),
      );
      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          success: true,
          message: decodedData["message"],
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          success: false,
          message: decodedData["message"],
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: null,
        success: false,
        message: "Something wrong $e",
      );
    }
  }

  /// ==============================Put Request=======================================

  static Future<NetworkResponse> putRequest({
    required String url,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    Uri uri = Uri.parse(url);

    try {
      Response response = await put(
        uri,
        headers: {"Content-Type": "application/json", "token": token ?? ""},
        body: jsonEncode(body),
      );

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          success: true,
          message: decodedData["message"],
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          success: false,
          message: decodedData["message"] ?? "Something went wrong",
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: null,
        success: false,
        message: "Something wrong $e",
      );
    }
  }

  /// ==============================Delete Request=======================================

  static Future<NetworkResponse> deleteRequest({
    required String url,
    String? token,
  }) async {
    Uri uri = Uri.parse(url);
    try {
      Response response = await delete(
        uri,
        headers: {"Content-Type": "application/json", "token": token ?? ""},
      );

      final decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          statusCode: response.statusCode,
          success: true,
          message: decodedData["message"],
          body: decodedData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          success: false,
          message: decodedData["message"],
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: null,
        success: false,
        message: "Something wrong",
      );
    }
  }
}
