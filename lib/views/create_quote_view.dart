import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/create_quote/create_quote_cubit.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/textfield_entry_builder.dart';
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

  void onValueSelected(String key, String? value, {bool clear = true}) {
    switch (key) {
      case Values.type_of_move:
        quoteFields.forEach((key, value) {
          if (![Values.date, Values.quote_number, Values.type_of_move]
              .contains(key)) {
            value.visible = false;
            value.isLast = false;
          }
        });
        if (value == 'Ocean') {
          quoteFields[Values.transit_type]?.visible = true;
          if (clear) {
            quoteFields[Values.transit_type]?.controller?.clear();
          }
          quoteFields[Values.transit_type]?.options = [
            'Select',
            'Import',
            'Export'
          ];
        }
        if (value == 'Air') {
          quoteFields[Values.transit_type]?.visible = true;
          if (clear) {
            quoteFields[Values.transit_type]?.controller?.clear();
          }
          quoteFields[Values.transit_type]?.options = [
            'Select',
            'Import',
            'Export'
          ];
        }
        if (value == 'Inland') {
          quoteFields[Values.transit_type]?.visible = true;
          if (clear) {
            quoteFields[Values.transit_type]?.controller?.clear();
          }
          quoteFields[Values.transit_type]?.options = ['Select', 'LTL', 'FTL'];
        }
        break;
      case Values.transit_type:
        quoteFields[Values.transit_type]?.visible = true;
        quoteFields.forEach((key, value) {
          if (![
            Values.date,
            Values.quote_number,
            Values.type_of_move,
            Values.transit_type
          ].contains(key)) {
            value.visible = false;
            value.isLast = false;
          }
        });
        if (value == 'Import') {
          if (quoteFields[Values.type_of_move]?.controller?.text == 'Ocean') {
            quoteFields[Values.pickup_ramp]?.visible = true;
            quoteFields[Values.delivery_address]?.visible = true;
            quoteFields[Values.delivery_city]?.visible = true;
            quoteFields[Values.delivery_state]?.visible = true;
            quoteFields[Values.delivery_zip]?.visible = true;
            quoteFields[Values.size_of_container]?.visible = true;
            quoteFields[Values.type_of_container]?.visible = true;
            quoteFields[Values.gross_weight]?.visible = true;
            quoteFields[Values.commodity]?.visible = true;
            quoteFields[Values.haz]?.visible = true;
            quoteFields[Values.reefer]?.visible = true;
            quoteFields[Values.reefer]?.isLast = true;
          }
          if (quoteFields[Values.type_of_move]?.controller?.text == 'Air') {
            quoteFields[Values.pickup_ramp]?.visible = true;
            quoteFields[Values.delivery_address]?.visible = true;
            quoteFields[Values.delivery_city]?.visible = true;
            quoteFields[Values.delivery_state]?.visible = true;
            quoteFields[Values.delivery_zip]?.visible = true;
            quoteFields[Values.gross_weight]?.visible = true;
            quoteFields[Values.commodity]?.visible = true;
            quoteFields[Values.haz]?.visible = true;
            quoteFields[Values.reefer]?.visible = true;
            quoteFields[Values.reefer]?.isLast = true;
          }
        }
        if (value == 'Export') {
          if (quoteFields[Values.type_of_move]?.controller?.text == 'Ocean') {
            quoteFields[Values.delivery_ramp]?.visible = true;
            quoteFields[Values.pickup_address]?.visible = true;
            quoteFields[Values.pickup_city]?.visible = true;
            quoteFields[Values.pickup_state]?.visible = true;
            quoteFields[Values.pickup_zip]?.visible = true;
            quoteFields[Values.size_of_container]?.visible = true;
            quoteFields[Values.type_of_container]?.visible = true;
            quoteFields[Values.gross_weight]?.visible = true;
            quoteFields[Values.commodity]?.visible = true;
            quoteFields[Values.haz]?.visible = true;
            quoteFields[Values.reefer]?.visible = true;
            quoteFields[Values.reefer]?.isLast = true;
          }
          if (quoteFields[Values.type_of_move]?.controller?.text == 'Air') {
            quoteFields[Values.delivery_ramp]?.visible = true;
            quoteFields[Values.pickup_address]?.visible = true;
            quoteFields[Values.pickup_city]?.visible = true;
            quoteFields[Values.pickup_state]?.visible = true;
            quoteFields[Values.pickup_zip]?.visible = true;
            quoteFields[Values.gross_weight]?.visible = true;
            quoteFields[Values.commodity]?.visible = true;
            quoteFields[Values.haz]?.visible = true;
            quoteFields[Values.reefer]?.visible = true;
            quoteFields[Values.reefer]?.isLast = true;
          }
        }
        if (value == 'LTL' || value == 'FTL') {
          quoteFields[Values.delivery_address]?.visible = true;
          quoteFields[Values.delivery_city]?.visible = true;
          quoteFields[Values.delivery_state]?.visible = true;
          quoteFields[Values.delivery_zip]?.visible = true;
          quoteFields[Values.pickup_address]?.visible = true;
          quoteFields[Values.pickup_city]?.visible = true;
          quoteFields[Values.pickup_state]?.visible = true;
          quoteFields[Values.pickup_zip]?.visible = true;
          quoteFields[Values.gross_weight]?.visible = true;
          quoteFields[Values.commodity]?.visible = true;
          quoteFields[Values.haz]?.visible = true;
          quoteFields[Values.reefer]?.visible = true;
          quoteFields[Values.reefer]?.isLast = true;
          if (value == 'FTL') {
            quoteFields[Values.type_of_equipment]?.visible = true;
            quoteFields[Values.type_of_equipment]?.isLast = true;
          }
        }

        break;
      case Values.haz:
        if (value == 'Yes') {
          quoteFields[Values.haz_un_number]?.visible = true;
          quoteFields[Values.haz_class]?.visible = true;
          quoteFields[Values.haz_proper_shipping_name]?.visible = true;
          if (quoteFields[Values.reefer]?.controller?.text == 'Yes') {
            quoteFields[Values.reefer_temp]?.isLast = true;
            quoteFields[Values.haz_proper_shipping_name]?.isLast = false;
          }
          if (quoteFields[Values.reefer]?.controller?.text == 'No') {
            quoteFields[Values.reefer_temp]?.isLast = false;
            quoteFields[Values.haz_proper_shipping_name]?.isLast = true;
          }
        }
        if (value == 'No') {
          quoteFields[Values.haz_un_number]?.visible = false;
          quoteFields[Values.haz_class]?.visible = false;
          quoteFields[Values.haz_proper_shipping_name]?.visible = false;
        }
        break;
      case Values.reefer:
        if (value == 'Yes') {
          quoteFields[Values.reefer_temp]?.visible = true;
          quoteFields[Values.reefer_temp]?.isLast = true;
          quoteFields[Values.haz_proper_shipping_name]?.isLast = false;
        }
        if (value == 'No') {
          quoteFields[Values.reefer_temp]?.visible = false;
          quoteFields[Values.reefer_temp]?.isLast = false;
          quoteFields[Values.haz_proper_shipping_name]?.isLast = true;
        }
        break;
      default:
    }
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

  Map<String, TextFieldEntry> quoteFields = {};
  Map<String, TextFieldEntry> packageFields = {};
  List<Map<String, TextFieldEntry>> packages = [];

  void initQuote() {
    quoteFields = {
      Values.date: TextFieldEntry(
          label: 'Date',
          keyId: Values.date,
          enabled: false,
          controller: TextEditingController(text: widget.quote?.date)),
      Values.quote_number: TextFieldEntry(
          label: 'Quote Number',
          keyId: Values.quote_number,
          enabled: false,
          controller: TextEditingController(text: widget.quote?.sid)),
      Values.type_of_move: TextFieldEntry(
          label: 'Type Of Move',
          keyId: Values.type_of_move,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Ocean', 'Air', 'Inland'],
          controller: TextEditingController(text: widget.quote?.typeOfMove)),
      Values.transit_type: TextFieldEntry(
          label: 'Transit Type',
          keyId: Values.transit_type,
          fieldType: FieldType.dropdown,
          visible: false,
          options: [
            'Select',
            'Import',
            'Export',
            'LTL',
            'FTL',
          ],
          controller: TextEditingController(text: widget.quote?.transitType)),
      Values.pickup_ramp: TextFieldEntry(
          label: 'Pickup Port',
          keyId: Values.pickup_ramp,
          fieldType: FieldType.dropdown,
          visible: false,
          options: [
            'Select',
            'Airport 1',
            'Airport 2',
            'Airport 3',
            'Airport 4',
          ],
          controller: TextEditingController(text: widget.quote?.pickupRamp)),
      Values.delivery_ramp: TextFieldEntry(
          label: 'Delivery Port',
          keyId: Values.delivery_ramp,
          fieldType: FieldType.dropdown,
          visible: false,
          options: [
            'Select',
            'Airport 1',
            'Airport 2',
            'Airport 3',
            'Airport 4',
          ],
          controller: TextEditingController(text: widget.quote?.deliveryRamp)),
      Values.delivery_address: TextFieldEntry(
          label: 'Delivery Address',
          keyId: Values.delivery_address,
          visible: false,
          controller:
              TextEditingController(text: widget.quote?.deliveryAddress)),
      Values.delivery_city: TextFieldEntry(
          label: 'Delivery City',
          keyId: Values.delivery_city,
          visible: false,
          controller: TextEditingController(text: widget.quote?.deliveryCity)),
      Values.delivery_state: TextFieldEntry(
          label: 'Delivery State',
          keyId: Values.delivery_state,
          visible: false,
          controller: TextEditingController(text: widget.quote?.deliveryState)),
      Values.delivery_zip: TextFieldEntry(
          label: 'Delivery Zipcode',
          keyId: Values.delivery_zip,
          visible: false,
          validate: isInteger,
          controller: TextEditingController(text: widget.quote?.deliveryZip)),
      Values.pickup_address: TextFieldEntry(
          label: 'Pickup Address',
          keyId: Values.pickup_address,
          visible: false,
          controller: TextEditingController(text: widget.quote?.pickupAddress)),
      Values.pickup_city: TextFieldEntry(
          label: 'Pickup City',
          keyId: Values.pickup_city,
          visible: false,
          controller: TextEditingController(text: widget.quote?.pickupCity)),
      Values.pickup_state: TextFieldEntry(
          label: 'Pickup State',
          keyId: Values.pickup_state,
          visible: false,
          controller: TextEditingController(text: widget.quote?.pickupState)),
      Values.pickup_zip: TextFieldEntry(
          label: 'Pickup Zipcode',
          keyId: Values.pickup_zip,
          visible: false,
          validate: isInteger,
          controller: TextEditingController(text: widget.quote?.pickupZip)),
      Values.commodity: TextFieldEntry(
          label: 'Commodity',
          keyId: Values.commodity,
          visible: false,
          controller: TextEditingController(text: widget.quote?.commodity)),
      Values.size_of_container: TextFieldEntry(
          label: 'Size of Container',
          keyId: Values.delivery_ramp,
          fieldType: FieldType.dropdown,
          visible: false,
          options: [
            'Select',
            '20\'',
            '40\'',
            '45\'',
          ],
          controller:
              TextEditingController(text: widget.quote?.sizeOfContainer)),
      Values.type_of_container: TextFieldEntry(
          label: 'Size of Container',
          keyId: Values.type_of_container,
          fieldType: FieldType.dropdown,
          visible: false,
          options: [
            'Select',
            'Standart',
            'High Cube',
            'Reefer',
            'Open Top',
            'Flat Rack',
            'ISO Tank'
          ],
          controller:
              TextEditingController(text: widget.quote?.typeOfContainer)),
      Values.gross_weight: TextFieldEntry(
          label: 'Gross Weight',
          keyId: Values.gross_weight,
          fieldType:
              ['', 'Legal', 'Overweight'].contains(widget.quote?.grossWeight)
                  ? FieldType.dropdown
                  : FieldType.text,
          visible: false,
          options: ['Select', 'Legal', 'Overweight', 'Manual (Custom)'],
          controller: TextEditingController(text: widget.quote?.grossWeight)),
      Values.haz: TextFieldEntry(
          label: 'Haz',
          keyId: Values.haz,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Yes', 'No'],
          visible: false,
          controller: TextEditingController(
              text: widget.quote?.haz == null
                  ? ''
                  : widget.quote?.haz ?? false
                      ? 'Yes'
                      : 'No')),
      Values.haz_un_number: TextFieldEntry(
          label: 'Haz UN Number',
          keyId: Values.haz_un_number,
          visible: false,
          controller: TextEditingController(text: widget.quote?.hazUnNumber)),
      Values.haz_class: TextFieldEntry(
          label: 'Haz Class',
          keyId: Values.haz_class,
          fieldType: FieldType.dropdown,
          visible: false,
          options: [
            'Select',
            ...List<String>.generate(9, (index) => "Class ${index + 1}")
          ],
          controller: TextEditingController(text: widget.quote?.hazClass)),
      Values.haz_proper_shipping_name: TextFieldEntry(
          label: 'Proper Shipping Name',
          keyId: Values.haz_proper_shipping_name,
          visible: false,
          controller:
              TextEditingController(text: widget.quote?.hazProperShippingName)),
      Values.reefer: TextFieldEntry(
          label: 'Reefer',
          keyId: Values.reefer,
          fieldType: FieldType.dropdown,
          options: ['Select', 'Yes', 'No'],
          visible: false,
          controller: TextEditingController(
              text: widget.quote?.reefer == null
                  ? ''
                  : widget.quote?.reefer ?? false
                      ? 'Yes'
                      : 'No')),
      Values.reefer_temp: TextFieldEntry(
          label: 'Reefer Temperature (In Celsius)',
          keyId: Values.reefer_temp,
          visible: false,
          controller: TextEditingController(text: widget.quote?.reeferTemp)),
      Values.type_of_equipment: TextFieldEntry(
          label: 'Type of Equipment',
          keyId: Values.type_of_equipment,
          visible: false,
          controller:
              TextEditingController(text: widget.quote?.typeOfEquipment)),
    };
  }

  void initPackage() {
    packageFields = {
      Values.package_no: TextFieldEntry(
          label: 'Package Number',
          keyId: Values.package_no,
          enabled: false,
          controller:
              TextEditingController(text: (packages.length + 1).toString())),
      Values.height: TextFieldEntry(
          label: 'Package Height (H)',
          keyId: Values.height,
          validate: isDouble),
      Values.length: TextFieldEntry(
          label: 'Package Length (L)',
          keyId: Values.length,
          validate: isDouble),
      Values.width: TextFieldEntry(
          label: 'Package Width (W)', keyId: Values.width, validate: isDouble),
      Values.weight: TextFieldEntry(
          label: 'Package Weight (in Grams)',
          keyId: Values.weight,
          validate: isDouble,
          isLast: true),
    };
  }

  @override
  void initState() {
    initQuote();
    initPackage();

    if (widget.quote != null) {
      dev.log(
          "ADSFGSDGsdg ${quoteFields[Values.transit_type]?.controller?.value}");
      onValueSelected(Values.type_of_move, widget.quote?.typeOfMove,
          clear: false);
      onValueSelected(Values.transit_type, widget.quote?.transitType);
    }
    GetIt.I<CreateQuoteCubit>().load();
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
          child: BlocBuilder<CreateQuoteCubit, CreateQuoteState>(
            bloc: GetIt.I<CreateQuoteCubit>(),
            builder: (context, state) {
              if (state is CreateQuoteLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              if (state is CreateQuoteFailed) {
                return Text(state.errorMessage!);
              }

              if (state is CreateQuoteSuccess) {
                return Column(
                  children: [
                    Text(state.successMessage!),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ButtonCustm(
                        label: "Close",
                        padding: 10,
                        function1: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    )
                  ],
                );
              }
              if (state is CreatePageSuccess) {
                quoteFields[Values.date]?.controller?.text = state.date ?? '';
                quoteFields[Values.quote_number]?.controller?.text =
                    widget.quote?.sid ?? state.id ?? '';
                return SizedBox(
                    // width: min(MediaQuery.of(context).size.width, 480),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              children: List<Widget>.generate(
                                  quoteFields.length, (index) {
                                return TextFieldEntryBuilder(
                                  textFieldEntry:
                                      quoteFields.values.toList()[index],
                                  onValueSelected: (key, value) =>
                                      onValueSelected(key!, value),
                                  focusHandler: (isLast) {
                                    isLast
                                        ? FocusScope.of(context).unfocus()
                                        : focusOnNextVisible(
                                            index, quoteFields);
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
                                    "Package Details",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                    ),
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                          packages.add(packageFields);
                                          initPackage();
                                        });
                                      }),
                                ],
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: packages.length,
                                itemBuilder: (context, index0) {
                                  return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      width: min(
                                          460,
                                          MediaQuery.of(context).size.width -
                                              40),
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
                                                    packageFields.length + 1,
                                                itemBuilder: (context, index) {
                                                  if (index ==
                                                      packageFields.length) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
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
                                                              packages.removeAt(
                                                                  index0);
                                                            });
                                                          }),
                                                    );
                                                  }
                                                  return TextFieldEntryBuilder(
                                                    textFieldEntry:
                                                        packages[index0]
                                                            .values
                                                            .toList()[index],
                                                    onValueSelected: (key,
                                                            value) =>
                                                        onValueSelected(
                                                            key!, value),
                                                    focusHandler: (isLast) {
                                                      isLast
                                                          ? FocusScope.of(
                                                                  context)
                                                              .unfocus()
                                                          : focusOnNextVisible(
                                                              index,
                                                              packages[index0]);
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
                                    for (final element in quoteFields.entries)
                                      if (element.value.controller?.text
                                              .isNotEmpty ??
                                          false)
                                        element.key: element
                                                    .value.controller?.text ==
                                                'Yes'
                                            ? true
                                            : element.value.controller?.text ==
                                                    'No'
                                                ? false
                                                : element.value.controller?.text
                                  };
                                  if (_formKey.currentState!.validate()) {
                                    dev.log(values.toString());
                                    values[Values.package] = [];
                                    values[Values.customer] = state.id;
                                    if (widget.quote == null) {
                                      GetIt.I<CreateQuoteCubit>()
                                          .create(values);
                                    } else {
                                      GetIt.I<CreateQuoteCubit>().edit(values);
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
      ),
    );
  }
}
