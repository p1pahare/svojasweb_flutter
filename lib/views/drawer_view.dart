import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/services/preferences.dart';
import 'package:svojasweb/views/bol_view.dart';
import 'package:svojasweb/views/create_party_view.dart';
import 'package:svojasweb/views/create_quote_view.dart';
import 'package:svojasweb/views/create_quotec_view.dart';
import 'package:svojasweb/views/dashboard_view.dart';
import 'package:svojasweb/views/login_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key, this.isDashboard = false}) : super(key: key);
  final bool isDashboard;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: Image.asset('lib/assets/profile_placeholder.png'),
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Dashboard'),
            onTap: () {
              if (!isDashboard) {
                Navigator.pop(context);
              }
              Navigator.popAndPushNamed(context, DashboardView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Party'),
            onTap: () {
              if (!isDashboard) {
                Navigator.pop(context);
              }
              Navigator.popAndPushNamed(context, CreatePartyView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Quote'),
            onTap: () {
              if (!isDashboard) {
                Navigator.pop(context);
              }
              Navigator.popAndPushNamed(context, CreateQuoteView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Quote to Customer'),
            onTap: () {
              if (!isDashboard) {
                Navigator.pop(context);
              }
              Navigator.popAndPushNamed(context, CreateQuotecView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Buyings Received'),
            onTap: () {
              if (!isDashboard) {
                Navigator.pop(context);
              }
              Navigator.popAndPushNamed(context, CreateQuotecView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Confirmed Quote'),
            onTap: () {
              if (!isDashboard) {
                Navigator.pop(context);
              }
              Navigator.popAndPushNamed(context, CreateQuotecView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Confirm Shipments'),
            onTap: () {
              if (!isDashboard) {
                Navigator.pop(context);
              }
              Navigator.popAndPushNamed(context, CreateQuotecView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('BOL Page (temp)'),
            onTap: () {
              if (!isDashboard) {
                Navigator.pop(context);
              }
              Navigator.popAndPushNamed(context, BolView.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_sharp),
            title: const Text('Log Out'),
            onTap: () {
              Navigator.pop(context);
              GetIt.I<Preferences>().saveIslogin();
              Navigator.pushReplacementNamed(context, LoginView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
