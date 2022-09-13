import 'dart:developer';

import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/port/port_cubit.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/port.dart';
import 'package:svojasweb/repositories/party_repository.dart';
import 'package:svojasweb/views/create_party_view.dart';
import 'package:svojasweb/views/drawer_view.dart';

class PortView extends StatefulWidget {
  const PortView({Key? key, required this.title}) : super(key: key);
  static const routeName = '/PartyView';
  final String title;

  @override
  State<PortView> createState() => _PortViewState();
}

class _PortViewState extends State<PortView> {
  late EasyTableModel<Port>? _model;
  final GlobalKey<ScaffoldState> _scaff = GlobalKey();
  @override
  void initState() {
    loadPage();
    super.initState();
  }

  loadPage() {
    GetIt.I<PortCubit>().loadPorts();
  }

  loadModel(BuildContext context, List<Port> ports) {
    double width = (MediaQuery.of(context).size.width - 170);
    _model = EasyTableModel<Port>(rows: ports, columns: [
      if (width > 410)
        EasyTableColumn(
          name: 'Port Type',
          stringValue: (row) => row.portType,
          width: 130,
        ),
      if (width > 280)
        EasyTableColumn(
            name: 'Port Name', stringValue: (row) => row.portName, width: 130),
      if (width > 560)
        EasyTableColumn(
            name: 'Port Code', stringValue: (row) => row.portCode, width: 150),
      if (width > 710)
        EasyTableColumn(
            name: 'State', stringValue: (row) => row.stateName, width: 150),
      if (width > 910)
        EasyTableColumn(
            name: 'Zip Code', stringValue: (row) => row.zipCode, width: 150),
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
      body: BlocBuilder<PortCubit, PortState>(
        bloc: GetIt.I<PortCubit>(),
        builder: (context, state) {
          if (state is CreatePortLoading) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
          if (state is CreatePortFailed) {
            return Text(state.errorMessage!);
          }
          if (state is ListSuccess) {
            loadModel(context, state.ports!);
            return Column(
              children: [
                Expanded(
                  child: EasyTableTheme(
                      child: EasyTable<Port>(
                        _model,
                        onRowTap: (port) => log(port.toString()),
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
              await Navigator.pushNamed(context, CreatePartyView.routeName);
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
              title: const Text("Delete Party"),
              actions: [
                OutlinedButton(
                    style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.blueGrey))),
                    onPressed: () async {
                      ApiResponse apiResponse =
                          await GetIt.I<PartyRepository>().deleteParty(sId);
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
                "Do you really want to delete this Party",
              ));
        });
    if (delete != null && delete) {
      loadPage();
    }
  }
}
