import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/create_buyings/create_buyings_cubit.dart';
import 'package:svojasweb/models/buying.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/repositories/values.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'dart:developer' as d;
import 'package:svojasweb/utilities/textfield_entry_builder.dart';
import 'package:svojasweb/views/drawer_view.dart';

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

  Map<String, TextFieldEntry> buyingsFields = {};

  void initBuyings() {}

  @override
  void initState() {
    initBuyings();

    // if (widget.quotec != null) {

    // }
    // GetIt.I<CreateBuyingsCubit>().load();

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
                                onValueSelected: (key, value) =>
                                    d.log("$key!, $value"),
                                focusHandler: (isLast) {
                                  isLast
                                      ? FocusScope.of(context).unfocus()
                                      : focusOnNextVisible(
                                          index, buyingsFields);
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
                                  for (final element in buyingsFields.entries)
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
                                  d.log(values.toString());
                                  if ((buyingsFields[Values.quote_id]?.object
                                          as Buying?) !=
                                      null) {
                                    values[Values.quote_id] =
                                        (buyingsFields[Values.quote_id]?.object
                                                as Quote?)
                                            ?.sid;
                                  }
                                  /*
                                  if (widget.quotec == null) {
                                    GetIt.I<CreateQuotecCubit>().create(values);
                                  } else {
                                    GetIt.I<CreateQuotecCubit>().edit(values);
                                  }
                                  */
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
