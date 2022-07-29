import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';

String getNameFromObject(dynamic object) {
  return object is Party
      ? object.partyName!
      : object is Quote
          ? object.quoteId!
          : "";
}
