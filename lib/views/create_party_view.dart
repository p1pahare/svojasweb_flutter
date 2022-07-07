import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/dropdown_field_custom.dart';
import 'package:svojasweb/utilities/textfield_custm.dart';
import 'package:svojasweb/utilities/validations.dart';

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
  Map<String, dynamic> partyFields = {
    "party_id": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "date": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "party_type": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "party_name": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "org_name": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "email_id": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "extra_contacts": List<Map<String, dynamic>>.empty(),
    "address": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "zip_code": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "city": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "phone": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "scac": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "states": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "haz": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "overweight": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "oog": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "reefer": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "transload_service": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "delivery_appointment_needed": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "warehouse_timings_open": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "warehouse_timings_close": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "insurance_expiry": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    "motor_carrier": {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
  };

  Map<String, dynamic> extraContactsFields = {
    'party_name': TextEditingController(),
    'email_id': TextEditingController(),
    'phone': TextEditingController(),
  };
  List<Map<String, dynamic>> fields = [
    {
      'type': "textfield",
      'label': 'Party Name',
      'enabled': true,
      "obscure": false,
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    {
      'type': "dropdown",
      'label': 'Party Type',
      'key': 'party_type',
      'controller': TextEditingController(),
      'focusnode': FocusNode(),
      'options': ['Select', 'Customer', 'Trucker', 'Consignee', 'Shipper']
    },
    {
      'type': "textfield",
      'label': 'Party Name',
      'key': 'party_type',
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    {
      'type': "textfield",
      'label': 'Company Name',
      'key': 'party_type',
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    {
      'type': "textfield",
      'label': 'Field XYZ',
      'key': 'party_type',
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
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
            width: min(MediaQuery.of(context).size.width, 480),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: List<Widget>.generate(fields.length, (index) {
                        if (fields[index]['type'] == 'dropdown') {
                          return DropDownFieldCustm(
                            options: fields[index]['options'],
                            controller: fields[index]['controller'],
                            focusNode: fields[index]['focusnode']!,
                            onDone: () => index == fields.length - 1
                                ? FocusScope.of(context).unfocus()
                                : FocusScope.of(context).requestFocus(
                                    fields[index + 1]['focusnode']),
                            validate: isNotBlank,
                            label: fields[index]['label'],
                            showLabel: true,
                          );
                        }
                        if (fields[index]['type'] == 'textfield') {
                          return TextFieldCustm(
                            controller: fields[index]['controller'],
                            focusNode: fields[index]['focusnode']!,
                            onDone: () => index == fields.length - 1
                                ? FocusScope.of(context).unfocus()
                                : FocusScope.of(context).requestFocus(
                                    fields[index + 1]['focusnode']),
                            validate: isNotBlank,
                            label: fields[index]['label'],
                            showLabel: true,
                          );
                        }
                        return const SizedBox(
                          height: 0,
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
                            for (final element in fields)
                              element['label']: element['controller'].text
                          };
                          if (_formKey.currentState!.validate()) {
                            dev.log(values.toString());
                          }
                        },
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
