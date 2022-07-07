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

  Future<ApiResponse> getDateAndReference(
      String? username, String? password) async {
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

  Future<ApiResponse> getAllParties(String? username, String? password) async {
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

  Future<ApiResponse> getAllQuotes(String? username, String? password) async {
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

  Future<ApiResponse> createParty(
      {String? partyId,
      String? partyName,
      String? orgName,
      String? emailId,
      String? date,
      String? partyType,
      List<Map<String, String>>? extraContacts,
      String? address,
      int? zipCode,
      String? city,
      String? phone,
      String? scac,
      String? states,
      bool? haz,
      bool? overweight,
      bool? oog,
      bool? reefer,
      bool? transloadService,
      bool? deliveryAppointmentNeeded,
      String? warehouseTimingsOpen,
      String? warehouseTimingsClose,
      String? insuranceExpiry,
      String? motorCarrier}) async {
    try {
      final http.Response response =
          await http.post(Uri.parse(Values.base_url + Values.party),
              body: jsonEncode({
                "party_id": partyId,
                "party_name": partyName,
                "org_name": orgName,
                "email_id": emailId,
                "date": date,
                "party_type": partyType,
                "extra_contacts": extraContacts ?? [],
                "address": address ?? '',
                "zip_code": zipCode ?? 0,
                "city": city ?? '',
                "phone": phone ?? '',
                "scac": scac ?? '',
                "states": states ?? '',
                "haz": haz ?? false,
                "overweight": overweight ?? false,
                "oog": oog ?? false,
                "reefer": reefer ?? false,
                "transload_service": transloadService ?? false,
                "delivery_appointment_needed":
                    deliveryAppointmentNeeded ?? false,
                "warehouse_timings_open": warehouseTimingsOpen ??
                    DateTime.fromMillisecondsSinceEpoch(946691200)
                        .toIso8601String(),
                "warehouse_timings_close": warehouseTimingsClose ??
                    DateTime.fromMillisecondsSinceEpoch(946691200)
                        .toIso8601String(),
                "insurance_expiry": insuranceExpiry ??
                    DateTime.fromMillisecondsSinceEpoch(946691200)
                        .toIso8601String(),
                "motor_carrier": motorCarrier ?? ''
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

  Future<ApiResponse> editParty(
      {String? partyId,
      String? partyName,
      String? orgName,
      String? emailId,
      String? partyType,
      List<Map<String, String>>? extraContacts,
      String? address,
      int? zipCode,
      String? city,
      String? phone,
      String? scac,
      String? states,
      bool? haz,
      bool? overweight,
      bool? oog,
      bool? reefer,
      bool? transloadService,
      bool? deliveryAppointmentNeeded,
      String? warehouseTimingsOpen,
      String? warehouseTimingsClose,
      String? insuranceExpiry,
      String? motorCarrier}) async {
    try {
      final http.Response response = await http.put(
          Uri.parse(Values.base_url + Values.party + '/' + partyId!),
          body: jsonEncode({
            if (partyName != null) "party_name": partyName,
            if (orgName != null) "org_name": orgName,
            if (emailId != null) "email_id": emailId,
            if (partyType != null) "party_type": partyType,
            if (extraContacts != null) "extra_contacts": extraContacts,
            if (address != null) "address": address,
            if (zipCode != null) "zip_code": zipCode,
            if (city != null) "city": city,
            if (phone != null) "phone": phone,
            if (scac != null) "scac": scac,
            if (states != null) "states": states,
            if (haz != null) "haz": haz,
            if (overweight != null) "overweight": overweight,
            if (oog != null) "oog": oog,
            if (reefer != null) "reefer": reefer,
            if (transloadService != null) "transload_service": transloadService,
            if (deliveryAppointmentNeeded != null)
              "delivery_appointment_needed": deliveryAppointmentNeeded,
            if (warehouseTimingsOpen != null)
              "warehouse_timings_open": warehouseTimingsOpen,
            if (warehouseTimingsClose != null)
              "warehouse_timings_close": warehouseTimingsClose,
            if (insuranceExpiry != null) "insurance_expiry": insuranceExpiry,
            if (motorCarrier != null) "motor_carrier": motorCarrier
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
}
