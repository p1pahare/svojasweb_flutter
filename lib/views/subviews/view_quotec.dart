import 'package:flutter/material.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/utilities/key_value_view.dart';
import 'package:svojasweb/views/subviews/view_quote.dart';

class ViewQuotec extends StatelessWidget {
  const ViewQuotec({Key? key, required this.quoteC}) : super(key: key);
  final QuoteC quoteC;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Wrap(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Quote to customer Details",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          if (quoteC.quote.isEmpty)
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "The Quote was removed from the main Data",
                  textAlign: TextAlign.center,
                ))
          else
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.7),
                ),
                child: ViewQuote(quote: quoteC.quote.first)),
          KeyValueView(skey: "Drayage + Fuel (FSC)", value: quoteC.drayageFuel),
          KeyValueView(skey: "Chassis", value: quoteC.chassis),
          if (quoteC.prePull != null)
            KeyValueView(skey: "Pre Pull", value: quoteC.prePull!),
          if (quoteC.yardStorage != null)
            KeyValueView(skey: "Yard  Storage", value: quoteC.yardStorage!),
          if (quoteC.portCongestion != null)
            KeyValueView(
                skey: "Port Congestion", value: quoteC.portCongestion!),
          if (quoteC.stopOff != null)
            KeyValueView(skey: "Stop Off", value: quoteC.stopOff!),
          if (quoteC.overweight != null)
            KeyValueView(skey: "Overweight", value: quoteC.overweight!),
          if (quoteC.reefer != null)
            KeyValueView(skey: "Reefer", value: quoteC.reefer!),
          if (quoteC.reeferMonitoringFee != null)
            KeyValueView(
                skey: "Reefer Monitoring Fee",
                value: quoteC.reeferMonitoringFee!),
          if (quoteC.chassisSplit != null)
            KeyValueView(skey: "Chassis  Split", value: quoteC.chassisSplit!),
          if (quoteC.detention != null)
            KeyValueView(skey: "Detention", value: quoteC.detention!),
          if (quoteC.stopOff != null)
            KeyValueView(skey: "Tolls", value: quoteC.tolls!),
          if (quoteC.dropAndPick != null)
            KeyValueView(skey: "Drop and Pick", value: quoteC.dropAndPick!),
          if (quoteC.stopOff != null)
            KeyValueView(skey: "Hazmat", value: quoteC.hazmat!),
        ],
      ),
    );
  }
}
