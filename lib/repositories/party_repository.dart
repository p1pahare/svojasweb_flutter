import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:svojasweb/models/api_response.dart';

import 'values.dart';

class PartyRepository {
  Future<ApiResponse> getAllParties({int pageNumber = 1}) async {
    try {
      final http.Response response = await http.get(
          Uri.parse(Values.base_url + Values.parties + '?page=$pageNumber'));

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

  Future<ApiResponse> createParty(Map<String, dynamic> party) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(Values.base_url + Values.party),
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

  Future<ApiResponse> editParty(Map<String, dynamic> party) async {
    try {
      String partyId = party[Values.party_id];
      party.remove(Values.party_id);
      final http.Response response = await http.put(
          Uri.parse(Values.base_url + Values.party + '/' + partyId),
          body: jsonEncode(party));
      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson({
          "status": true,
          "message": "Party was updated successfully",
        });
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

  Future<ApiResponse> getParty(
    String? partyId,
  ) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(Values.base_url + Values.party + '/' + partyId!),
      );
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

  Future<ApiResponse> getPartyByName(
      {String? partyName, String? port, String? partyType}) async {
    try {
      final http.Response response = await http
          .get(Uri.https(Values.base_url.split('/')[2], 'api/${Values.party}', {
        if (partyName != null) 'party_name': partyName,
        if (port != null) 'port': port,
        if (partyType != null) 'party_type': partyType
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

  Future<ApiResponse> deleteParty(
    String? partyId,
  ) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse(Values.base_url + Values.party + '/' + partyId!),
      );
      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson({
          "status": true,
          "message": "The party was deleted successfully",
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
