import 'package:svojasweb/models/quote.dart';

class QuoteC {
  QuoteC({
    required this.date,
    required this.quoteId,
    required this.drayageFuel,
    required this.chassis,
    required this.prePull,
    required this.yardStorage,
    required this.portCongestion,
    required this.stopOff,
    required this.overweight,
    required this.reefer,
    required this.reeferMonitoringFee,
    required this.chassisSplit,
    required this.detention,
    required this.tolls,
    required this.dropAndPick,
    required this.quote,
    required this.hazmat,
    required this.sId,
  });
  late final String date;
  late final String quoteId;
  late final String drayageFuel;
  late final String chassis;
  late final String? prePull;
  late final String? yardStorage;
  late final String? portCongestion;
  late final String? stopOff;
  late final List<Quote> quote;
  late final String? overweight;
  late final String? reefer;
  late final String? reeferMonitoringFee;
  late final String? chassisSplit;
  late final String? detention;
  late final String? tolls;
  late final String? dropAndPick;
  late final String? hazmat;
  late final String sId;

  QuoteC.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    quoteId = json['quote_id'];
    drayageFuel = json['drayage_fuel'];
    chassis = json['chassis'];
    prePull = json['pre_pull'];
    yardStorage = json['yard_storage'];
    portCongestion = json['port_congestion'];
    stopOff = json['stop_off'];
    overweight = json['overweight'];
    reefer = json['reefer'];
    reeferMonitoringFee = json['reefer_monitoring_fee'];
    chassisSplit = json['chassis_split'];
    detention = json['detention'];
    quote =
        List.from(json['quote'] ?? []).map((e) => Quote.fromJson(e)).toList();
    tolls = json['tolls'];
    dropAndPick = json['drop_and_pick'];
    hazmat = json['hazmat'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['quote_id'] = quoteId;
    _data['drayage_fuel'] = drayageFuel;
    _data['chassis'] = chassis;
    _data['pre_pull'] = prePull;
    _data['yard_storage'] = yardStorage;
    _data['port_congestion'] = portCongestion;
    _data['quote'] = quote.map((e) => e.toJson()).toList();
    _data['stop_off'] = stopOff;
    _data['overweight'] = overweight;
    _data['reefer'] = reefer;
    _data['reefer_monitoring_fee'] = reeferMonitoringFee;
    _data['chassis_split'] = chassisSplit;
    _data['detention'] = detention;
    _data['tolls'] = tolls;
    _data['drop_and_pick'] = dropAndPick;
    _data['hazmat'] = hazmat;
    _data['_id'] = sId;
    return _data;
  }
}
