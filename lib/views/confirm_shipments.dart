import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:svojasweb/blocs/create_shipment/create_shipment_cubit.dart';
import 'package:svojasweb/models/buying.dart';
import 'package:svojasweb/models/cquote.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:svojasweb/utilities/textfield_entry_builder.dart';
import 'package:svojasweb/views/drawer_view.dart';
import 'package:svojasweb/views/subviews/view_party.dart';
import 'dart:developer' as d;

import 'package:svojasweb/views/subviews/view_quote.dart';
import 'package:svojasweb/views/subviews/view_quotec.dart';

class ConfirmShipments extends StatefulWidget {
  const ConfirmShipments({Key? key, required this.title, this.prefilledValue})
      : super(key: key);
  static const routeName = '/ConfirmShipments';
  final String title;
  final String? prefilledValue;
  @override
  State<ConfirmShipments> createState() => _ConfirmShipmentsState();
}

class _ConfirmShipmentsState extends State<ConfirmShipments> {
  final GlobalKey<ScaffoldState> _scaff = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, TextFieldEntry> cquoteFields = {
    Values.quote_id: TextFieldEntry(
        fieldType: FieldType.autocomplete,
        label: 'Select Quote Id',
        keyId: Values.quote_id,
        enabled: true,
        optionListing: (textValue) async =>
            (await GetIt.I<CreateShipmentCubit>().getBuyings(textValue)),
        controller: TextEditingController(text: '')),
  };
  void onValueSelected(String typeOfMove, String? transitType) {
    if (typeOfMove == 'Ocean' && transitType == 'Import') {
      cquoteFields[Values.container]?.visible = true;
      cquoteFields[Values.mbl]?.visible = true;
      cquoteFields[Values.pickup_terminal]?.visible = true;
      cquoteFields[Values.eta]?.visible = true;
      cquoteFields[Values.lfd]?.visible = true;
      cquoteFields[Values.gate_out]?.visible = true;
      cquoteFields[Values.delivery]?.visible = true;
      cquoteFields[Values.empty_gate_in]?.visible = true;
      cquoteFields[Values.empty_return_terminal]?.visible = true;
      cquoteFields[Values.empty_return_terminal]?.isLast = true;
    }
    if (typeOfMove == 'Ocean' && transitType == 'Export') {
      cquoteFields[Values.booking]?.visible = true;
      cquoteFields[Values.container]?.visible = true;
      cquoteFields[Values.empty_pickup_terminal]?.visible = true;
      cquoteFields[Values.erd]?.visible = true;
      cquoteFields[Values.lrd]?.visible = true;
      cquoteFields[Values.etd]?.visible = true;
      cquoteFields[Values.empty_gate_out]?.visible = true;
      cquoteFields[Values.loading]?.visible = true;
      cquoteFields[Values.full_return]?.visible = true;
      cquoteFields[Values.full_return_terminal]?.visible = true;
      cquoteFields[Values.full_return_terminal]?.isLast = true;
    }
    if (typeOfMove == 'Air' && transitType == 'Import') {
      cquoteFields[Values.awb]?.visible = true;
      cquoteFields[Values.pickup_handling_agent]?.visible = true;
      cquoteFields[Values.eta]?.visible = true;
      cquoteFields[Values.lfd]?.visible = true;
      cquoteFields[Values.pickup]?.visible = true;
      cquoteFields[Values.delivery]?.visible = true;
      cquoteFields[Values.delivery]?.isLast = true;
    }
    if (typeOfMove == 'Air' && transitType == 'Export') {
      cquoteFields[Values.awb]?.visible = true;
      cquoteFields[Values.delivery_handling_agent]?.visible = true;
      cquoteFields[Values.pickup]?.visible = true;
      cquoteFields[Values.delivery]?.visible = true;
      cquoteFields[Values.booking_cutoff]?.visible = true;
      cquoteFields[Values.etd]?.visible = true;
      cquoteFields[Values.etd]?.isLast = true;
    }
    if (typeOfMove == 'Inland' && transitType == 'LTL') {
      cquoteFields[Values.bol]?.visible = true;
      cquoteFields[Values.carrier_reference_no]?.visible = true;
      cquoteFields[Values.ltl_carrier_name]?.visible = true;
      cquoteFields[Values.pickup]?.visible = true;
      cquoteFields[Values.delivery]?.visible = true;
      cquoteFields[Values.delivery]?.isLast = true;
    }
    if (typeOfMove == 'Inland' && transitType == 'FTL') {
      cquoteFields[Values.bol]?.visible = true;
      cquoteFields[Values.ftl_carrier_name]?.visible = true;
      cquoteFields[Values.pickup]?.visible = true;
      cquoteFields[Values.delivery]?.visible = true;
      cquoteFields[Values.delivery]?.isLast = true;
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

  @override
  void initState() {
    super.initState();
    initCquote();
    if (widget.prefilledValue != null) {
      GetIt.I<CreateShipmentCubit>().getBuyings(widget.prefilledValue!);
    }
  }

  String servertoFormatDate(String? datee) {
    if (datee == null || datee.isEmpty) {
      return '';
    } else {
      return DateFormat.yMMMd().format(DateTime.parse(datee));
    }
  }

  addTextsToCquotes(Cquote cquote) {
    cquoteFields[Values.empty_return_terminal]?.controller?.text =
        cquote.emptyReturnTerminal ?? '';
    cquoteFields[Values.container]?.controller?.text = cquote.container ?? '';
    cquoteFields[Values.mbl]?.controller?.text = cquote.mbl ?? '';
    cquoteFields[Values.pickup_terminal]?.controller?.text =
        cquote.pickupTerminal ?? '';
    cquoteFields[Values.eta]?.controller?.text = servertoFormatDate(cquote.eta);
    cquoteFields[Values.lfd]?.controller?.text = servertoFormatDate(cquote.lfd);
    cquoteFields[Values.gate_out]?.controller?.text =
        servertoFormatDate(cquote.gateOut);
    cquoteFields[Values.delivery]?.controller?.text =
        servertoFormatDate(cquote.delivery);
    cquoteFields[Values.empty_gate_in]?.controller?.text =
        servertoFormatDate(cquote.emptyGateIn);
    cquoteFields[Values.empty_pickup_terminal]?.controller?.text =
        cquote.emptyPickupTerminal ?? '';
    cquoteFields[Values.booking]?.controller?.text = cquote.booking ?? '';
    cquoteFields[Values.erd]?.controller?.text = servertoFormatDate(cquote.erd);
    cquoteFields[Values.carrier_reference_no]?.controller?.text =
        cquote.carrierReferenceNo ?? '';
    cquoteFields[Values.lrd]?.controller?.text = servertoFormatDate(cquote.lrd);
    cquoteFields[Values.etd]?.controller?.text = cquote.etd ?? '';
    cquoteFields[Values.empty_gate_out]?.controller?.text =
        cquote.emptyGateOut ?? '';
    cquoteFields[Values.awb]?.controller?.text = cquote.awb ?? '';
    cquoteFields[Values.pickup_handling_agent]?.controller?.text =
        cquote.pickupHandlingAgent ?? '';
    cquoteFields[Values.delivery_handling_agent]?.controller?.text =
        cquote.deliveryHandlingAgent ?? '';
    cquoteFields[Values.pickup]?.controller?.text =
        servertoFormatDate(cquote.pickup);
    cquoteFields[Values.booking_cutoff]?.controller?.text =
        servertoFormatDate(cquote.bookingCutoff);
    cquoteFields[Values.bol]?.controller?.text = cquote.bol ?? '';
    cquoteFields[Values.ltl_carrier_name]?.controller?.text =
        cquote.ltlCarrierName ?? '';
    cquoteFields[Values.ftl_carrier_name]?.controller?.text =
        cquote.ftlCarrierName ?? '';
    cquoteFields[Values.loading]?.controller?.text = cquote.loading ?? '';
    cquoteFields[Values.full_return]?.controller?.text =
        servertoFormatDate(cquote.fullReturn);
    cquoteFields[Values.full_return_terminal]?.controller?.text =
        cquote.fullReturnTerminal ?? '';
  }

  void initCquote() {
    cquoteFields = {
      Values.quote_id: TextFieldEntry(
          fieldType: FieldType.autocomplete,
          label: 'Select Quote Id',
          keyId: Values.quote_id,
          enabled: true,
          optionListing: (textValue) async =>
              (await GetIt.I<CreateShipmentCubit>().getBuyings(textValue)),
          controller: TextEditingController(text: '')),
      Values.container: TextFieldEntry(
          label: 'Container',
          controller: TextEditingController(text: ''),
          keyId: Values.container,
          visible: false,
          isLast: false),
      Values.mbl: TextFieldEntry(
          label: 'MBL',
          controller: TextEditingController(text: ''),
          keyId: Values.mbl,
          visible: false,
          isLast: false),
      Values.pickup_terminal: TextFieldEntry(
          label: 'Pickup Terminal',
          controller: TextEditingController(text: ''),
          keyId: Values.pickup_terminal,
          visible: false,
          isLast: false),
      Values.eta: TextFieldEntry(
          label: 'ETA',
          controller: TextEditingController(text: ''),
          keyId: Values.eta,
          fieldType: FieldType.date,
          isLast: false),
      Values.lfd: TextFieldEntry(
          label: 'LFD',
          controller: TextEditingController(text: ''),
          keyId: Values.lfd,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.gate_out: TextFieldEntry(
          label: 'Gate Out',
          controller: TextEditingController(text: ''),
          keyId: Values.gate_out,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.delivery: TextFieldEntry(
          label: 'Delivery',
          controller: TextEditingController(text: ''),
          keyId: Values.delivery,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.empty_gate_in: TextFieldEntry(
          label: 'Empty Gate In',
          controller: TextEditingController(text: ''),
          keyId: Values.empty_gate_in,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.empty_return_terminal: TextFieldEntry(
          label: 'Empty Return Terminal',
          controller: TextEditingController(text: ''),
          keyId: Values.empty_return_terminal,
          visible: false,
          isLast: false),
      Values.empty_pickup_terminal: TextFieldEntry(
          label: 'Empty Pickup Terminal',
          controller: TextEditingController(text: ''),
          keyId: Values.empty_pickup_terminal,
          visible: false,
          isLast: false),
      Values.booking: TextFieldEntry(
          label: 'Booking',
          controller: TextEditingController(text: ''),
          keyId: Values.booking,
          visible: false,
          isLast: false),
      Values.erd: TextFieldEntry(
          label: 'ERD',
          controller: TextEditingController(text: ''),
          keyId: Values.erd,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.carrier_reference_no: TextFieldEntry(
          label: 'Carrier Reference Number',
          controller: TextEditingController(text: ''),
          keyId: Values.carrier_reference_no,
          isLast: false),
      Values.lrd: TextFieldEntry(
          label: 'LRD',
          controller: TextEditingController(text: ''),
          keyId: Values.lrd,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.etd: TextFieldEntry(
          label: 'ETD',
          controller: TextEditingController(text: ''),
          keyId: Values.etd,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.empty_gate_out: TextFieldEntry(
          label: 'Empty Gate Out',
          controller: TextEditingController(text: ''),
          keyId: Values.empty_gate_out,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.awb: TextFieldEntry(
          label: 'AWB',
          controller: TextEditingController(text: ''),
          keyId: Values.awb,
          visible: false,
          isLast: false),
      Values.pickup_handling_agent: TextFieldEntry(
          label: 'Pickup Handling Agent',
          controller: TextEditingController(text: ''),
          keyId: Values.pickup_handling_agent,
          visible: false,
          isLast: false),
      Values.delivery_handling_agent: TextFieldEntry(
          label: 'Delivery Handling Agent',
          controller: TextEditingController(text: ''),
          keyId: Values.delivery_handling_agent,
          visible: false,
          isLast: false),
      Values.pickup: TextFieldEntry(
          label: 'Pickup',
          controller: TextEditingController(text: ''),
          keyId: Values.pickup,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.booking_cutoff: TextFieldEntry(
          label: 'Booking Cut-Off',
          controller: TextEditingController(text: ''),
          keyId: Values.booking_cutoff,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.bol: TextFieldEntry(
          label: 'BOL',
          controller: TextEditingController(text: ''),
          keyId: Values.bol,
          visible: false,
          isLast: false),
      Values.ltl_carrier_name: TextFieldEntry(
          label: 'LTL Carrier Name',
          controller: TextEditingController(text: ''),
          keyId: Values.ltl_carrier_name,
          visible: false,
          isLast: false),
      Values.ftl_carrier_name: TextFieldEntry(
          label: 'FTL Carrier Name',
          controller: TextEditingController(text: ''),
          keyId: Values.ftl_carrier_name,
          visible: false,
          isLast: false),
      Values.loading: TextFieldEntry(
          label: 'Loading',
          controller: TextEditingController(text: ''),
          keyId: Values.loading,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.full_return: TextFieldEntry(
          label: 'Full Return',
          controller: TextEditingController(text: ''),
          keyId: Values.full_return,
          fieldType: FieldType.date,
          visible: false,
          isLast: false),
      Values.full_return_terminal: TextFieldEntry(
          label: 'Full Return Terminal',
          controller: TextEditingController(text: ''),
          keyId: Values.full_return_terminal,
          visible: false,
          isLast: false),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      key: _scaff,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldEntryBuilder(
                textFieldEntry: cquoteFields[Values.quote_id],
                onValueSelected: (key, value) {
                  d.log("$key!, $value");
                  setState(() {});
                },
                focusHandler: (islast) => d.log(islast.toString()),
              ),
              BlocBuilder<CreateShipmentCubit, CreateShipmentState>(
                bloc: GetIt.I<CreateShipmentCubit>(),
                builder: (context, state) {
                  if (state is CreateShipmentLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    );
                  }
                  if (state is CreateShipmentFailed) {
                    return Text(state.errorMessage!);
                  }
                  if (state is CreateShipmentSuccess) {
                    return Column(
                      children: [
                        Text(state.successMessage!),
                        ButtonCustm(
                            label: 'Go back',
                            function1: () => Navigator.pop(context)),
                      ],
                    );
                  }
                  if (state is CreatePageSuccess) {
                    if (state.cquote != null) {
                      addTextsToCquotes(state.cquote!);
                    }
                    if (state.quote != null) {
                      onValueSelected(
                          state.quote!.typeOfMove, state.quote!.transitType);
                    }

                    return Column(
                      children: [
                        QuoteDetails(
                          ontruckerPress: selectCustomer,
                          quote: state.quote,
                          quotec: state.quotec,
                          buying: state.buying,
                        ),
                        const Text(
                          "Shipments",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 22),
                        ),
                        if (state.buying != null)
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: List<Widget>.generate(
                                cquoteFields.length - 1, (index) {
                              return TextFieldEntryBuilder(
                                textFieldEntry:
                                    cquoteFields.values.toList()[index + 1],
                                onValueSelected: (key, value) =>
                                    onValueSelected(key!, value),
                                focusHandler: (isLast) {
                                  isLast
                                      ? FocusScope.of(context).unfocus()
                                      : focusOnNextVisible(
                                          index + 1, cquoteFields);
                                },
                              );
                            }),
                          ),
                        if (state.buying != null && state.quote != null)
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ButtonCustm(
                              label: "Submit",
                              padding: 10,
                              function1: () {
                                final Map<String, dynamic> values = {
                                  for (final element in cquoteFields.entries)
                                    if (element.value.controller?.text
                                            .isNotEmpty ??
                                        false)
                                      if (element.value.fieldType ==
                                          FieldType.date)
                                        element.key: DateFormat.yMMMd()
                                            .parse(element
                                                    .value.controller?.text ??
                                                'Jul 10, 2022')
                                            .toIso8601String()
                                      else
                                        element.key:
                                            element.value.controller?.text
                                };
                                if (_formKey.currentState!.validate()) {
                                  d.log(values.toString());
                                  if ((cquoteFields[Values.quote_id]?.object
                                          as Buying?) !=
                                      null) {
                                    values[Values.quote_id] =
                                        state.quote?.quoteId;
                                  }
                                  // values[Values.quote_number] = state.id;
                                  if (state.cquote == null) {
                                    GetIt.I<CreateShipmentCubit>()
                                        .create(values);
                                  } else {
                                    values[Values.sid] = state.cquote?.sid;
                                    GetIt.I<CreateShipmentCubit>().edit(values);
                                  }
                                }
                              },
                            ),
                          )
                      ],
                    );
                  }
                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      drawer: const DrawerView(),
    );
  }

  void selectCustomer(Party party) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Column(
        children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:
                      SingleChildScrollView(child: ViewParty(party: party)))),
          Container(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  onPressed: () => Navigator.pop(context)),
            ),
          ),
        ],
      ),
    );
  }
}

class QuoteDetails extends StatelessWidget {
  const QuoteDetails(
      {Key? key, this.buying, this.quote, this.quotec, this.ontruckerPress})
      : super(key: key);
  final Quote? quote;
  final QuoteC? quotec;
  final Buying? buying;
  final Function(Party)? ontruckerPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (quote != null)
          Container(
              margin: const EdgeInsets.all(25),
              child: ViewQuote(quote: quote!)),
        if (quotec != null)
          Container(
              margin: const EdgeInsets.all(25),
              child: ViewQuotec(quoteC: quotec!)),
        if (buying != null)
          Column(
            children: [
              const Text(
                "Buyings",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: buying?.buyings.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 127, 169, 190),
                          borderRadius: BorderRadius.circular(20)),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () {
                            ontruckerPress
                                ?.call(quote?.trucker[index] as Party);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SelectableText(
                                  "   ${quote?.trucker[index].partyName} (${quote?.trucker[index].orgName})\t"),
                              SelectableText(
                                  "   ${quote?.trucker[index].emailId}\t"),
                              SelectableText(
                                  "   ${quote?.trucker[index].phone}\t"
                                      .padRight(12)),
                              SizedBox(
                                  width: 100,
                                  child: SelectableText(
                                    buying!.buyings[index].toString(),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          )
      ],
    );
  }
}
