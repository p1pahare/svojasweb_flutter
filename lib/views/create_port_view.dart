import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/port/port_cubit.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/new_big_button.dart';
import 'package:svojasweb/utilities/textfield_entry_builder.dart';
import 'package:svojasweb/utilities/validations.dart';
import 'package:svojasweb/views/drawer_view.dart';
import 'package:svojasweb/views/port_view.dart';

class CreatePortView extends StatefulWidget {
  const CreatePortView({Key? key, required this.title}) : super(key: key);
  static const routeName = '/CreatePortView';
  final String title;
  @override
  State<CreatePortView> createState() => _CreatePortViewState();
}

class _CreatePortViewState extends State<CreatePortView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onValueSelected(String key, String? value) {
    dev.log("$key :   $value");
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

  Map<String, TextFieldEntry> portFields = {};

  void initParty() {
    portFields = {
      Values.port_code: TextFieldEntry(
        label: 'Port Code',
        keyId: Values.port_code,
      ),
      Values.port_type: TextFieldEntry(
        label: 'Port Type',
        fieldType: FieldType.dropdown,
        options: ['Select', 'Air', 'Ocean', 'Bus', 'Train'],
        keyId: Values.port_type,
      ),
      Values.port_name: TextFieldEntry(
        label: 'Port Name',
        keyId: Values.port_name,
      ),
      Values.state_name: TextFieldEntry(
        label: 'State Name',
        keyId: Values.state_name,
      ),
      Values.zip_code: TextFieldEntry(
        label: 'Zip Code',
        keyId: Values.zip_code,
        validate: isInteger,
      ),
    };
  }

  @override
  void initState() {
    initParty();

    GetIt.I<PortCubit>().loadPorts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      // drawer: const DrawerView(),
      body: SingleChildScrollView(
        child: BlocBuilder<PortCubit, PortState>(
          bloc: GetIt.I<PortCubit>(),
          builder: (context, state) {
            if (state is CreatePortLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            if (state is CreatePortFailed) {
              return Text(state.errorMessage!);
            }

            if (state is CreatePortSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.successMessage!),
                  BigButtonNew(
                      ttitle: 'View Ports Table',
                      onTap: () =>
                          Navigator.pushNamed(context, PortView.routeName)),
                ],
              );
            }
            if (state is PortInitial || state is ListSuccess) {
              return SizedBox(
                  // width: min(MediaQuery.of(context).size.width, 480),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BigButtonNew(
                              ttitle: 'View Port Table',
                              onTap: () => Navigator.pushNamed(
                                  context, PortView.routeName)),
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: List<Widget>.generate(portFields.length,
                                (index) {
                              return TextFieldEntryBuilder(
                                textFieldEntry:
                                    portFields.values.toList()[index],
                                onValueSelected: (key, value) =>
                                    onValueSelected(key!, value),
                                focusHandler: (isLast) {
                                  isLast
                                      ? FocusScope.of(context).unfocus()
                                      : focusOnNextVisible(index, portFields);
                                },
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
                                  for (final element in portFields.entries)
                                    if (element.value.controller?.text
                                            .isNotEmpty ??
                                        false)
                                      element.key:
                                          element.value.controller?.text
                                };
                                if (_formKey.currentState!.validate()) {
                                  dev.log(values.toString());

                                  GetIt.I<PortCubit>().create(values);
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
