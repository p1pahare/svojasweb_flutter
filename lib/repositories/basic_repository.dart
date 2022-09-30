import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:svojasweb/models/api_response.dart';

import 'values.dart';

class BasicRepository {
  Future<ApiResponse> login(String? username, String? password) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(Values.base_url + Values.login),
          body: jsonEncode({'username': username, 'password': password}));

      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson({
          "status": true,
          "message": "Logged in Successfullys",
          "data": jsonDecode(body)
        });
      } else {
        String message = response.reasonPhrase ?? 'Something Went Wrong';
        log(message);
        return ApiResponse.fromJson({"status": false, "message": message});
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiResponse(
            status: false,
            message:
                "Network Problem Occurred. Kindly check your internet connection.");
      } else {
        return ApiResponse(status: false, message: e.toString());
      }
    }
  }

  Future<ApiResponse> getStatistics() async {
    try {
      final http.Response response =
          await http.get(Uri.parse(Values.base_url + Values.get_statistics));

      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson(
            {"status": true, "message": "", "data": jsonDecode(body)});
      } else {
        String message = response.reasonPhrase ?? 'Something Went Wrong';
        log(message);
        return ApiResponse.fromJson({"status": false, "message": message});
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiResponse(
            status: false,
            message:
                "Network Problem Occurred. Kindly check your internet connection.");
      } else {
        return ApiResponse(status: false, message: e.toString());
      }
    }
  }

  Future<ApiResponse> getDateAndReference() async {
    try {
      final http.Response response = await http
          .get(Uri.parse(Values.base_url + Values.get_date_and_reference));

      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson(
            {"status": true, "message": "", "data": jsonDecode(body)});
      } else {
        String message = response.reasonPhrase ?? 'Something Went Wrong';
        log(message);
        return ApiResponse.fromJson({"status": false, "message": message});
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiResponse(
            status: false,
            message:
                "Network Problem Occurred. Kindly check your internet connection.");
      } else {
        return ApiResponse(status: false, message: e.toString());
      }
    }
  }

  Future<ApiResponse> sendMail(
      {String? email, String? due, String? task}) async {
    try {
      final bytes = utf8.encode(due!);
      final base64Str = base64.encode(bytes);
      final body = jsonEncode({'email': email, 'due': base64Str, 'task': task});

      final http.Response response = await http.post(
          Uri.parse(Values.url_another),
          body: body,
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson(
            {"status": true, "message": "", "data": body});
      } else {
        String message = response.reasonPhrase ?? 'Something Went Wrong';
        log(message);
        return ApiResponse.fromJson({"status": false, "message": message});
      }
    } catch (e) {
      if (e is SocketException) {
        return ApiResponse(
            status: false,
            message:
                "Network Problem Occurred. Kindly check your internet connection.");
      } else {
        return ApiResponse(status: false, message: e.toString());
      }
    }
  }
}
