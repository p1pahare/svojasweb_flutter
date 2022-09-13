import 'package:svojasweb/models/buying.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/port.dart';
import 'package:svojasweb/models/quote.dart';

String getNameFromObject(dynamic object) {
  return object is Party
      ? "${object.partyName} (${object.orgName})"
      : object is Quote
          ? object.quoteId!
          : object is MapEntry<String, List<dynamic>>
              ? object.key
              : object is Buying
                  ? object.quoteId
                  : object is Port
                      ? object.portName
                      : "";
}

extension Better on bool {
  String toBetterString() => this ? "Yes" : "No";
}
