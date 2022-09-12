class Cquote {
  Cquote({
    required this.sid,
    required this.quoteId,
    required this.container,
    required this.mbl,
    required this.pickupTerminal,
    required this.eta,
    required this.lfd,
    required this.gateOut,
    required this.delivery,
    required this.emptyGateIn,
    required this.emptyReturnTerminal,
    required this.emptyPickupTerminal,
    required this.booking,
    required this.erd,
    required this.lrd,
    required this.etd,
    required this.emptyGateOut,
    required this.awb,
    required this.pickupHandlingAgent,
    required this.deliveryHandlingAgent,
    required this.pickup,
    required this.bookingCutoff,
    required this.bol,
    required this.carrierReferenceNo,
    required this.ltlCarrierName,
    required this.ftlCarrierName,
    required this.type,
  });
  late final String? sid;
  late final String? quoteId;
  late final String? container;
  late final String? mbl;
  late final String? pickupTerminal;
  late final String? eta;
  late final String? lfd;
  late final String? gateOut;
  late final String? delivery;
  late final String? emptyGateIn;
  late final String? emptyReturnTerminal;
  late final String? emptyPickupTerminal;
  late final String? booking;
  late final String? erd;
  late final String? lrd;
  late final String? etd;
  late final String? emptyGateOut;
  late final String? awb;
  late final String? pickupHandlingAgent;
  late final String? deliveryHandlingAgent;
  late final String? pickup;
  late final String? bookingCutoff;
  late final String? bol;
  late final String? carrierReferenceNo;
  late final String? ltlCarrierName;
  late final String? ftlCarrierName;
  late final String? type;
  late final String? loading;
  late final String? fullReturn;
  late final String? fullReturnTerminal;
  Cquote.fromJson(Map<String, dynamic> json) {
    sid = json['_id'];
    quoteId = json['quote_id'];
    container = json['container'];
    mbl = json['mbl'];
    pickupTerminal = json['pickup_terminal'];
    eta = json['eta'];
    lfd = json['lfd'];
    gateOut = json['gate_out'];
    delivery = json['delivery'];
    emptyGateIn = json['empty_gate_in'];
    emptyReturnTerminal = json['empty_return_terminal'];
    emptyPickupTerminal = json['empty_pickup_terminal'];
    booking = json['booking'];
    erd = json['erd'];
    lrd = json['lrd'];
    etd = json['etd'];
    emptyGateOut = json['empty_gate_out'];
    awb = json['awb'];
    pickupHandlingAgent = json['pickup_handling_agent'];
    deliveryHandlingAgent = json['delivery_handling_agent'];
    pickup = json['pickup'];
    bookingCutoff = json['booking_cutoff'];
    bol = json['bol'];
    carrierReferenceNo = json['carrier_reference_no'];
    ltlCarrierName = json['ltl_carrier_name'];
    ftlCarrierName = json['ftl_carrier_name'];
    type = json['type'];
    loading = json['loading'];
    fullReturn = json['full_return'];
    fullReturnTerminal = json['full_return_terminal'];
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['_id'] = sid;
    _data['quote_id'] = quoteId;
    _data['container'] = container;
    _data['mbl'] = mbl;
    _data['pickup_terminal'] = pickupTerminal;
    _data['eta'] = eta;
    _data['lfd'] = lfd;
    _data['gate_out'] = gateOut;
    _data['delivery'] = delivery;
    _data['empty_gate_in'] = emptyGateIn;
    _data['empty_return_terminal'] = emptyReturnTerminal;
    _data['empty_pickup_terminal'] = emptyPickupTerminal;
    _data['booking'] = booking;
    _data['erd'] = erd;
    _data['lrd'] = lrd;
    _data['etd'] = etd;
    _data['empty_gate_out'] = emptyGateOut;
    _data['awb'] = awb;
    _data['pickup_handling_agent'] = pickupHandlingAgent;
    _data['delivery_handling_agent'] = deliveryHandlingAgent;
    _data['pickup'] = pickup;
    _data['booking_cutoff'] = bookingCutoff;
    _data['bol'] = bol;
    _data['carrier_reference_no'] = carrierReferenceNo;
    _data['ltl_carrier_name'] = ltlCarrierName;
    _data['ftl_carrier_name'] = ftlCarrierName;
    _data['type'] = type;
    _data['loading'] = loading;
    _data['full_return'] = fullReturn;
    _data['full_return_terminal'] = fullReturnTerminal;
    return _data;
  }
}
