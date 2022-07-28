import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/quotec/quotec_cubit.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/network_calls.dart';
import 'package:svojasweb/views/create_quotec_view.dart';
import 'package:svojasweb/views/drawer_view.dart';

class QuotecView extends StatefulWidget {
  const QuotecView({Key? key, required this.title}) : super(key: key);
  static const routeName = '/QuotecView';
  final String title;

  @override
  State<QuotecView> createState() => _QuotecViewState();
}

class _QuotecViewState extends State<QuotecView> {
  EasyTableModel<QuoteC>? _model;

  @override
  void initState() {
    loadPage();
    super.initState();
  }

  loadPage() {
    GetIt.I<QuotecCubit>().load();
  }

  loadModel(BuildContext context, List<QuoteC> quotecs) {
    double width = (MediaQuery.of(context).size.width - 170) / 100;
    _model = EasyTableModel<QuoteC>(rows: quotecs, columns: [
      EasyTableColumn(
        name: 'Quote Number',
        stringValue: (row) => row.quoteNumber,
        width: width * 15,
      ),
      EasyTableColumn(
          name: 'Date', stringValue: (row) => row.date, width: width * 15),
      EasyTableColumn(
          name: 'Quote Number',
          stringValue: (row) => row.quoteNumber,
          width: width * 20),
      EasyTableColumn(
          name: 'Chassis',
          stringValue: (row) => row.chassis,
          width: width * 10),
      EasyTableColumn(
          name: 'Drayage Fuel',
          stringValue: (row) => row.drayageFuel,
          width: width * 15),
      EasyTableColumn(
          name: 'pre PULL',
          stringValue: (row) => row.prePull,
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
                            context, CreateQuotecView.routeNameEdit,
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
                      onPressed: () => deleteCustomer(row.sId)),
                ],
              )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: BlocBuilder<QuotecCubit, QuotecState>(
        bloc: GetIt.I<QuotecCubit>(),
        builder: (context, state) {
          if (state is QuotecLoading) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
          if (state is QuotecFailed) {
            return Text(state.errorMessage!);
          }
          if (state is QuotecSuccess) {
            loadModel(context, state.quotecs!);
            return EasyTableTheme(
                child: EasyTable<QuoteC>(
                  _model,
                ),
                data: const EasyTableThemeData(
                    columnDividerThickness: 0,
                    columnDividerColor: Colors.blue,
                    cell: CellThemeData(
                      textStyle: TextStyle(color: Colors.black),
                    ),
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
              await Navigator.pushNamed(context, CreateQuotecView.routeName);
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
              title: const Text("Delete Quote Confirmation"),
              actions: [
                OutlinedButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.blueGrey))),
                    onPressed: () async {
                      ApiResponse apiResponse =
                          await GetIt.I<NetworkCalls>().deleteQuoteC(sId);
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
