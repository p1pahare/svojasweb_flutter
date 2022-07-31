import 'package:flutter/material.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/utilities/key_value_view.dart';
import 'package:svojasweb/utilities/helper_functions.dart';
import 'package:svojasweb/views/subviews/view_party.dart';

class ViewQuote extends StatelessWidget {
  const ViewQuote({Key? key, required this.quote}) : super(key: key);
  final Quote quote;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey.withAlpha(170),
          borderRadius: BorderRadius.circular(20)),
      child: Wrap(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Quote Details",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          KeyValueView(skey: "Quote Id", value: quote.quoteId!),
          KeyValueView(skey: "Date", value: quote.date),
          if (quote.party.isEmpty)
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Unable to Fetch Party Data",
                  textAlign: TextAlign.center,
                ))
          else
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.7)),
                child: ViewParty(party: quote.party.first)),
          KeyValueView(skey: "type of Move", value: quote.typeOfMove),
          KeyValueView(skey: "Transit Type", value: quote.transitType),
          if (quote.pickupRamp != null)
            KeyValueView(skey: "Pickup Ramp", value: quote.pickupRamp!),
          if (quote.pickupAddress != null)
            KeyValueView(skey: "Pickup Address", value: quote.pickupAddress!),
          if (quote.pickupCity != null)
            KeyValueView(skey: "Pickup City", value: quote.pickupCity!),
          if (quote.pickupState != null)
            KeyValueView(skey: "Pickup State", value: quote.pickupState!),
          if (quote.pickupZip != null)
            KeyValueView(skey: "Pickup Zip Code", value: quote.pickupZip!),
          if (quote.deliveryRamp != null)
            KeyValueView(skey: "Delivery Ramp", value: quote.deliveryRamp!),
          if (quote.deliveryAddress != null)
            KeyValueView(
                skey: "Delivery Address", value: quote.deliveryAddress!),
          if (quote.deliveryCity != null)
            KeyValueView(skey: "Delivery City", value: quote.deliveryCity!),
          if (quote.deliveryState != null)
            KeyValueView(skey: "Delivery State", value: quote.deliveryState!),
          if (quote.deliveryZip != null)
            KeyValueView(skey: "Delivery ZipCode", value: quote.deliveryZip!),
          if (quote.sizeOfContainer != null)
            KeyValueView(
                skey: "Size Of Container", value: quote.sizeOfContainer!),
          if (quote.typeOfContainer != null)
            KeyValueView(
                skey: "Type Of Container", value: quote.typeOfContainer!),
          KeyValueView(skey: "Gross Weight", value: quote.grossWeight),
          KeyValueView(skey: "Commodity", value: quote.commodity),
          KeyValueView(skey: "Haz", value: quote.haz.toBetterString()),
          if (quote.hazUnNumber != null)
            KeyValueView(skey: "Haz Un number", value: quote.hazUnNumber!),
          if (quote.hazClass != null)
            KeyValueView(skey: "Haz Class", value: quote.hazClass!),
          if (quote.hazProperShippingName != null)
            KeyValueView(
                skey: "Haz Proper Shipping Name",
                value: quote.hazProperShippingName!),
          if (quote.typeOfEquipment != null)
            KeyValueView(
                skey: "Type Of Equipment", value: quote.typeOfEquipment!),
          if (quote.package?.isNotEmpty ?? false) ...[
            ...List.generate(
                quote.package?.length ?? 0,
                (index) => Column(
                      children: [
                        KeyValueView(
                            skey: "Package Number ", value: "${index + 1}"),
                        KeyValueView(
                            skey: "Package weight",
                            value: quote.package![index].weight.toString()),
                        KeyValueView(
                            skey: "Package height",
                            value: quote.package![index].height.toString()),
                        KeyValueView(
                            skey: "Package width",
                            value: quote.package![index].width.toString()),
                        KeyValueView(
                            skey: "Package length",
                            value: quote.package![index].length.toString()),
                        KeyValueView(
                            skey: "Package Quantity",
                            value: quote.package![index].packageNo.toString()),
                      ],
                    ))
          ]
        ],
      ),
    );
  }
}
