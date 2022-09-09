import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:svojasweb/models/api_response.dart';

import 'values.dart';

class QuoteRepository {
  Future<ApiResponse> getAllQuotes({int pageNumber = 1}) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(Values.base_url + Values.quotes + '?page=$pageNumber'),
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

  Future<ApiResponse> createQuote(Map<String, dynamic> quote) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(Values.base_url + Values.quote),
          body: jsonEncode(quote));

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

  Future<ApiResponse> editQuote(Map<String, dynamic> quote) async {
    try {
      String quoteNumber = quote[Values.quote_number];
      quote.remove(Values.quote_number);
      quote.remove(Values.date);
      final http.Response response = await http.put(
          Uri.parse(Values.base_url + Values.quote + '/' + quoteNumber),
          body: jsonEncode(quote));

      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson({
          "status": true,
          "message": "Quote was updated successfully",
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

  Future<ApiResponse> getQuote(String? quoteNumber) async {
    try {
      final http.Response response = await http.put(
        Uri.parse(Values.base_url + Values.quote + '/' + quoteNumber!),
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

  Future<ApiResponse> getQuoteByQuoteID(String? quoteID) async {
    try {
      final http.Response response = await http.get(Uri.https(
          Values.base_url.split('/')[2],
          'api/${Values.quote}',
          {if (quoteID != null) 'quote_id': quoteID}));

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

  Future<ApiResponse> deleteQuote(String? quoteNumber) async {
    try {
      final http.Response response = await http.delete(
        Uri.parse(Values.base_url + Values.quote + '/' + quoteNumber!),
      );

      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson({
          "status": true,
          "message": "The quote was deleted successfully",
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
