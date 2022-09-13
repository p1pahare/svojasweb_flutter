import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:svojasweb/blocs/create_party/create_party_cubit.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/new_big_button.dart';
import 'package:svojasweb/utilities/textfield_entry_builder.dart';
import 'package:svojasweb/utilities/validations.dart';
import 'package:svojasweb/views/drawer_view.dart';
import 'package:svojasweb/views/party_view.dart';

class CreatePartyView extends StatefulWidget {
  const CreatePartyView({Key? key, this.party, required this.title})
      : super(key: key);
  static const routeName = '/CreatePartyView';
  static const routeNameEdit = '/EditPartyView';
  final Party? party;
  final String title;
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

      partyFields[Values.party_id]?.visible = false;
      partyFields[Values.date]?.visible = false;
      partyFields[Values.party_type]?.visible = true;
      partyFields[Values.party_name]?.visible = true;
      partyFields[Values.org_name]?.visible = true;
      partyFields[Values.address]?.visible = true;
      partyFields[Values.city]?.visible = true;
      partyFields[Values.state]?.visible = true;
      partyFields[Values.zip_code]?.visible = true;
      partyFields[Values.phone]?.visible = true;

      partyFields[Values.email_id]?.visible = true;
      switch (value?.toLowerCase()) {
        case 'customer':
          partyFields[Values.phone]?.isLast = true;
          break;
        case 'trucker':
          partyFields[Values.scac]?.visible = true;
          partyFields[Values.port]?.visible = true;
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
    if (key == Values.port) {
      partyFields[Values.port]?.controller?.text = value.toString();
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

  void focusOnNextVisible(int index, Map<String, TextFieldEntry> fields) {
    for (int x = index + 1; x < fields.length; x++) {
      if (fields.values.toList()[x].visible) {
        FocusScope.of(context)
            .requestFocus(fields.values.toList()[x].focusnode);
        break;
      }
    }
  }

  String servertoFormatTime(String? datee) {
    if (datee == null || datee.isEmpty) {
      return '';
    } else {
      return DateFormat("h:mm a").format(DateTime.parse(datee));
    }
  }

  String servertoFormatDate(String? datee) {
    if (datee == null || datee.isEmpty) {
      return '';
    } else {
      return DateFormat.yMMMd().format(DateTime.parse(datee));
    }
  }

  Map<String, TextFieldEntry> partyFields = {};
  Map<String, TextFieldEntry> extraContactsFields = {};
  List<Map<String, TextFieldEntry>> extraContacts = [];

  void initParty() {
    partyFields = {
      Values.party_id: TextFieldEntry(
          label: 'Party ID',
          keyId: Values.party_id,
          enabled: false,
          visible: false,
          controller: TextEditingController(text: widget.party?.sid)),
      Values.date: TextFieldEntry(
          label: 'Date',
          keyId: Values.date,
          enabled: false,
          visible: false,
          controller: TextEditingController(text: widget.party?.date)),
      Values.party_type: TextFieldEntry(
          fieldType: FieldType.dropdown,
          options: ['Select', 'Customer', 'Trucker', 'Consignee', 'Shipper'],
          keyId: Values.party_type,
          controller: TextEditingController(text: widget.party?.partyType)),
      Values.party_name: TextFieldEntry(
          label: 'Party Name',
          keyId: Values.party_name,
          visible: false,
          controller: TextEditingController(text: widget.party?.partyName)),
      Values.org_name: TextFieldEntry(
          label: 'Company Name',
          keyId: Values.org_name,
          visible: false,
          controller: TextEditingController(text: widget.party?.orgName)),
      Values.email_id: TextFieldEntry(
          label: 'Email Id',
          keyId: Values.email_id,
          validate: isEmail,
          visible: false,
          controller: TextEditingController(text: widget.party?.emailId)),
      // "extra_contacts": List<Map<String, dynamic>>.empty(),
      Values.address: TextFieldEntry(
          label: 'Address',
          keyId: Values.address,
          visible: false,
          controller: TextEditingController(text: widget.party?.address)),

      Values.port: TextFieldEntry(
          label: 'Port',
          keyId: Values.port,
          visible: false,
          fieldType: FieldType.autocomplete,
          optionListing: (textValue) =>
              GetIt.I<CreatePartyCubit>().getPorts(textValue),
          controller: TextEditingController(text: widget.party?.port)),

      Values.city: TextFieldEntry(
          label: 'City',
          keyId: Values.city,
          visible: false,
          controller: TextEditingController(text: widget.party?.city)),
      Values.state: TextFieldEntry(
          label: 'State',
          keyId: Values.state,
          visible: false,
          controller: TextEditingController(text: widget.party?.state)),
      Values.zip_code: TextFieldEntry(
          label: 'Zip Code',
          keyId: Values.zip_code,
          validate: isInteger,
          visible: false,
          controller: TextEditingController(text: widget.party?.zipCode)),
      Values.phone: TextFieldEntry(
          label: 'Phone',
          keyId: Values.phone,
          visible: false,
          controller: TextEditingController(text: widget.party?.phone)),
      Values.scac: TextFieldEntry(
          label: 'SCAC',
          keyId: Values.scac,
          visible: false,
          controller: TextEditingController(text: widget.party?.scac)),
      Values.states: TextFieldEntry(
          label: 'States Served',
          keyId: Values.states,
          visible: false,
          controller: TextEditingController(text: widget.party?.states)),
      Values.haz: TextFieldEntry(
          label: 'Haz',
          keyId: Values.haz,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Yes', 'No'],
          visible: false,
          controller: TextEditingController(
              text: widget.party?.haz == null
                  ? ''
                  : widget.party?.haz ?? false
                      ? 'Yes'
                      : 'No')),
      Values.overweight: TextFieldEntry(
          label: 'Overweight',
          keyId: Values.overweight,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Yes', 'No'],
          visible: false,
          controller: TextEditingController(
              text: widget.party?.overweight == null
                  ? ''
                  : widget.party?.overweight ?? false
                      ? 'Yes'
                      : 'No')),
      Values.oog: TextFieldEntry(
          label: 'OOG',
          keyId: Values.oog,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Yes', 'No'],
          visible: false,
          controller: TextEditingController(
              text: widget.party?.oog == null
                  ? ''
                  : widget.party?.oog ?? false
                      ? 'Yes'
                      : 'No')),
      Values.reefer: TextFieldEntry(
          label: 'Reefer',
          keyId: Values.reefer,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Yes', 'No'],
          visible: false,
          controller: TextEditingController(
              text: widget.party?.reefer == null
                  ? ''
                  : widget.party?.reefer ?? false
                      ? 'Yes'
                      : 'No')),
      Values.transload_service: TextFieldEntry(
          label: 'Transload Service',
          keyId: Values.transload_service,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Yes', 'No'],
          visible: false,
          controller: TextEditingController(
              text: widget.party?.transloadService == null
                  ? ''
                  : widget.party?.transloadService ?? false
                      ? 'Yes'
                      : 'No')),
      Values.delivery_appointment_needed: TextFieldEntry(
          label: 'Delivery Appointment Needed',
          keyId: Values.delivery_appointment_needed,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Yes', 'No'],
          visible: false,
          controller: TextEditingController(
              text: widget.party?.deliveryAppointmentNeeded == null
                  ? ''
                  : widget.party?.deliveryAppointmentNeeded ?? false
                      ? 'Yes'
                      : 'No')),
      Values.warehouse_timings_open: TextFieldEntry(
          label: 'Warehouse Timings (Open)',
          keyId: Values.warehouse_timings_open,
          fieldType: FieldType.date,
          isTime: true,
          visible: false,
          controller: TextEditingController(
              text: servertoFormatTime(widget.party?.warehouseTimingsOpen))),

      Values.warehouse_timings_close: TextFieldEntry(
          label: 'Warehouse Timings (Close)',
          keyId: Values.warehouse_timings_close,
          fieldType: FieldType.date,
          isTime: true,
          visible: false,
          controller: TextEditingController(
              text: servertoFormatTime(widget.party?.warehouseTimingsClose))),
      Values.insurance_expiry: TextFieldEntry(
          label: 'Insurance Expiry',
          keyId: Values.insurance_expiry,
          fieldType: FieldType.date,
          visible: false,
          controller: TextEditingController(
              text: servertoFormatDate(widget.party?.insuranceExpiry))),
      Values.motor_carrier: TextFieldEntry(
          label: 'Motor Carrier',
          keyId: Values.motor_carrier,
          visible: false,
          controller: TextEditingController(text: widget.party?.motorCarrier)),
    };
  }

  void initExtraContacts({ExtraContacts? extraContact}) {
    extraContactsFields = {
      Values.party_name: TextFieldEntry(
          label: 'Contact Name',
          keyId: Values.party_name,
          controller: TextEditingController(text: extraContact?.partyName)),
      Values.email_id: TextFieldEntry(
          label: 'Email Id',
          keyId: Values.email_id,
          validate: isEmail,
          controller: TextEditingController(text: extraContact?.emailId)),
      Values.phone: TextFieldEntry(
          label: 'Phone',
          keyId: Values.phone,
          isLast: true,
          controller: TextEditingController(text: extraContact?.phone)),
    };
  }

  @override
  void initState() {
    initParty();
    initExtraContacts();
    if (widget.party != null) {
      onValueSelected(Values.party_type, widget.party?.partyType);
      onValueSelected(
          Values.delivery_appointment_needed,
          widget.party?.deliveryAppointmentNeeded == null
              ? 'Select'
              : widget.party?.deliveryAppointmentNeeded ?? false
                  ? 'Yes'
                  : 'No');
      if (widget.party?.extraContacts.isNotEmpty ?? false) {
        for (final extraC in widget.party!.extraContacts) {
          initExtraContacts(extraContact: extraC);
          extraContacts.add(extraContactsFields);
        }
      }
    }
    GetIt.I<CreatePartyCubit>().load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      // drawer: const DrawerView(),
      body: SingleChildScrollView(
        child: BlocBuilder<CreatePartyCubit, CreatePartyState>(
          bloc: GetIt.I<CreatePartyCubit>(),
          builder: (context, state) {
            if (state is CreatePartyLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            if (state is CreatePartyFailed) {
              return Text(state.errorMessage!);
            }

            if (state is CreatePartySuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.successMessage!),
                  BigButtonNew(
                      ttitle: 'View Parties Table',
                      onTap: () =>
                          Navigator.pushNamed(context, PartyView.routeName)),
                ],
              );
            }
            if (state is CreatePageSuccess) {
              partyFields[Values.date]?.controller?.text = state.date ?? '';
              partyFields[Values.party_id]?.controller?.text =
                  widget.party?.sid ?? state.id ?? '';
              return SizedBox(
                  // width: min(MediaQuery.of(context).size.width, 480),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BigButtonNew(
                              ttitle: 'View Parties Table',
                              onTap: () => Navigator.pushNamed(
                                  context, PartyView.routeName)),
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: List<Widget>.generate(partyFields.length,
                                (index) {
                              return TextFieldEntryBuilder(
                                textFieldEntry:
                                    partyFields.values.toList()[index],
                                onValueSelected: (key, value) =>
                                    onValueSelected(key!, value),
                                focusHandler: (isLast) {
                                  isLast
                                      ? FocusScope.of(context).unfocus()
                                      : focusOnNextVisible(index, partyFields);
                                },
                              );
                            }),
                          ),
                          Container(
                            margin: const EdgeInsets.all(40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Extra Contact",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22),
                                ),
                                Flexible(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                  ),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      shape: const CircleBorder(),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.add_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        extraContacts.add(extraContactsFields);
                                        initExtraContacts();
                                      });
                                    }),
                              ],
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: extraContacts.length,
                              itemBuilder: (context, index0) {
                                return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    width: min(460,
                                        MediaQuery.of(context).size.width - 40),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  extraContactsFields.length +
                                                      1,
                                              itemBuilder: (context, index) {
                                                if (index ==
                                                    extraContactsFields
                                                        .length) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          shape:
                                                              const CircleBorder(),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Icon(
                                                            Icons
                                                                .remove_circle_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            extraContacts
                                                                .removeAt(
                                                                    index0);
                                                          });
                                                        }),
                                                  );
                                                }
                                                return TextFieldEntryBuilder(
                                                  textFieldEntry:
                                                      extraContacts[index0]
                                                          .values
                                                          .toList()[index],
                                                  onValueSelected:
                                                      (key, value) =>
                                                          onValueSelected(
                                                              key!, value),
                                                  focusHandler: (isLast) {
                                                    isLast
                                                        ? FocusScope.of(context)
                                                            .unfocus()
                                                        : focusOnNextVisible(
                                                            index,
                                                            extraContacts[
                                                                index0]);
                                                  },
                                                );
                                              }),
                                        )));
                              }),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ButtonCustm(
                              label: "Submit",
                              padding: 10,
                              function1: () {
                                final Map<String, dynamic> values = {
                                  for (final element in partyFields.entries)
                                    if (element.value.controller?.text
                                            .isNotEmpty ??
                                        false)
                                      if (element.value.fieldType ==
                                          FieldType.dropdown)
                                        element.key: element
                                                    .value.controller?.text ==
                                                'Yes'
                                            ? true
                                            : element.value.controller?.text ==
                                                    'No'
                                                ? false
                                                : element.value.controller?.text
                                      else if (element.value.fieldType ==
                                          FieldType.date)
                                        element.key: element.value.isTime
                                            ? DateFormat("h:mm a")
                                                .parse(element.value.controller
                                                        ?.text ??
                                                    '12 AM')
                                                .toIso8601String()
                                            : DateFormat.yMMMd()
                                                .parse(element.value.controller
                                                        ?.text ??
                                                    'Jul 23Retr, 2022')
                                                .toIso8601String()
                                      else
                                        element.key:
                                            element.value.controller?.text
                                };
                                if (_formKey.currentState!.validate()) {
                                  dev.log(values.toString());
                                  values[Values.extra_contacts] = extraContacts
                                      .map<Map<String, dynamic>>((e) =>
                                          e.map<String, dynamic>((key, value) =>
                                              MapEntry(
                                                  key, value.controller?.text)))
                                      .toList();
                                  if (widget.party == null) {
                                    GetIt.I<CreatePartyCubit>().create(values);
                                  } else {
                                    GetIt.I<CreatePartyCubit>().edit(values);
                                  }
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
      drawer: const DrawerView(),
    );
  }
}
