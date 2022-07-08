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
      partyFields.forEach((key, value) {
        value.visible = false;
        value.isLast = false;
      });

      partyFields[Values.party_id]?.visible = true;
      partyFields[Values.date]?.visible = true;
      partyFields[Values.party_type]?.visible = true;
      partyFields[Values.party_name]?.visible = true;
      partyFields[Values.org_name]?.visible = true;
      partyFields[Values.city]?.visible = true;
      partyFields[Values.zip_code]?.visible = true;
      partyFields[Values.phone]?.visible = true;

      partyFields[Values.email_id]?.visible = true;
      switch (value?.toLowerCase()) {
        case 'customer':
          partyFields[Values.phone]?.isLast = true;
          break;
        case 'trucker':
          partyFields[Values.scac]?.visible = true;
          partyFields[Values.states]?.visible = true;
          partyFields[Values.haz]?.visible = true;
          partyFields[Values.overweight]?.visible = true;
          partyFields[Values.oog]?.visible = true;
          partyFields[Values.reefer]?.visible = true;
          partyFields[Values.transload_service]?.visible = true;
          partyFields[Values.insurance_expiry]?.visible = true;
          partyFields[Values.motor_carrier]?.visible = true;
          partyFields[Values.motor_carrier]?.isLast = true;
          break;
        case 'consignee':
        case 'shipper':
          partyFields[Values.delivery_appointment_needed]
            ?..visible = true
            ..isLast = true;

          break;
        default:
          dev.log("value error");
      }
    }
    if (key.toLowerCase() == Values.delivery_appointment_needed &&
        value?.toLowerCase() != 'select') {
      partyFields[Values.warehouse_timings_open]?.visible = true;
      partyFields[Values.warehouse_timings_open]?.label =
          value?.toLowerCase() == 'no'
              ? 'Warehouse Timings (Open)'
              : 'Appointment Timing';
      partyFields[Values.warehouse_timings_close]?.visible =
          value?.toLowerCase() == 'no' ? true : false;
    }

    setState(() {});
  }

  void focusOnNextVisible(int index) {
    for (int x = index; x < partyFields.length; x++) {
      if (partyFields.values.toList()[x].visible) {
        FocusScope.of(context)
            .requestFocus(partyFields.values.toList()[x].focusnode);
        break;
      }
    }
  }

  Map<String, TextFieldEntry> partyFields = {
    Values.party_id: TextFieldEntry(
        label: 'Party ID', keyId: Values.party_id, enabled: false),
    Values.date:
        TextFieldEntry(label: 'Date', keyId: Values.date, enabled: false),
    Values.party_type: TextFieldEntry(
        fieldType: FieldType.dropdown,
        options: ['Select', 'Customer', 'Trucker', 'Consignee', 'Shipper'],
        keyId: Values.party_type),
    Values.party_name: TextFieldEntry(
        label: 'Party Name', keyId: Values.party_name, visible: false),
    Values.org_name: TextFieldEntry(
        label: 'Company Name', keyId: Values.org_name, visible: false),
    Values.email_id: TextFieldEntry(
        label: 'Email Id', keyId: Values.email_id, visible: false),
    // "extra_contacts": List<Map<String, dynamic>>.empty(),
    Values.address:
        TextFieldEntry(label: 'Address', keyId: Values.address, visible: false),
    Values.zip_code: TextFieldEntry(
        label: 'Zip Code', keyId: Values.zip_code, visible: false),
    Values.city:
        TextFieldEntry(label: 'City', keyId: Values.city, visible: false),
    Values.phone:
        TextFieldEntry(label: 'Phone', keyId: Values.phone, visible: false),
    Values.scac: TextFieldEntry(
      label: 'SCAC',
      keyId: Values.scac,
      visible: false,
    ),
    Values.states: TextFieldEntry(
        label: 'States Served', keyId: Values.states, visible: false),
    Values.haz: TextFieldEntry(
        label: 'Haz',
        keyId: Values.haz,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    Values.overweight: TextFieldEntry(
        label: 'Overweight',
        keyId: Values.overweight,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    Values.oog: TextFieldEntry(
        label: 'OOG',
        keyId: Values.oog,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    Values.reefer: TextFieldEntry(
        label: 'Reefer',
        keyId: Values.reefer,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    Values.transload_service: TextFieldEntry(
        label: 'Transload Service',
        keyId: Values.transload_service,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    Values.delivery_appointment_needed: TextFieldEntry(
        label: 'Delivery Appointment Needed',
        keyId: Values.delivery_appointment_needed,
        fieldType: FieldType.dropdown,
        options: ['Select', 'Yes', 'No'],
        visible: false),
    Values.warehouse_timings_open: TextFieldEntry(
        label: 'Warehouse Timings (Open)',
        keyId: Values.warehouse_timings_open,
        fieldType: FieldType.date,
        isTime: true,
        visible: false),

    Values.warehouse_timings_close: TextFieldEntry(
        label: 'Warehouse Timings (Close)',
        keyId: Values.warehouse_timings_close,
        fieldType: FieldType.date,
        isTime: true,
        visible: false),
    Values.insurance_expiry: TextFieldEntry(
        label: 'Insurance Expiry',
        keyId: Values.insurance_expiry,
        fieldType: FieldType.date,
        visible: false),
    Values.motor_carrier: TextFieldEntry(
        label: 'Motor Carrier', keyId: Values.motor_carrier, visible: false),
  };

  Map<String, TextFieldEntry> extraContactsFields = {
    Values.party_name:
        TextFieldEntry(label: 'Contact Name', keyId: Values.party_name),
    Values.email_id: TextFieldEntry(label: 'Email Id', keyId: Values.email_id),
    Values.phone: TextFieldEntry(label: 'Phone', keyId: Values.phone),
  };

  @override
  void initState() {
    if (widget.party != null) {}
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
                partyFields[Values.date]?.controller?.text = state.date ?? '';
                partyFields[Values.party_id]?.controller?.text = state.id ?? '';
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
                                if (!partyFields.values
                                    .toList()[index]
                                    .visible) {
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
                                        partyFields.values.toList()[index];

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
                                    for (final element in partyFields.entries)
                                      element.key:
                                          element.value.controller?.text
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
