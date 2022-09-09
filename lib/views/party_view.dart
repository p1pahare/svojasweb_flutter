import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/party/party_cubit.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/repositories/party_repository.dart';
import 'package:svojasweb/views/create_party_view.dart';
import 'package:svojasweb/views/drawer_view.dart';
import 'package:svojasweb/views/subviews/view_party.dart';

class PartyView extends StatefulWidget {
  const PartyView({Key? key, required this.title}) : super(key: key);
  static const routeName = '/PartyView';
  final String title;

  @override
  State<PartyView> createState() => _PartyViewState();
}

class _PartyViewState extends State<PartyView> {
  late EasyTableModel<Party>? _model;
  final GlobalKey<ScaffoldState> _scaff = GlobalKey();
  @override
  void initState() {
    loadPage();
    super.initState();
  }

  loadPage() {
    GetIt.I<PartyCubit>().load();
  }

  loadModel(BuildContext context, List<Party> parties) {
    double width = (MediaQuery.of(context).size.width - 170);
    _model = EasyTableModel<Party>(rows: parties, columns: [
      if (width > 410)
        EasyTableColumn(
          name: 'Reference Id',
          stringValue: (row) => row.sid,
          width: 130,
        ),
      if (width > 280)
        EasyTableColumn(
            name: 'Customer Type',
            stringValue: (row) => row.partyType,
            width: 130),
      if (width > 560)
        EasyTableColumn(
            name: 'Party Name',
            stringValue: (row) => row.partyName,
            width: 150),
      if (width > 710)
        EasyTableColumn(
            name: 'Company Name',
            stringValue: (row) => row.orgName,
            width: 150),
      if (width > 910)
        EasyTableColumn(
            name: 'Email Id', stringValue: (row) => row.emailId, width: 150),
      if (width > 1010)
        EasyTableColumn(
            name: 'Contact Number',
            stringValue: (row) => row.phone,
            width: 140),
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
                              context, CreatePartyView.routeNameEdit,
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
                        onPressed: () => deleteCustomer(row.sid!)),
                  ],
                )),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      key: _scaff,
      body: BlocBuilder<PartyCubit, PartyState>(
        bloc: GetIt.I<PartyCubit>(),
        builder: (context, state) {
          if (state is PartyLoading) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
          if (state is PartyFailed) {
            return Text(state.errorMessage!);
          }
          if (state is PartySuccess) {
            loadModel(context, state.parties!);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (GetIt.I<PartyCubit>().isPrevious())
                      MaterialButton(
                        child: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          GetIt.I<PartyCubit>().prviousPage();
                        },
                      )
                    else
                      const SizedBox(
                        width: 60,
                      ),
                    if (state.parties?.isNotEmpty ?? false)
                      MaterialButton(
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                        onPressed: () {
                          GetIt.I<PartyCubit>().nextPage();
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
                      child: EasyTable<Party>(
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
              await Navigator.pushNamed(context, CreatePartyView.routeName);
          if (change ?? false) {
            loadPage();
          }
        },
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
