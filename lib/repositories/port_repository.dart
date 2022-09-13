import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:svojasweb/models/api_response.dart';

import 'values.dart';

class PortRepository {
  Future<ApiResponse> createPort(Map<String, dynamic> party) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(Values.base_url + Values.port),
          body: jsonEncode(party));
      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson(
            {"status": true, "message": "", "data": jsonDecode(body)});
      } else {
        String message = response.body;
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

  Future<ApiResponse> getPortByFields(
      {String? portName, String? portType}) async {
    try {
      final http.Response response = await http
          .get(Uri.https(Values.base_url.split('/')[2], 'api/${Values.port}', {
        if (portName != null) 'port_name': portName,
        if (portType != null) 'port_type': portType
      }));
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

  Future<ApiResponse> deletePort(
    String? portId,
  ) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse(Values.base_url + Values.port + '/' + portId!),
      );
      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson({
          "status": true,
          "message": "The port was deleted successfully",
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
}
