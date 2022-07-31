import 'package:flutter/material.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/utilities/key_value_view.dart';
import 'package:svojasweb/utilities/helper_functions.dart';

class ViewParty extends StatelessWidget {
  const ViewParty({Key? key, required this.party}) : super(key: key);
  final Party party;
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
              "Party Details",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          KeyValueView(skey: "Party Id", value: party.sid!),
          KeyValueView(skey: "Date", value: party.date!),
          KeyValueView(skey: "Party Type", value: party.partyType!),
          KeyValueView(skey: "Party Name", value: party.partyName!),
          KeyValueView(skey: "Company Name", value: party.orgName!),
          KeyValueView(skey: "Address", value: party.address!),
          KeyValueView(skey: "City", value: party.city!),
          KeyValueView(skey: "State", value: party.state!),
          KeyValueView(skey: "Zip Code", value: party.zipCode!),
          if (party.scac != null)
            KeyValueView(skey: "SCAC", value: party.scac!),
          if (party.states != null)
            KeyValueView(skey: "States", value: party.states!),
          if (party.haz != null)
            KeyValueView(skey: "Haz", value: party.haz?.toBetterString() ?? ''),
          if (party.overweight != null)
            KeyValueView(
                skey: "Overweight",
                value: party.overweight?.toBetterString() ?? ''),
          if (party.oog != null)
            KeyValueView(skey: "OOG", value: party.oog!.toBetterString()),
          if (party.reefer != null)
            KeyValueView(skey: "Reefer", value: party.reefer!.toBetterString()),
          if (party.transloadService != null)
            KeyValueView(
                skey: "transload service",
                value: party.transloadService!.toBetterString()),
          if (party.motorCarrier != null)
            KeyValueView(
                skey: "Motor Service", value: party.motorCarrier ?? ''),
          if (party.deliveryAppointmentNeeded != null)
            KeyValueView(
                skey: "Delivery Appointment Needed",
                value: party.reefer!.toBetterString()),
          if (party.warehouseTimingsOpen != null)
            KeyValueView(
                skey: "Ware House Opening Time",
                value: party.warehouseTimingsOpen!),
          if (party.warehouseTimingsClose != null)
            KeyValueView(
                skey: "Ware House Closing Time",
                value: party.warehouseTimingsClose!),
          if (party.reefer != null)
            KeyValueView(skey: "Reefer", value: party.reefer!.toBetterString()),
          if (party.extraContacts.isNotEmpty) ...[
            ...List.generate(
                party.extraContacts.length,
                (index) => Column(
                      children: [
                        KeyValueView(
                            skey: "Contact Index ", value: "${index + 1}"),
                        KeyValueView(
                            skey: "Contact Name",
                            value: party.extraContacts[index].partyName!),
                        KeyValueView(
                            skey: "Email ID",
                            value: party.extraContacts[index].emailId!),
                        KeyValueView(
                            skey: "Phone Number",
                            value: party.extraContacts[index].phone!),
                      ],
                    ))
          ]
        ],
      ),
    );
  }
}
