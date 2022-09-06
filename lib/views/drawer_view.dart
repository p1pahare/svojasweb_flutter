import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/services/preferences.dart';
import 'package:svojasweb/views/bol_view.dart';
import 'package:svojasweb/views/dashboard_view.dart';
import 'package:svojasweb/views/login_view.dart';
import 'package:svojasweb/views/party_view.dart';
import 'package:svojasweb/views/quote_view.dart';
import 'package:svojasweb/views/quotec_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

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
            onTap: () =>
                Navigator.popAndPushNamed(context, DashboardView.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Party'),
            onTap: () =>
                Navigator.popAndPushNamed(context, PartyView.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('Quote'),
            onTap: () =>
                Navigator.popAndPushNamed(context, QuoteView.routeName),
          ),
          ListTile(
              leading: const Icon(Icons.api),
              title: const Text('Quote Confirm'),
              onTap: () =>
                  Navigator.popAndPushNamed(context, QuotecView.routeName)),
          ListTile(
            leading: const Icon(Icons.api),
            title: const Text('BOL Page'),
            onTap: () => Navigator.popAndPushNamed(context, BolView.routeName),
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
