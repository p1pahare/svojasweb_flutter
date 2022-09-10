import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/buying/buying_cubit.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/textfield_entry_builder.dart';
import 'package:svojasweb/views/drawer_view.dart';
import 'package:svojasweb/views/subviews/view_party.dart';
import 'dart:developer' as d;

import 'package:svojasweb/views/subviews/view_quote.dart';
import 'package:svojasweb/views/subviews/view_quotec.dart';

class ConfirmShipments extends StatefulWidget {
  const ConfirmShipments({Key? key, required this.title}) : super(key: key);
  static const routeName = '/ConfirmShipments';
  final String title;
  @override
  State<ConfirmShipments> createState() => _ConfirmShipmentsState();
}

class _ConfirmShipmentsState extends State<ConfirmShipments> {
  final GlobalKey<ScaffoldState> _scaff = GlobalKey();
  TextFieldEntry textFieldEntry = TextFieldEntry(
      fieldType: FieldType.autocomplete,
      label: 'Select Quote Id',
      keyId: Values.quote_number,
      enabled: true,
      optionListing: (textValue) async =>
          (await GetIt.I<BuyingCubit>().getQuotecs(textValue)),
      controller: TextEditingController(text: ''));
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      key: _scaff,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldEntryBuilder(
              textFieldEntry: textFieldEntry,
              onValueSelected: (key, value) {
                d.log("$key!, $value");

                setState(() {});
              },
              focusHandler: (islast) => d.log(islast.toString()),
            ),
            BlocBuilder<BuyingCubit, BuyingState>(
              bloc: GetIt.I<BuyingCubit>(),
              builder: (context, state) {
                if (state is BuyingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
                if (state is BuyingFailed) {
                  return Text(state.errorMessage!);
                }
                if (state is CreatePageSuccess) {
                  return Column(
                    children: [
                      if (state.quote != null)
                        Container(
                            margin: const EdgeInsets.all(25),
                            child: ViewQuote(quote: state.quote!)),
                      if (state.quotec != null)
                        Container(
                            margin: const EdgeInsets.all(25),
                            child: ViewQuotec(quoteC: state.quotec!)),
                      if (state.buying != null)
                        Column(
                          children: [
                            const Text(
                              "Buyings",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 20),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.quote?.trucker.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    margin: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 127, 169, 190),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () {
                                          selectCustomer(state
                                              .quote?.trucker[index] as Party);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                "   ${state.quote?.trucker[index].partyName} (${state.quote?.trucker[index].orgName})\t"),
                                            Text(
                                                "   ${state.quote?.trucker[index].emailId}\t"),
                                            Text(
                                                "   ${state.quote?.trucker[index].phone}\t"
                                                    .padRight(12)),
                                            SizedBox(
                                                width: 100,
                                                child: Text(
                                                  state.buying!.buyings[index]
                                                      .toString(),
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
                return const SizedBox(
                  height: 0,
                  width: 0,
                );
              },
            ),
          ],
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
