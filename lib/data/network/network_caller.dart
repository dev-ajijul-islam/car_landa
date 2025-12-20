import 'dart:convert';
import 'package:car_hub/data/network/network_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkCaller {
  /// ==============================Get Request=======================================

  static Future<NetworkResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url);
    try {
      Response response = await get(uri);
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

  static Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    Uri uri = Uri.parse(url);
    try {
      Response response = await post(
        uri,
        headers: {"Content-Type": "application/json"},
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
        message: "Something wrong",
      );
    }
  }
}
