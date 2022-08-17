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
import 'package:svojasweb/views/subviews/view_quote.dart';

class QuoteView extends StatefulWidget {
  const QuoteView({Key? key, required this.title}) : super(key: key);
  static const routeName = '/QuoteView';
  final String title;

  @override
  State<QuoteView> createState() => _QuoteViewState();
}

class _QuoteViewState extends State<QuoteView> {
  EasyTableModel<Quote>? _model;
  final GlobalKey<ScaffoldState> _scaff = GlobalKey();
  @override
  void initState() {
    loadPage();
    super.initState();
  }

  loadPage() {
    GetIt.I<QuoteCubit>().load();
  }

  loadModel(BuildContext context, List<Quote> quotes) {
    double width = (MediaQuery.of(context).size.width - 170);
    _model = EasyTableModel<Quote>(rows: quotes, columns: [
      if (width > 270)
        EasyTableColumn(
          name: 'Quote ID',
          stringValue: (row) => row.quoteId,
          width: 120,
        ),
      if (width > 410)
        EasyTableColumn(
            name: 'Date', stringValue: (row) => row.date, width: 140),
      if (width > 430)
        EasyTableColumn(
            name: 'Customer',
            stringValue: (row) =>
                row.party.isEmpty ? "Deleted" : row.party[0].partyName,
            width: 120),
      if (width > 670)
        EasyTableColumn(
            name: 'Type of Move',
            stringValue: (row) => row.typeOfMove,
            width: 130),
      if (width > 800)
        EasyTableColumn(
            name: 'Shipment Mode',
            stringValue: (row) => row.transitType,
            width: 130),
      if (width > 930)
        EasyTableColumn(
            name: 'Gross Weight',
            stringValue: (row) => row.grossWeight,
            width: 130),
      if (width > 150)
        EasyTableColumn(
            name: 'Options',
            width: 150,
            cellBuilder: (context, row, index) => Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
      key: _scaff,
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
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (GetIt.I<QuoteCubit>().isPrevious())
                      MaterialButton(
                        child: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          GetIt.I<QuoteCubit>().prviousPage();
                        },
                      )
                    else
                      const SizedBox(
                        width: 60,
                      ),
                    if (state.quotes?.isNotEmpty ?? false)
                      MaterialButton(
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          GetIt.I<QuoteCubit>().nextPage();
                        },
                      )
                    else
                      const SizedBox(
                        width: 60,
                      ),
                  ],
                ),
                Expanded(
                  child: EasyTableTheme(
                      child: EasyTable<Quote>(
                        _model,
                        onRowTap: selectCustomer,
                        columnsFit: true,
                      ),
                      data: const EasyTableThemeData(
                          columnDividerThickness: 0,
                          columnDividerColor: Colors.blue,
                          cell: CellThemeData(
                            textStyle: TextStyle(color: Colors.black),
                          ),
                          scrollbar: TableScrollbarThemeData(),
                          row: RowThemeData(
                              dividerThickness: 2,
                              dividerColor: Colors.green))),
                ),
              ],
            );
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

  void selectCustomer(Quote quote) {
    _scaff.currentState?.showBottomSheet(
        (context) => Column(
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                            child: ViewQuote(quote: quote)))),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
        backgroundColor: Colors.white,
        constraints: BoxConstraints.tight(
            Size.fromHeight(MediaQuery.of(context).size.height * 0.75)));
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
