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
import 'package:svojasweb/views/subviews/view_quotec.dart';

class QuotecView extends StatefulWidget {
  const QuotecView({Key? key, required this.title}) : super(key: key);
  static const routeName = '/QuotecView';
  final String title;

  @override
  State<QuotecView> createState() => _QuotecViewState();
}

class _QuotecViewState extends State<QuotecView> {
  EasyTableModel<QuoteC>? _model;
  final GlobalKey<ScaffoldState> _scaff = GlobalKey();
  @override
  void initState() {
    loadPage();
    super.initState();
  }

  loadPage() {
    GetIt.I<QuotecCubit>().load();
  }

  loadModel(BuildContext context, List<QuoteC> quotecs) {
    double width = (MediaQuery.of(context).size.width - 60);
    _model = EasyTableModel<QuoteC>(rows: quotecs, columns: [
      if (width > 270)
        EasyTableColumn(
          name: 'Quote Number',
          stringValue: (row) => row.quoteNumber,
          width: 120,
        ),
      if (width > 410)
        EasyTableColumn(
            name: 'Quote Id',
            stringValue: (row) =>
                row.quote.isEmpty ? "Deleted" : row.quote[0].quoteId,
            width: 140),
      if (width > 530)
        EasyTableColumn(
            name: 'Chassis', stringValue: (row) => row.chassis, width: 120),
      if (width > 650)
        EasyTableColumn(
            name: 'Drayage Fuel',
            stringValue: (row) => row.drayageFuel,
            width: 120),
      if (width > 770)
        EasyTableColumn(
            name: 'Date', stringValue: (row) => row.date, width: 120),
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
                        onPressed: () => deleteCustomer(row.sId)),
                  ],
                )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      key: _scaff,
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
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (GetIt.I<QuotecCubit>().isPrevious())
                      MaterialButton(
                        child: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          GetIt.I<QuotecCubit>().prviousPage();
                        },
                      )
                    else
                      const SizedBox(
                        width: 60,
                      ),
                    if (state.quotecs?.isNotEmpty ?? false)
                      MaterialButton(
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          GetIt.I<QuotecCubit>().nextPage();
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
                      child: EasyTable<QuoteC>(
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
              await Navigator.pushNamed(context, CreateQuotecView.routeName);
          if (change ?? false) {
            loadPage();
          }
        },
      ),
      drawer: const DrawerView(),
    );
  }

  void selectCustomer(QuoteC quotec) {
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
                  child: SingleChildScrollView(
                      child: ViewQuotec(quoteC: quotec)))),
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
