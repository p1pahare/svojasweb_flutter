import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/create_quote/create_quote_cubit.dart';
import 'package:svojasweb/blocs/create_quotec/create_quotec_cubit.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/textfield_entry_builder.dart';
import 'package:svojasweb/views/subviews/view_party.dart';

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
  List<String> truckers = [];
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
      Values.quote_number: TextFieldEntry(
          fieldType: FieldType.autocomplete,
          label: 'Select Quote Id',
          keyId: Values.quote_number,
          enabled: true,
          object: (widget.quotec?.quote.isEmpty ?? false)
              ? null
              : widget.quotec?.quote.first,
          optionListing: (textValue) =>
              GetIt.I<CreateQuotecCubit>().getQuotes(textValue),
          controller: TextEditingController(
              text: (widget.quotec?.quote.isNotEmpty) ?? false
                  ? widget.quotec?.quote.first.quoteId
                  : '')),
      Values.date: TextFieldEntry(
          label: 'Date',
          keyId: Values.date,
          enabled: false,
          controller: TextEditingController(text: widget.quotec?.date)),
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
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.prePull),
          keyId: Values.pre_pull,
          isLast: false),
      Values.yard_storage: TextFieldEntry(
          label: 'Yard Storage',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.yardStorage),
          keyId: Values.yard_storage,
          isLast: false),
      Values.port_congestion: TextFieldEntry(
          label: 'Port Congestion',
          fieldType: FieldType.checkbox,
          controller:
              TextEditingController(text: widget.quotec?.portCongestion),
          keyId: Values.port_congestion,
          isLast: false),
      Values.stop_off: TextFieldEntry(
          label: 'Stop-Off',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.stopOff),
          keyId: Values.stop_off,
          isLast: false),
      Values.overweight: TextFieldEntry(
          label: 'Overweight',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.overweight),
          keyId: Values.overweight,
          isLast: false),
      Values.reefer: TextFieldEntry(
          label: 'Reefer',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.reefer),
          keyId: Values.reefer,
          isLast: false),
      Values.reefer_monitoring_fee: TextFieldEntry(
          label: 'Refer Monitoring Fee',
          fieldType: FieldType.checkbox,
          controller:
              TextEditingController(text: widget.quotec?.reeferMonitoringFee),
          keyId: Values.reefer_monitoring_fee,
          isLast: false),
      Values.chassis_split: TextFieldEntry(
          label: 'Chassis Split',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.chassisSplit),
          keyId: Values.chassis_split,
          isLast: false),
      Values.detention: TextFieldEntry(
          label: 'Detention',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.detention),
          keyId: Values.detention,
          isLast: false),
      Values.tolls: TextFieldEntry(
          label: 'Tolls',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.tolls),
          keyId: Values.tolls,
          isLast: false),
      Values.drop_and_pick: TextFieldEntry(
          label: 'Drop and Pick',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.dropAndPick),
          keyId: Values.drop_and_pick,
          isLast: false),
      Values.hazmat: TextFieldEntry(
          label: 'Hazmat',
          fieldType: FieldType.checkbox,
          controller: TextEditingController(text: widget.quotec?.hazmat),
          keyId: Values.hazmat,
          isLast: false),
      Values.truckers: TextFieldEntry(
          fieldType: FieldType.autocomplete,
          label: 'Select Truckers Id',
          keyId: Values.truckers,
          enabled: true,
          object: [],
          optionListing: (textValue) =>
              GetIt.I<CreateQuoteCubit>().getParties(textValue),
          controller: TextEditingController(
              text: (widget.quotec?.truckers?.isNotEmpty) ?? false
                  ? widget.quotec?.truckers
                  : '')),
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
    GetIt.I<CreateQuotecCubit>()
        .getTruckers(widget.quotec?.truckers)
        .then((value) => quotecFields[Values.truckers]?.object = value)
        .then((value) => setState(() {}));
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
                quotecFields[Values.date]?.controller?.text = state.date ?? '';
                quotecFields[Values.sid]?.controller?.text =
                    widget.quotec?.sId ?? state.id ?? '';
                quotecFields[Values.pre_pull]?.object = state.quoteC?.prePull;
                quotecFields[Values.yard_storage]?.object =
                    state.quoteC?.yardStorage;
                quotecFields[Values.port_congestion]?.object =
                    state.quoteC?.portCongestion;
                quotecFields[Values.stop_off]?.object = state.quoteC?.stopOff;
                quotecFields[Values.overweight]?.object =
                    state.quoteC?.overweight;
                quotecFields[Values.reefer]?.object = state.quoteC?.reefer;
                quotecFields[Values.reefer_monitoring_fee]?.object =
                    state.quoteC?.reeferMonitoringFee;
                quotecFields[Values.chassis_split]?.object =
                    state.quoteC?.chassisSplit;
                quotecFields[Values.detention]?.object =
                    state.quoteC?.detention;
                quotecFields[Values.tolls]?.object = state.quoteC?.tolls;
                quotecFields[Values.drop_and_pick]?.object =
                    state.quoteC?.dropAndPick;
                quotecFields[Values.hazmat]?.object = state.quoteC?.hazmat;
                List<Party>? listruckers =
                    (quotecFields[Values.truckers]?.object as List<dynamic>)
                        .cast<Party>();
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
                            StreamBuilder<List<Party>>(
                                stream: Stream.value(listruckers),
                                // GetIt.I<CreateQuotecCubit>()
                                //     .getTruckersStream(widget.quotec?.truckers),
                                builder: (context, snapp) {
                                  if (snapp.data != null) {
                                    if (snapp.data?.isNotEmpty ?? false) {
                                      listruckers = snapp.data;
                                    }
                                    return ListView.builder(
                                        // gridDelegate:
                                        //     const SliverGridDelegateWithFixedCrossAxisCount(
                                        //         crossAxisCount: 2),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: snapp.data?.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(20),
                                                child: Stack(
                                                  children: [
                                                    ViewParty(
                                                        nameOnTop: true,
                                                        party:
                                                            snapp.data![index]),
                                                    Positioned(
                                                        top: 0,
                                                        left: 0,
                                                        child: MaterialButton(
                                                          child: const Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            size: 40,
                                                            color: Colors.white,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (listruckers!
                                                                      .length >=
                                                                  index + 1) {
                                                                listruckers!
                                                                    .removeAt(
                                                                        index);
                                                              }
                                                            });
                                                          },
                                                        )),
                                                  ],
                                                )));
                                  } else {
                                    return const SizedBox(
                                      height: 0,
                                    );
                                  }
                                }),
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
                                    if ((quotecFields[Values.quote_number]
                                            ?.object as Quote?) !=
                                        null) {
                                      values[Values.quote_number] =
                                          (quotecFields[Values.quote_number]
                                                  ?.object as Quote?)
                                              ?.sid;

                                      values[Values.truckers] = "";
                                      final truckerList =
                                          (quotecFields[Values.truckers]?.object
                                                  as List<dynamic>)
                                              .cast<Party>()
                                              .map((e) => e.sid)
                                              .toList();
                                      for (int i = 0;
                                          i < truckerList.length;
                                          i++) {
                                        values[Values.truckers] +=
                                            "${truckerList[i]}";
                                        if (i != truckerList.length - 1) {
                                          values[Values.truckers] += ",";
                                        }
                                      }
                                    }
                                    // values[Values.quote_number] = state.id;
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
