import 'package:svojasweb/models/party.dart';

class Quote {
  Quote({
    required this.date,
    required this.sid,
    required this.customer,
    required this.typeOfMove,
    required this.transitType,
    required this.pickupRamp,
    required this.deliveryRamp,
    required this.deliveryAddress,
    required this.deliveryCity,
    required this.deliveryState,
    required this.deliveryZip,
    required this.pickupAddress,
    required this.pickupCity,
    required this.pickupState,
    required this.pickupZip,
    required this.sizeOfContainer,
    required this.typeOfContainer,
    required this.grossWeight,
    required this.commodity,
    required this.haz,
    required this.reefer,
    required this.hazUnNumber,
    required this.hazClass,
    required this.hazProperShippingName,
    required this.reeferTemp,
    required this.typeOfEquipment,
    required this.package,
    required this.party,
  });
  late final String date;
  late final String sid;
  late final String? quoteId;
  late final String customer;
  late final String typeOfMove;
  late final String transitType;
  late final String? pickupRamp;
  late final String? deliveryRamp;
  late final String? deliveryAddress;
  late final String? deliveryCity;
  late final String? deliveryState;
  late final String? deliveryZip;
  late final String? pickupAddress;
  late final String? pickupCity;
  late final String? pickupState;
  late final String? pickupZip;
  late final String? sizeOfContainer;
  late final String? typeOfContainer;
  late final String grossWeight;
  late final String commodity;
  late final bool haz;
  late final bool reefer;
  late final String? hazUnNumber;
  late final String? hazClass;
  late final String? hazProperShippingName;
  late final String? reeferTemp;
  late final String? typeOfEquipment;
  late final List<Package>? package;
  late final List<Party> party;

  Quote.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    sid = json['_id'];
    customer = json['customer'];
    typeOfMove = json['type_of_move'];
    transitType = json['transit_type'];
    pickupRamp = json['pickup_ramp'];
    quoteId = json['quote_id'];
    deliveryRamp = json['delivery_ramp'];
    deliveryAddress = json['delivery_address'];
    deliveryCity = json['delivery_city'];
    deliveryState = json['delivery_state'];
    deliveryZip = json['delivery_zip']?.toString() ?? '';
    pickupAddress = json['pickup_address'];
    pickupCity = json['pickup_city'];
    pickupState = json['pickup_state'];
    pickupZip = json['pickup_zip']?.toString() ?? '';
    sizeOfContainer = json['size_of_container'];
    typeOfContainer = json['type_of_container'];
    grossWeight = json['gross_weight'];
    commodity = json['commodity'];
    haz = json['haz'];
    reefer = json['reefer'];
    hazUnNumber = json['haz_un_number'];
    hazClass = json['haz_class'];
    hazProperShippingName = json['haz_proper_shipping_name'];
    reeferTemp = json['reefer_temp'];
    typeOfEquipment = json['type_of_equipment'];
    package =
        List.from(json['package']).map((e) => Package.fromJson(e)).toList();
    party =
        List.from(json['party'] ?? []).map((e) => Party.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['_id'] = sid;
    _data['customer'] = customer;
    _data['type_of_move'] = typeOfMove;
    _data['transit_type'] = transitType;
    _data['pickup_ramp'] = pickupRamp;
    _data['delivery_ramp'] = deliveryRamp;
    _data['delivery_address'] = deliveryAddress;
    _data['delivery_city'] = deliveryCity;
    _data['delivery_state'] = deliveryState;
    _data['delivery_zip'] = deliveryZip;
    _data['pickup_address'] = pickupAddress;
    _data['pickup_city'] = pickupCity;
    _data['pickup_state'] = pickupState;
    _data['pickup_zip'] = pickupZip;
    _data['quote_id'] = quoteId;
    _data['size_of_container'] = sizeOfContainer;
    _data['type_of_container'] = typeOfContainer;
    _data['party'] = party.map((e) => e.toJson()).toList();
    _data['gross_weight'] = grossWeight;
    _data['commodity'] = commodity;
    _data['haz'] = haz;
    _data['reefer'] = reefer;
    _data['haz_un_number'] = hazUnNumber;
    _data['haz_class'] = hazClass;
    _data['haz_proper_shipping_name'] = hazProperShippingName;
    _data['reefer_temp'] = reeferTemp;
    _data['type_of_equipment'] = typeOfEquipment;
    _data['package'] = package?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Package {
  Package({
    required this.packageNo,
    required this.height,
    required this.width,
    required this.length,
    required this.weight,
  });
  late final int packageNo;
  late final double? height;
  late final double? width;
  late final double? length;
  late final double? weight;

  Package.fromJson(Map<String, dynamic> json) {
    packageNo = int.tryParse(json['package_no']) ?? 0;
    height = double.tryParse(json['height'].toString());
    width = double.tryParse(json['width'].toString());
    length = double.tryParse(json['length'].toString());
    weight = double.tryParse(json['weight'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['package_no'] = packageNo;
    _data['height'] = height;
    _data['width'] = width;
    _data['length'] = length;
    _data['weight'] = weight;
    return _data;
  }
}
