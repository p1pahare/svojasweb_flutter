import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/quote/quote_cubit.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/repositories/network_calls.dart';
import 'package:svojasweb/views/create_quote_view.dart';
import 'package:svojasweb/views/drawer_view.dart';

class QuoteView extends StatefulWidget {
  const QuoteView({Key? key, required this.title}) : super(key: key);
  static const routeName = '/QuoteView';
  final String title;

  @override
  State<QuoteView> createState() => _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  EasyTableModel<Quote>? _model;

  @override
  void initState() {
    loadPage();
    super.initState();
  }

  loadPage() {
    GetIt.I<QuoteCubit>().load();
  }

  loadModel(BuildContext context, List<Quote> quotes) {
    double width = (MediaQuery.of(context).size.width - 170) / 100;
    _model = EasyTableModel<Quote>(rows: quotes, columns: [
      EasyTableColumn(
        name: 'Quote Number',
        stringValue: (row) => row.sid,
        width: width * 15,
      ),
      EasyTableColumn(
          name: 'Date', stringValue: (row) => row.date, width: width * 15),
      EasyTableColumn(
          name: 'Customer',
          stringValue: (row) => row.customer,
          width: width * 20),
      EasyTableColumn(
          name: 'Type of Move',
          stringValue: (row) => row.typeOfMove,
          width: width * 10),
      EasyTableColumn(
          name: 'Transit Type',
          stringValue: (row) => row.transitType,
          width: width * 15),
      EasyTableColumn(
          name: 'Gross Weight',
          stringValue: (row) => row.grossWeight,
          width: width * 15),
      EasyTableColumn(
          name: 'Options',
          width: 150,
          cellBuilder: (context, row, index) => Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit_sharp,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      onPressed: () async {
                        final bool? change = await Navigator.pushNamed(
                            context, CreateQuoteView.routeNameEdit,
                            arguments: row);
                        if (change ?? false) {
                          loadPage();
                        }
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.dangerous_rounded,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      onPressed: () => deleteCustomer(row.sid)),
                ],
              )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: BlocBuilder<QuoteCubit, QuoteState>(
        bloc: GetIt.I<QuoteCubit>(),
        builder: (context, state) {
          if (state is QuoteLoading) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
          if (state is QuoteFailed) {
            return Text(state.errorMessage!);
          }
          if (state is QuoteSuccess) {
            loadModel(context, state.quotes!);
            return EasyTableTheme(
                child: EasyTable<Quote>(
                  _model,
                ),
                data: const EasyTableThemeData(
                    columnDividerThickness: 0,
                    columnDividerColor: Colors.blue,
                    scrollbar: TableScrollbarThemeData(),
                    row: RowThemeData(
                        dividerThickness: 2, dividerColor: Colors.green)));
          }
          return const SizedBox(
            height: 0,
            width: 0,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        mini: true,
        onPressed: () async {
          final bool? change =
              await Navigator.pushNamed(context, CreateQuoteView.routeName);
          if (change ?? false) {
            loadPage();
          }
        },
      ),
      drawer: const DrawerView(),
    );
  }

  deleteCustomer(String sId) async {
    bool? delete = await showDialog<bool?>(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Delete Quote"),
              actions: [
                OutlinedButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.blueGrey))),
                    onPressed: () async {
                      ApiResponse apiResponse =
                          await GetIt.I<NetworkCalls>().deleteQuote(sId);
                      Navigator.pop(context, apiResponse.status);
                    },
                    child: const Text("Yes")),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("Cancel")),
              ],
              content: const Text(
                "Do you really want to delete this Quote",
              ));
        });
    if (delete != null && delete) {
      loadPage();
    }
  }
}
