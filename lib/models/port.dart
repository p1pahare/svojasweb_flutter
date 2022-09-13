class Port {
  Port({
    required this.sid,
    required this.portName,
    required this.portCode,
    required this.stateName,
    required this.zipCode,
    required this.portType,
  });
  late final String sid;
  late final String portName;
  late final String portCode;
  late final String stateName;
  late final String zipCode;
  late final String portType;

  Port.fromJson(Map<String, dynamic> json) {
    sid = json['_id'];
    portName = json['port_name'];
    portCode = json['port_code'];
    stateName = json['state_name'];
    zipCode = json['zip_code'];
    portType = json['port_type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sid;
    _data['port_name'] = portName;
    _data['port_code'] = portCode;
    _data['state_name'] = stateName;
    _data['zip_code'] = zipCode;
    _data['port_type'] = portType;
    return _data;
  }
}
