import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/create_buyings/create_buyings_cubit.dart';
import 'package:svojasweb/models/buying.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'dart:developer' as d;
import 'package:svojasweb/utilities/textfield_entry_builder.dart';
import 'package:svojasweb/utilities/validations.dart';
import 'package:svojasweb/views/drawer_view.dart';
import 'package:svojasweb/views/subviews/view_quote.dart';
import 'package:svojasweb/views/subviews/view_quotec.dart';

class BuyingsReceived extends StatefulWidget {
  const BuyingsReceived({Key? key, required this.title}) : super(key: key);
  static const routeName = '/BuyingsReceived';
  final String title;
  @override
  State<BuyingsReceived> createState() => _BuyingsReceivedState();
}

class _BuyingsReceivedState extends State<BuyingsReceived> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void focusOnNextVisible(int index, Map<String, TextFieldEntry> fields) {
    for (int x = index + 1; x < fields.length; x++) {
      if (fields.values.toList()[x].visible) {
        FocusScope.of(context)
            .requestFocus(fields.values.toList()[x].focusnode);
        break;
      }
    }
  }

  List<TextEditingController> buyings = [];
  Map<String, TextFieldEntry> buyingsFields = {};
  Quote? quote;
  QuoteC? quoteC;
  Buying? buying;
  void initBuyings() {
    buyingsFields = {
      Values.quote_id: TextFieldEntry(
          fieldType: FieldType.autocomplete,
          label: 'Select Quote Id',
          keyId: Values.quote_number,
          enabled: true,
          optionListing: (textValue) async =>
              (await GetIt.I<CreateBuyingsCubit>().getQuotecs(textValue))
                  .entries,
          controller: TextEditingController(text: '')),
      Values.date: TextFieldEntry(
          label: 'Date',
          keyId: Values.date,
          enabled: false,
          visible: false,
          controller: TextEditingController(text: DateTime.now().toString())),
    };
  }

  @override
  void initState() {
    initBuyings();

    GetIt.I<CreateBuyingsCubit>().load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      // drawer: const DrawerView(),
      body: SingleChildScrollView(
        child: BlocBuilder<CreateBuyingsCubit, CreateBuyingsState>(
          bloc: GetIt.I<CreateBuyingsCubit>(),
          builder: (context, state) {
            if (state is CreateBuyingLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            if (state is CreateBuyingFailed) {
              return Text(state.errorMessage!);
            }

            if (state is CreateBuyingSuccess) {
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
              return SizedBox(
                  // width: min(MediaQuery.of(context).size.width, 480),
                  child: Form(
                      key: _formKey,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: List<Widget>.generate(
                                  buyingsFields.length, (index) {
                                return TextFieldEntryBuilder(
                                  textFieldEntry:
                                      buyingsFields.values.toList()[index],
                                  onValueSelected: (key, value) {
                                    d.log("$key!, $value");
                                    if (buyingsFields[Values.quote_id]
                                                ?.object !=
                                            null &&
                                        buyingsFields[Values.quote_id]
                                            ?.object
                                            .value
                                            .isNotEmpty) {
                                      buyingsFields[Values.quote_id]
                                          ?.object
                                          .value
                                          .forEach((element) {
                                        if (element is Quote) {
                                          quote = element;
                                          buyings = element.trucker
                                              .map<TextEditingController>(
                                                  ((e) => TextEditingController(
                                                      text: '')))
                                              .toList();
                                        }
                                        if (element is QuoteC) {
                                          quoteC = element;
                                        }
                                        if (element is Buying) {
                                          buying = element;
                                          buyings = element.buyings
                                              .map<TextEditingController>(
                                                  ((e) => TextEditingController(
                                                      text: e)))
                                              .toList();
                                        }
                                      });
                                    }
                                    setState(() {});
                                  },
                                  focusHandler: (isLast) {
                                    isLast
                                        ? FocusScope.of(context).unfocus()
                                        : focusOnNextVisible(
                                            index, buyingsFields);
                                  },
                                );
                              }),
                            ),
                            if (quote != null)
                              Container(
                                  margin: const EdgeInsets.all(25),
                                  child: ViewQuote(quote: quote!)),
                            if (quoteC != null)
                              Container(
                                  margin: const EdgeInsets.all(25),
                                  child: ViewQuotec(quoteC: quoteC!)),
                            Builder(builder: (context) {
                              if (quote == null) {
                                return const Center(
                                  child: Text("Please Select a Quote"),
                                );
                              }

                              if (quote?.trucker.isEmpty ?? false) {
                                return const Center(
                                    child: Text(
                                        "No Truckers Selected in this Quote"));
                              } else {
                                return Column(
                                  children: [
                                    const Text(
                                      "Buyings",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: quote?.trucker.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 50,
                                            margin: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 127, 169, 190),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                    "   ${quote?.trucker[index].partyName} (${quote?.trucker[index].orgName})\t"),
                                                Text(
                                                    "   ${quote?.trucker[index].emailId}\t"),
                                                Text(
                                                    "   ${quote?.trucker[index].phone}\t"
                                                        .padRight(12)),
                                                SizedBox(
                                                    width: 100,
                                                    child: TextFormField(
                                                      controller:
                                                          buyings[index],
                                                      validator: isNotBlank,
                                                      decoration: InputDecoration(
                                                          hintText: '',
                                                          fillColor: Colors
                                                              .white
                                                              .withOpacity(0.6),
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                          filled: true,
                                                          errorStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .redAccent),
                                                          disabledBorder:
                                                              const OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color: Colors
                                                                              .grey)),
                                                          border:
                                                              const OutlineInputBorder()),
                                                    ))
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              }
                            }),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ButtonCustm(
                                label: "Submit",
                                padding: 10,
                                function1: () {
                                  final Map<String, dynamic> values = {};

                                  if (quote != null &&
                                      _formKey.currentState!.validate() &&
                                      buyings.isNotEmpty) {
                                    values[Values.quote_id] = quote?.quoteId;
                                    values[Values.buyings] = buyings
                                        .map<String>((e) => e.text)
                                        .toList();

                                    d.log(values.toString());

                                    if (buying == null) {
                                      GetIt.I<CreateBuyingsCubit>()
                                          .create(values);
                                    } else {
                                      values[Values.sid] = buying?.sid;
                                      values.remove(Values.quote_id);
                                      GetIt.I<CreateBuyingsCubit>()
                                          .edit(values);
                                    }
                                  }
                                },
                              ),
                            )
                          ],
                        ),
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
