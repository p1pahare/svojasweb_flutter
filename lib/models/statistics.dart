class Statistics {
  Statistics({
    required this.truckers,
    required this.customers,
    required this.shippers,
    required this.consignees,
    required this.oceanImports,
    required this.oceanExports,
    required this.airImports,
    required this.airExports,
    required this.inlandImports,
    required this.inlandExports,
  });
  late final int truckers;
  late final int customers;
  late final int shippers;
  late final int consignees;
  late final int oceanImports;
  late final int oceanExports;
  late final int airImports;
  late final int airExports;
  late final int inlandImports;
  late final int inlandExports;

  Statistics.fromJson(Map<String, dynamic> json) {
    truckers = json['truckers'];
    customers = json['customers'];
    shippers = json['shippers'];
    consignees = json['consignees'];
    oceanImports = json['ocean_imports'];
    oceanExports = json['ocean_exports'];
    airImports = json['air_imports'];
    airExports = json['air_exports'];
    inlandImports = json['inland_imports'];
    inlandExports = json['inland_exports'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['truckers'] = truckers;
    _data['customers'] = customers;
    _data['shippers'] = shippers;
    _data['consignees'] = consignees;
    _data['ocean_imports'] = oceanImports;
    _data['ocean_exports'] = oceanExports;
    _data['air_imports'] = airImports;
    _data['air_exports'] = airExports;
    _data['inland_imports'] = inlandImports;
    _data['inland_exports'] = inlandExports;
    return _data;
  }
}
