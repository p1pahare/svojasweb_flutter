import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/dropdown_field_custom.dart';
import 'package:svojasweb/utilities/textfield_custm.dart';
import 'package:svojasweb/utilities/validations.dart';

class CreateQuoteView extends StatefulWidget {
  const CreateQuoteView({Key? key, this.quote}) : super(key: key);
  static const routeName = '/CreateQuoteView';
  static const routeNameEdit = '/EditQuoteView';
  final Quote? quote;
  @override
  State<CreateQuoteView> createState() => _CreateQuoteViewState();
}

class _CreateQuoteViewState extends State<CreateQuoteView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> fields = [
    {
      'type': "dropdown",
      'label': 'Party Type',
      'controller': TextEditingController(),
      'focusnode': FocusNode(),
      'options': ['Select', 'Customer', 'Trucker', 'Consignee', 'Shipper']
    },
    {
      'type': "textfield",
      'label': 'Party Name',
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    {
      'type': "textfield",
      'label': 'Company Name',
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
    {
      'type': "textfield",
      'label': 'Field XYZ',
      'controller': TextEditingController(),
      'focusnode': FocusNode()
    },
  ];

  @override
  void initState() {
    // if (widget.quote != null) {
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
          title: Text('${widget.quote == null ? 'Create' : 'Edit'} Quote')),
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
                            onDone: (str) => index == fields.length - 1
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
                            onDone: (str) => index == fields.length - 1
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
