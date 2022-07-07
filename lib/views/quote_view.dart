import 'dart:convert';

import 'package:easy_table/easy_table.dart';
import 'package:flutter/material.dart';
import 'package:svojasweb/models/customer.dart';
import 'package:svojasweb/utilities/dummy_data.dart';
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
  EasyTableModel<Customer>? _model;
  List<Customer> customers = [];
  @override
  void initState() {
    customers = (jsonDecode(jsonFormatCustomers)['data'] as List<dynamic>)
        .map<Customer>((e) => Customer.fromJson(e))
        .toList();
    _model = EasyTableModel<Customer>(rows: customers, columns: [
      EasyTableColumn(
          name: 'Reference Id', stringValue: (row) => row.sId, width: 170),
      EasyTableColumn(
          name: 'Customer Name',
          stringValue: (row) => row.customerName,
          width: 140),
      EasyTableColumn(
          name: 'Company Name', stringValue: (row) => row.companyName),
      EasyTableColumn(name: 'Email Id', stringValue: (row) => row.emailId),
      EasyTableColumn(name: 'Contact Number', stringValue: (row) => row.phone),
      EasyTableColumn(
          name: 'Customer Type', stringValue: (row) => row.customerType),
      EasyTableColumn(
          name: 'Options',
          width: 300,
          cellBuilder: (context, row, index) => Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final Customer? customer = await Navigator.pushNamed(
                          context, CreateQuoteView.routeNameEdit,
                          arguments: row);
                      if (customer != null) {
                        customers[index] = customer;
                        _model?.replaceRows(customers);
                      }
                    },
                    label: const Text("Edit"),
                    icon: const Icon(Icons.edit),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    // color: Colors.blueGrey,
                    onPressed: () => deleteCustomer(row.sId),
                    label: const Text("Delete"),
                    icon: const Icon(Icons.delete_rounded),
                  ),
                ],
              )),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: EasyTableTheme(
          child: EasyTable<Customer>(
            _model,
          ),
          data: const EasyTableThemeData(
              columnDividerThickness: 0,
              columnDividerColor: Colors.blue,
              scrollbar: TableScrollbarThemeData(),
              row: RowThemeData(
                  dividerThickness: 2, dividerColor: Colors.green))),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        mini: true,
        onPressed: () async {
          final Customer? customer =
              await Navigator.pushNamed(context, CreateQuoteView.routeName);
          if (customer != null) {
            customers.add(customer);
            _model?.replaceRows(customers);
          }
        },
      ),
      drawer: const DrawerView(),
    );
  }

  deleteCustomer(String sId) async {
    bool delete = (await showDialog<bool?>(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: const Text("Delete Customer"),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text("Yes")),
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text("Cancel")),
                  ],
                  content: const Text(
                    "Do you really want to delete this Customer",
                  ));
            })) ??
        false;
    if (delete) {
      _model?.removeRow(customers.where((element) => element.sId == sId).first);
    }
  }
}
