import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/create_party/create_party_cubit.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/datefield_custm.dart';
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
      partyFields[partyFields
              .indexWhere((element) => element.keyId == Values.party_id)]
          .visible = true;
      partyFields[
              partyFields.indexWhere((element) => element.keyId == Values.date)]
          .visible = true;
      partyFields[partyFields
              .indexWhere((element) => element.keyId == Values.party_type)]
          .visible = true;
      partyFields[partyFields
              .indexWhere((element) => element.keyId == Values.party_name)]
          .visible = true;
      partyFields[partyFields
              .indexWhere((element) => element.keyId == Values.org_name)]
          .visible = true;
      partyFields[
              partyFields.indexWhere((element) => element.keyId == Values.city)]
          .visible = true;
      partyFields[partyFields
              .indexWhere((element) => element.keyId == Values.zip_code)]
          .visible = true;
      partyFields[partyFields
              .indexWhere((element) => element.keyId == Values.phone)]
          .visible = true;

      partyFields[partyFields
              .indexWhere((element) => element.keyId == Values.email_id)]
          .visible = true;
      switch (value?.toLowerCase()) {
        case 'customer':
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == Values.phone)]
              .isLast = true;
          break;
        case 'trucker':
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == Values.scac)]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == Values.states)]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == Values.haz)]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == Values.overweight)]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == Values.oog)]
              .visible = true;
          partyFields[partyFields
                  .indexWhere((element) => element.keyId == Values.reefer)]
              .visible = true;
          partyFields[partyFields.indexWhere(
                  (element) => element.keyId == Values.transload_service)]
              .visible = true;
          partyFields[partyFields.indexWhere(
                  (element) => element.keyId == Values.insurance_expiry)]
              .visible = true;
          partyFields[partyFields.indexWhere(
                  (element) => element.keyId == Values.motor_carrier)]
              .visible = true;
          partyFields[partyFields.indexWhere(
                  (element) => element.keyId == Values.motor_carrier)]
              .isLast = true;
          break;
        case 'consignee':
        case 'shipper':
          partyFields[partyFields.indexWhere(
              (element) => element.keyId == Values.delivery_appointment_needed)]
            ..visible = true
            ..isLast = true;

          break;
        default:
          dev.log("value error");
      }
    }
    if (key.toLowerCase() == Values.delivery_appointment_needed &&
        value?.toLowerCase() != 'select') {
      partyFields[partyFields.indexWhere(
              (element) => element.keyId == Values.warehouse_timings_open)]
          .visible = true;
      partyFields[partyFields.indexWhere(
                  (element) => element.keyId == Values.warehouse_timings_open)]
              .label =
          value?.toLowerCase() == 'no'
              ? 'Warehouse Timings (Open)'
              : 'Appointment Timing';
      partyFields[partyFields.indexWhere(
              (element) => element.keyId == Values.warehouse_timings_close)]
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
    TextFieldEntry(label: 'Party ID', keyId: Values.party_id, enabled: false),
    TextFieldEntry(label: 'Date', keyId: Values.date, enabled: false),
    TextFieldEntry(
        fieldType: FieldType.dropdown,
        options: ['Select', 'Customer', 'Trucker', 'Consignee', 'Shipper'],
        keyId: Values.party_type),
    TextFieldEntry(
        label: 'Party Name', keyId: Values.party_name, visible: false),
    TextFieldEntry(
        label: 'Company Name', keyId: Values.org_name, visible: false),
    TextFieldEntry(label: 'Email Id', keyId: Values.email_id, visible: false),
    // "extra_contacts": List<Map<String, dynamic>>.empty(),
    TextFieldEntry(label: 'Address', keyId: Values.address, visible: false),
    TextFieldEntry(label: 'Zip Code', keyId: Values.zip_code, visible: false),
    TextFieldEntry(label: 'City', keyId: Values.city, visible: false),
    TextFieldEntry(label: 'Phone', keyId: Values.phone, visible: false),
    TextFieldEntry(label: 'SCAC', keyId: Values.scac, visible: false),
    TextFieldEntry(
        label: 'States Served', keyId: Values.states, visible: false),
    TextFieldEntry(
        label: 'Haz',
        keyId: Values.haz,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Overweight',
        keyId: Values.overweight,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'OOG',
        keyId: Values.oog,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Reefer',
        keyId: Values.reefer,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Transload Service',
        keyId: Values.transload_service,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Delivery Appointment Needed',
        keyId: Values.delivery_appointment_needed,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    TextFieldEntry(
        label: 'Warehouse Timings (Open)',
        keyId: Values.warehouse_timings_open,
        fieldType: FieldType.date,
        isTime: true,
        visible: false),

    TextFieldEntry(
        label: 'Warehouse Timings (Close)',
        keyId: Values.warehouse_timings_close,
        fieldType: FieldType.date,
        isTime: true,
        visible: false),
    TextFieldEntry(
        label: 'Insurance Expiry',
        keyId: Values.insurance_expiry,
        fieldType: FieldType.date,
        visible: false),
    TextFieldEntry(
        label: 'Motor Carrier', keyId: Values.motor_carrier, visible: false),
  ];

  List<TextFieldEntry> extraContactsFields = [
    TextFieldEntry(label: 'Contact Name', keyId: Values.party_name),
    TextFieldEntry(label: 'Email Id', keyId: Values.email_id),
    TextFieldEntry(label: 'Phone', keyId: Values.phone),
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
    GetIt.I<CreatePartyCubit>().load();
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
          child: BlocBuilder<CreatePartyCubit, CreatePartyState>(
            bloc: GetIt.I<CreatePartyCubit>(),
            builder: (context, state) {
              if (state is CreatePartyLoading) {
                return const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                );
              }
              if (state is CreatePartyFailed) {
                return Text(state.errorMessage!);
              }
              if (state is CreatePartySuccess) {
                partyFields[partyFields
                        .indexWhere((element) => element.keyId == Values.date)]
                    .controller
                    ?.text = state.date ?? '';
                partyFields[partyFields.indexWhere(
                        (element) => element.keyId == Values.party_id)]
                    .controller
                    ?.text = state.id ?? '';
                return SizedBox(
                    // width: min(MediaQuery.of(context).size.width, 480),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              children: List<Widget>.generate(
                                  partyFields.length, (index) {
                                if (!partyFields[index].visible) {
                                  return const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                                }
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: min(460,
                                      MediaQuery.of(context).size.width - 40),
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
                                          onValueSelected(
                                              textFieldEntry.keyId, str);
                                          textFieldEntry.isLast
                                              ? FocusScope.of(context).unfocus()
                                              : focusOnNextVisible(index);
                                        },
                                        validate: textFieldEntry.validate,
                                        label: textFieldEntry.label,
                                        showLabel: true,
                                      );
                                    }
                                    if (textFieldEntry.fieldType ==
                                        FieldType.text) {
                                      return TextFieldCustm(
                                        controller: textFieldEntry.controller!,
                                        enabled: textFieldEntry.enabled,
                                        focusNode: textFieldEntry.focusnode!,
                                        onDone: (str) {
                                          onValueSelected(
                                              textFieldEntry.keyId, str);
                                          textFieldEntry.isLast
                                              ? FocusScope.of(context).unfocus()
                                              : focusOnNextVisible(index);
                                        },
                                        validate: textFieldEntry.validate,
                                        label: textFieldEntry.label,
                                        showLabel: true,
                                      );
                                    }
                                    if (textFieldEntry.fieldType ==
                                        FieldType.date) {
                                      return DateFieldCustm(
                                        controller: textFieldEntry.controller!,
                                        enabled: textFieldEntry.enabled,
                                        focusNode: textFieldEntry.focusnode!,
                                        isTime: textFieldEntry.isTime,
                                        onDone: (str) {
                                          onValueSelected(textFieldEntry.keyId,
                                              str?.toString());
                                          textFieldEntry.isLast
                                              ? FocusScope.of(context).unfocus()
                                              : focusOnNextVisible(index);
                                        },
                                        validate: textFieldEntry.validate,
                                        label: textFieldEntry.label,
                                        showLabel: true,
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
                        )));
              }
              return const SizedBox(
                height: 0,
                width: 0,
              );
            },
          ),
        ),
      ),
    );
  }
}
