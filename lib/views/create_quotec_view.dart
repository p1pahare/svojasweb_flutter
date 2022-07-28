import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/create_quotec/create_quotec_cubit.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/textfield_entry_builder.dart';

class CreateQuotecView extends StatefulWidget {
  const CreateQuotecView({Key? key, this.quotec}) : super(key: key);
  static const routeName = '/CreateQuotecView';
  static const routeNameEdit = '/EditQuotecView';
  final QuoteC? quotec;
  @override
  State<CreateQuotecView> createState() => _CreateQuotecViewState();
}

class _CreateQuotecViewState extends State<CreateQuotecView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onValueSelected(String key, String? value, {bool clear = true}) {
    switch (key) {
      default:
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

  Map<String, TextFieldEntry> quotecFields = {};

  void initQuote() {
    quotecFields = {
      Values.date: TextFieldEntry(
          label: 'Date',
          keyId: Values.date,
          enabled: false,
          controller: TextEditingController(text: widget.quotec?.date)),
      Values.sid: TextFieldEntry(
          label: 'id',
          keyId: Values.sid,
          enabled: false,
          controller: TextEditingController(text: widget.quotec?.sId)),
      Values.drayage_fuel: TextFieldEntry(
          label: 'Drayage Fuel',
          controller: TextEditingController(text: widget.quotec?.drayageFuel),
          keyId: Values.drayage_fuel,
          isLast: false),
      Values.chassis: TextFieldEntry(
          label: 'Chassis',
          controller: TextEditingController(text: widget.quotec?.chassis),
          keyId: Values.chassis,
          isLast: false),
      Values.pre_pull: TextFieldEntry(
          label: 'Pre Pull',
          fieldType: widget.quotec?.prePull == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.prePull),
          keyId: Values.pre_pull,
          isLast: false),
      Values.yard_storage: TextFieldEntry(
          label: 'Yard Storage',
          fieldType: widget.quotec?.yardStorage == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.yardStorage),
          keyId: Values.yard_storage,
          isLast: false),
      Values.port_congestion: TextFieldEntry(
          label: 'Port Congestion',
          fieldType: widget.quotec?.portCongestion == null
              ? FieldType.checkbox
              : FieldType.text,
          controller:
              TextEditingController(text: widget.quotec?.portCongestion),
          keyId: Values.port_congestion,
          isLast: false),
      Values.stop_off: TextFieldEntry(
          label: 'Stop-Off',
          fieldType: widget.quotec?.stopOff == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.stopOff),
          keyId: Values.stop_off,
          isLast: false),
      Values.overweight: TextFieldEntry(
          label: 'Overweight',
          fieldType: widget.quotec?.overweight == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.overweight),
          keyId: Values.overweight,
          isLast: false),
      Values.reefer: TextFieldEntry(
          label: 'Reefer',
          fieldType: widget.quotec?.reefer == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.reefer),
          keyId: Values.reefer,
          isLast: false),
      Values.reefer_monitoring_fee: TextFieldEntry(
          label: 'Refer Monitoring Fee',
          fieldType: widget.quotec?.reeferMonitoringFee == null
              ? FieldType.checkbox
              : FieldType.text,
          controller:
              TextEditingController(text: widget.quotec?.reeferMonitoringFee),
          keyId: Values.reefer_monitoring_fee,
          isLast: false),
      Values.chassis_split: TextFieldEntry(
          label: 'Chassis Split',
          fieldType: widget.quotec?.chassisSplit == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.chassisSplit),
          keyId: Values.chassis_split,
          isLast: false),
      Values.detention: TextFieldEntry(
          label: 'Detention',
          fieldType: widget.quotec?.detention == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.detention),
          keyId: Values.detention,
          isLast: false),
      Values.tolls: TextFieldEntry(
          label: 'Tolls',
          fieldType: widget.quotec?.tolls == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.tolls),
          keyId: Values.tolls,
          isLast: false),
      Values.drop_and_pick: TextFieldEntry(
          label: 'Drop and Pick',
          fieldType: widget.quotec?.dropAndPick == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.dropAndPick),
          keyId: Values.drop_and_pick,
          isLast: false),
      Values.hazmat: TextFieldEntry(
          label: 'Hazmat',
          fieldType: widget.quotec?.hazmat == null
              ? FieldType.checkbox
              : FieldType.text,
          controller: TextEditingController(text: widget.quotec?.hazmat),
          keyId: Values.hazmat,
          isLast: false),
    };
  }

  @override
  void initState() {
    initQuote();

    if (widget.quotec != null) {
      // onValueSelected(Values.type_of_move, widget.quotec?.typeOfMove,
      //     clear: false);
      // onValueSelected(Values.transit_type, widget.quote?.transitType);

    }
    GetIt.I<CreateQuotecCubit>().load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              '${widget.quotec == null ? 'Create' : 'Edit'} Quote Confirm')),
      // drawer: const DrawerView(),
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<CreateQuotecCubit, CreateQuotecState>(
            bloc: GetIt.I<CreateQuotecCubit>(),
            builder: (context, state) {
              if (state is CreateQuotecLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              if (state is CreateQuotecFailed) {
                return Text(state.errorMessage!);
              }

              if (state is CreateQuotecSuccess) {
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
                return SizedBox(
                    // width: min(MediaQuery.of(context).size.width, 480),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              children: List<Widget>.generate(
                                  quotecFields.length, (index) {
                                return TextFieldEntryBuilder(
                                  textFieldEntry:
                                      quotecFields.values.toList()[index],
                                  onValueSelected: (key, value) =>
                                      onValueSelected(key!, value),
                                  focusHandler: (isLast) {
                                    isLast
                                        ? FocusScope.of(context).unfocus()
                                        : focusOnNextVisible(
                                            index, quotecFields);
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
                                    for (final element in quotecFields.entries)
                                      if ((element.value.controller?.text
                                                  .isNotEmpty ??
                                              false) &&
                                          element.value.visible)
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

                                    values[Values.customer] = state.id;
                                    if (widget.quotec == null) {
                                      GetIt.I<CreateQuotecCubit>()
                                          .create(values);
                                    } else {
                                      GetIt.I<CreateQuotecCubit>().edit(values);
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
