import 'package:svojasweb/models/quote.dart';

class Buying {
  Buying({
    required this.sid,
    required this.quoteId,
    required this.buyings,
    required this.quoteDetails,
  });
  late final String sid;
  late final String quoteId;
  late final List<String> buyings;
  late final List<Quote> quoteDetails;

  Buying.fromJson(Map<String, dynamic> json) {
    sid = json['_id'];
    quoteId = json['quote_id'];
    buyings = List.castFrom<dynamic, String>(json['buyings']);
    quoteDetails = List.from(json['quote_details'] ?? [])
        .map((e) => Quote.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = sid;
    _data['quote_id'] = quoteId;
    _data['buyings'] = buyings;
    _data['quote_details'] = quoteDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}
