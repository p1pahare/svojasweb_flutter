import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:svojasweb/models/api_response.dart';

import 'values.dart';

class NetworkCalls {
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

  Future<ApiResponse> getAllParties() async {
    try {
      final http.Response response =
          await http.get(Uri.parse(Values.base_url + Values.parties));

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

  Future<ApiResponse> getAllQuotes() async {
    try {
      final http.Response response = await http.get(
        Uri.parse(Values.base_url + Values.quotes),
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

  Future<ApiResponse> createQuote({
    String? quoteNumber,
    String? date,
    String? customer,
    String? typeOfMove,
    String? transitType,
    String? grossWeight,
    String? commodity,
    bool? haz,
    bool? reefer,
    List<Map<String, dynamic>>? package,
    String? pickupRamp,
    String? deliveryRamp,
    String? deliveryAddress,
    String? deliveryCity,
    String? deliveryState,
    String? deliveryZip,
    String? pickupAddress,
    String? pickupCity,
    String? pickupState,
    String? pickupZip,
    String? sizeOfContainer,
    String? typeOfContainer,
    String? hazUnNumber,
    String? hazClass,
    String? hazProperShippingName,
    String? reeferTemp,
    String? typeOfEquipment,
  }) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(Values.base_url + Values.quote),
              body: jsonEncode({
                "date": date,
                "customer": customer,
                "type_of_move": typeOfMove,
                "transit_type": transitType,
                "gross_weight": grossWeight,
                "commodity": commodity,
                "haz": haz,
                "reefer": reefer,
                "package": package ?? [],
                "pickup_ramp": pickupRamp ?? '',
                "delivery_ramp": deliveryRamp ?? '',
                "delivery_address": deliveryAddress ?? '',
                "delivery_city": deliveryCity ?? '',
                "delivery_state": deliveryState ?? '',
                "delivery_zip": deliveryZip ?? '',
                "pickup_address": pickupAddress ?? '',
                "pickup_city": pickupCity ?? '',
                "pickup_state": pickupState ?? '',
                "pickup_zip": pickupZip ?? '',
                "size_of_container": sizeOfContainer ?? '',
                "type_of_container": typeOfContainer ?? '',
                "haz_un_number": hazUnNumber ?? '',
                "haz_class": hazClass ?? '',
                "haz_proper_shipping_name": hazProperShippingName ?? '',
                "reefer_temp": reeferTemp ?? '',
                "type_of_equipment": typeOfEquipment ?? ''
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

  Future<ApiResponse> editQuote({
    String? quoteNumber,
    String? customer,
    String? typeOfMove,
    String? transitType,
    String? grossWeight,
    String? commodity,
    bool? haz,
    bool? reefer,
    List<Map<String, dynamic>>? package,
    String? pickupRamp,
    String? deliveryRamp,
    String? deliveryAddress,
    String? deliveryCity,
    String? deliveryState,
    String? deliveryZip,
    String? pickupAddress,
    String? pickupCity,
    String? pickupState,
    String? pickupZip,
    String? sizeOfContainer,
    String? typeOfContainer,
    String? hazUnNumber,
    String? hazClass,
    String? hazProperShippingName,
    String? reeferTemp,
    String? typeOfEquipment,
  }) async {
    try {
      final http.Response response = await http.put(
          Uri.parse(Values.base_url + Values.quote + '/' + quoteNumber!),
          body: jsonEncode({
            if (customer != null) "customer": customer,
            if (typeOfMove != null) "type_of_move": typeOfMove,
            if (transitType != null) "transit_type": transitType,
            if (grossWeight != null) "gross_weight": grossWeight,
            if (commodity != null) "commodity": commodity,
            if (haz != null) "haz": haz,
            if (reefer != null) "reefer": reefer,
            if (package != null) "package": package,
            if (pickupRamp != null) "pickup_ramp": pickupRamp,
            if (deliveryRamp != null) "delivery_ramp": deliveryRamp,
            if (deliveryAddress != null) "delivery_address": deliveryAddress,
            if (deliveryCity != null) "delivery_city": deliveryCity,
            if (deliveryState != null) "delivery_state": deliveryState,
            if (deliveryZip != null) "delivery_zip": deliveryZip,
            if (pickupAddress != null) "pickup_address": pickupAddress,
            if (pickupCity != null) "pickup_city": pickupCity,
            if (pickupState != null) "pickup_state": pickupState,
            if (pickupZip != null) "pickup_zip": pickupZip,
            if (sizeOfContainer != null) "size_of_container": sizeOfContainer,
            if (typeOfContainer != null) "type_of_container": typeOfContainer,
            if (hazUnNumber != null) "haz_un_number": hazUnNumber,
            if (hazClass != null) "haz_class": hazClass,
            if (hazProperShippingName != null)
              "haz_proper_shipping_name": hazProperShippingName,
            if (reeferTemp != null) "reefer_temp": reeferTemp,
            if (typeOfEquipment != null) "type_of_equipment": typeOfEquipment
          }));

      if (response.statusCode == 200) {
        final String body = response.body;
        log(body);
        return ApiResponse.fromJson({
          "status": true,
          "message": "Quote was updated successfully",
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
