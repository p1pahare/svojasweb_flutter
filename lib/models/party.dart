class Party {
  Party({
    required this.sid,
    required this.date,
    required this.partyName,
    required this.orgName,
    required this.emailId,
    required this.state,
    required this.partyType,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.phone,
    required this.extraContacts,
    required this.scac,
    required this.states,
    required this.port,
    required this.haz,
    required this.overweight,
    required this.oog,
    required this.reefer,
    required this.transloadService,
    required this.insuranceExpiry,
    required this.motorCarrier,
    required this.deliveryAppointmentNeeded,
    required this.warehouseTimingsOpen,
    required this.warehouseTimingsClose,
  });
  late final String? sid;
  late final String? date;
  late final String? partyName;
  late final String? orgName;
  late final String? emailId;
  late final String? partyType;
  late final String? address;
  late final String? city;
  late final String? port;
  late final String? state;
  late final String? zipCode;
  late final String? phone;
  late final List<ExtraContacts> extraContacts;
  late final String? scac;
  late final String? states;
  late final bool? haz;
  late final bool? overweight;
  late final bool? oog;
  late final bool? reefer;
  late final bool? transloadService;
  late final String? insuranceExpiry;
  late final String? motorCarrier;
  late final bool? deliveryAppointmentNeeded;
  late final String? warehouseTimingsOpen;
  late final String? warehouseTimingsClose;

  Party.fromJson(Map<String?, dynamic> json) {
    sid = json['_id'];
    date = json['date'];
    partyName = json['party_name'];
    orgName = json['org_name'];
    emailId = json['email_id'];
    partyType = json['party_type'];
    address = json['address'];
    city = json['city'];
    port = json['port'];
    zipCode = json['zip_code'].toString();
    state = json['state'];
    phone = json['phone'] is String ? json['phone'] : json['phone'].toString();
    extraContacts = json['extra_contacts'] is List
        ? List.from(json['extra_contacts'])
            .map((e) => ExtraContacts.fromJson(e))
            .toList()
        : [];
    scac = json['scac'];
    states = json['states'];
    haz = json['haz'] is bool
        ? json['haz']
        : (json['haz'] is String && json['haz'] == 'Yes')
            ? true
            : false;
    overweight = json['overweight'] is bool
        ? json['overweight']
        : (json['overweight'] is String && json['overweight'] == 'Yes')
            ? true
            : false;
    oog = json['oog'] is bool
        ? json['oog']
        : (json['oog'] is String && json['oog'] == 'Yes')
            ? true
            : false;
    reefer = json['reefer'] is bool
        ? json['reefer']
        : (json['reefer'] is String && json['reefer'] == 'Yes')
            ? true
            : false;
    transloadService = json['transload_service'] is bool
        ? json['transload_service']
        : (json['transload_service'] is String &&
                json['transload_service'] == 'Yes')
            ? true
            : false;
    insuranceExpiry = json['insurance_expiry'];
    motorCarrier = json['motor_carrier'];
    deliveryAppointmentNeeded = json['delivery_appointment_needed'] is bool
        ? json['delivery_appointment_needed']
        : (json['delivery_appointment_needed'] is String &&
                json['delivery_appointment_needed'] == 'Yes')
            ? true
            : false;
    warehouseTimingsOpen = json['warehouse_timings_open'];
    warehouseTimingsClose = json['warehouse_timings_close'];
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['_id'] = sid;
    _data['date'] = date;
    _data['party_name'] = partyName;
    _data['org_name'] = orgName;
    _data['email_id'] = emailId;
    _data['party_type'] = partyType;
    _data['address'] = address;
    _data['city'] = city;
    _data['state'] = state;
    _data['zip_code'] = zipCode;
    _data['phone'] = phone;
    _data['extra_contacts'] = extraContacts.map((e) => e.toJson()).toList();
    _data['scac'] = scac;
    _data['states'] = states;
    _data['haz'] = haz;
    _data['overweight'] = overweight;
    _data['oog'] = oog;
    _data['port'] == port;
    _data['reefer'] = reefer;
    _data['transload_service'] = transloadService;
    _data['insurance_expiry'] = insuranceExpiry;
    _data['motor_carrier'] = motorCarrier;
    _data['delivery_appointment_needed'] = deliveryAppointmentNeeded;
    _data['warehouse_timings_open'] = warehouseTimingsOpen;
    _data['warehouse_timings_close'] = warehouseTimingsClose;
    return _data;
  }
}

class ExtraContacts {
  ExtraContacts({
    required this.partyName,
    required this.emailId,
    required this.phone,
  });
  late final String? partyName;
  late final String? emailId;
  late final String? phone;

  ExtraContacts.fromJson(Map<String?, dynamic> json) {
    partyName = json['party_name'];
    emailId = json['email_id'];
    phone = json['phone'];
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['party_name'] = partyName;
    _data['email_id'] = emailId;
    _data['phone'] = phone;
    return _data;
  }
}
