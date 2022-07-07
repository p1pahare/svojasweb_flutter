import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/dropdown_field_custom.dart';
import 'package:svojasweb/utilities/textfield_custm.dart';

class CreatePartyView extends StatefulWidget {
  const CreatePartyView({Key? key, this.party}) : super(key: key);
  static const routeName = '/CreatePartyView';
  static const routeNameEdit = '/EditPartyView';
  final Party? party;
  @override
  State<CreatePartyView> createState() => _CreatePartyViewState();
}

class _CreatePartyViewState extends State<CreatePartyView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onValueSelected(String key, String? value) {
    if (key == 'party_type' && value?.toLowerCase() != 'select') {
      for (final element in partyFields) {
        element.visible = false;
        element.isLast = false;
      }
      partyFields[
              partyFields.indexWhere((element) => element.keyId == 'party_id')]
          .visible = true;
      partyFields[partyFields.indexWhere((element) => element.keyId == 'date')]
          .visible = true;
      partyFields[partyFields
              .indexWhere((element) => element.keyId == 'party_type')]
          .visible = true;
      partyFields[partyFields
              .indexWhere((element) => element.keyId == 'party_name')]
          .visible = true;
      partyFields[
              partyFields.indexWhere((element) => element.keyId == 'org_name')]
          .visible = true;
      partyFields[partyFields.indexWhere((element) => element.keyId == 'city')]
          .visible = true;
      partyFields[
              partyFields.indexWhere((element) => element.keyId == 'zip_code')]
          .visible = true;
      partyFields[partyFields.indexWhere((element) => element.keyId == 'phone')]
          .visible = true;

      partyFields[
              partyFields.indexWhere((element) => element.keyId == 'email_id')]
          .visible = true;
      switch (value?.toLowerCase()) {
        case 'customer':
          partyFields[
                  partyFields.indexWhere((element) => element.keyId == 'phone')]
              .isLast = true;
          break;
        case 'trucker':
          partyFields[
                  partyFields.indexWhere((element) => element.keyId == 'scac')]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == 'states')]
              .visible = true;
          partyFields[
                  partyFields.indexWhere((element) => element.keyId == 'haz')]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == 'overweight')]
              .visible = true;
          partyFields[
                  partyFields.indexWhere((element) => element.keyId == 'oog')]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == 'reefer')]
              .visible = true;
          partyFields[partyFields.indexWhere(
                  (element) => element.keyId == 'transload_service')]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == 'insurance_expiry')]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == 'motor_carrier')]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == 'motor_Carrier')]
              .isLast = true;
          break;
        case 'consignee':
        case 'shipper':
          partyFields[partyFields.indexWhere(
              (element) => element.keyId == 'delivery_appointment_needed')]
            ..visible = true
            ..isLast = true;

          break;
        default:
          dev.log("value error");
      }
    }
    if (key.toLowerCase() == 'delivery_appointment_needed') {
      partyFields[partyFields.indexWhere(
              (element) => element.keyId == 'warehouse_timings_open')]
          .visible = value?.toLowerCase() == 'no' ? true : false;
      partyFields[partyFields.indexWhere(
              (element) => element.keyId == 'warehouse_timings_close')]
          .visible = value?.toLowerCase() == 'no' ? true : false;
    }

    setState(() {});
  }

  void focusOnNextVisible(int index) {
    for (int i = index + 1; i < partyFields.length; i++) {
      if (partyFields[i].visible) {
        FocusScope.of(context).requestFocus(partyFields[i].focusnode);
        break;
      }
    }
  }

  List<TextFieldEntry> partyFields = [
    TextFieldEntry(label: 'Party ID', keyId: "party_id"),
    TextFieldEntry(
      label: 'Date',
      keyId: "date",
    ),
    TextFieldEntry(
        fieldType: FieldType.dropdown,
        options: ['Select', 'Customer', 'Trucker', 'Consignee', 'Shipper'],
        keyId: "party_type"),
    TextFieldEntry(label: 'Party Name', keyId: "party_name", visible: false),
    TextFieldEntry(label: 'Company Name', keyId: "org_name", visible: false),
    TextFieldEntry(label: 'Email Id', keyId: "email_id", visible: false),
    // "extra_contacts": List<Map<String, dynamic>>.empty(),
    TextFieldEntry(label: 'Address', keyId: "address", visible: false),
    TextFieldEntry(label: 'Zip Code', keyId: "zip_code", visible: false),
    TextFieldEntry(label: 'City', keyId: "city", visible: false),
    TextFieldEntry(label: 'Phone', keyId: "phone", visible: false),
    TextFieldEntry(label: 'SCAC', keyId: "scac", visible: false),
    TextFieldEntry(label: 'States Served', keyId: "states", visible: false),
    TextFieldEntry(
        label: 'Haz',
        keyId: "haz",
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Overweight',
        keyId: "overweight",
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'OOG',
        keyId: "oog",
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Reefer',
        keyId: "reefer",
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Transload Service',
        keyId: "transload_service",
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Delivery Appointment Needed',
        keyId: "delivery_appointment_needed",
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Warehouse Timings (Open)',
        keyId: "warehouse_timings_open",
        visible: false),

    TextFieldEntry(
        label: 'Warehouse Timings (Close)',
        keyId: "warehouse_timings_close",
        visible: false),
    TextFieldEntry(
        label: 'Insurance Expiry', keyId: "insurance_expiry", visible: false),
    TextFieldEntry(
        label: 'Motor Carrier', keyId: "motor_carrier", visible: false),
  ];

  List<TextFieldEntry> extraContactsFields = [
    TextFieldEntry(label: 'Contact Name', keyId: 'party_name'),
    TextFieldEntry(label: 'Email Id', keyId: 'email_id'),
    TextFieldEntry(label: 'Phone', keyId: 'phone'),
  ];

  @override
  void initState() {
    // if (widget.customer != null) {
    //   _textfields['customer_name']!.text = widget.customer!.customerName;
    //   _textfields['company_name']!.text = widget.customer!.companyName;
    //   _textfields['customer_type']!.text = widget.customer!.customerType;
    //   _textfields['email']!.text = widget.customer!.emailId;
    //   _textfields['phone']!.text = widget.customer!.phone;
    //   _textfields['address']!.text = widget.customer!.address;
    //   _textfields['city']!.text = widget.customer!.city;
    //   _textfields['zip_code']!.text = widget.customer!.zipCode.toString();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('${widget.party == null ? 'Create' : 'Edit'} Party')),
      // drawer: const DrawerView(),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
              // width: min(MediaQuery.of(context).size.width, 480),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        children:
                            List<Widget>.generate(partyFields.length, (index) {
                          if (!partyFields[index].visible) {
                            return const SizedBox(
                              height: 0,
                              width: 0,
                            );
                          }
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: min(
                                460, MediaQuery.of(context).size.width - 40),
                            child: Builder(builder: (context) {
                              final TextFieldEntry textFieldEntry =
                                  partyFields[index];

                              if (textFieldEntry.fieldType ==
                                  FieldType.dropdown) {
                                return DropDownFieldCustm(
                                  options: textFieldEntry.options,
                                  controller: textFieldEntry.controller!,
                                  focusNode: textFieldEntry.focusnode!,
                                  onDone: (str) {
                                    onValueSelected(textFieldEntry.keyId, str);
                                    textFieldEntry.isLast
                                        ? FocusScope.of(context).unfocus()
                                        : focusOnNextVisible(index);
                                  },
                                  validate: textFieldEntry.validate,
                                  label: textFieldEntry.label,
                                  showLabel: true,
                                );
                              }
                              if (textFieldEntry.fieldType == FieldType.text) {
                                return TextFieldCustm(
                                  controller: textFieldEntry.controller!,
                                  enabled: textFieldEntry.enabled,
                                  focusNode: textFieldEntry.focusnode!,
                                  onDone: (str) {
                                    onValueSelected(textFieldEntry.keyId, str);
                                    textFieldEntry.isLast
                                        ? FocusScope.of(context).unfocus()
                                        : focusOnNextVisible(index);
                                  },
                                  validate: textFieldEntry.validate,
                                  label: textFieldEntry.label,
                                  showLabel: true,
                                );
                              }
                              if (textFieldEntry.fieldType == FieldType.date) {
                                return const SizedBox(
                                  height: 0,
                                  width: 0,
                                );
                              }
                              return const SizedBox(
                                height: 0,
                                width: 0,
                              );
                            }),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ButtonCustm(
                          label: "Submit",
                          padding: 10,
                          function1: () {
                            final Map<String, dynamic> values = {
                              for (final element in partyFields)
                                element.label: element.controller?.text
                            };
                            if (_formKey.currentState!.validate()) {
                              dev.log(values.toString());
                            }
                          },
                        ),
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
