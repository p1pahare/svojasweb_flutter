import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/create_party/create_party_cubit.dart';
import 'package:svojasweb/blocs/create_quote/create_quote_cubit.dart';
import 'package:svojasweb/blocs/dashboard/dashboard_cubit.dart';
import 'package:svojasweb/blocs/login/login_cubit.dart';
import 'package:svojasweb/blocs/party/party_cubit.dart';
import 'package:svojasweb/blocs/quote/quote_cubit.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/repositories/network_calls.dart';
import 'package:svojasweb/services/preferences.dart';
import 'package:svojasweb/views/create_party_view.dart';
import 'package:svojasweb/views/create_quote_view.dart';
import 'package:svojasweb/views/dashboard_view.dart';
import 'package:svojasweb/views/login_view.dart';
import 'package:svojasweb/views/party_view.dart';
import 'package:svojasweb/views/quote_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  setup() {
    GetIt.I.registerSingleton(Preferences());
    GetIt.I.registerSingleton(LoginCubit());
    GetIt.I.registerSingleton(DashboardCubit());
    GetIt.I.registerSingleton(NetworkCalls());
    GetIt.I.registerSingleton(PartyCubit());
    GetIt.I.registerSingleton(CreatePartyCubit());
    GetIt.I.registerSingleton(QuoteCubit());
    GetIt.I.registerSingleton(CreateQuoteCubit());
  }

  @override
  Widget build(BuildContext context) {
    setup();
    return FutureBuilder<bool>(
        future: GetIt.I<Preferences>().readIslogin(),
        builder: (context, futureShot) {
          if (futureShot.connectionState == ConnectionState.waiting) {
            return const CupertinoApp(
              home: Center(child: Text("Loading")),
            );
          } else {
            return MaterialApp(
              theme: ThemeData(
                  primarySwatch: Colors.blueGrey, disabledColor: Colors.grey),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case CreatePartyView.routeName:
                    return CupertinoPageRoute<bool>(
                        builder: (context) => const CreatePartyView());
                  case CreatePartyView.routeNameEdit:
                    Party customer = settings.arguments as Party;
                    return CupertinoPageRoute<bool>(
                        builder: (context) => CreatePartyView(
                              party: customer,
                            ));
                  case CreateQuoteView.routeName:
                    return CupertinoPageRoute<bool>(
                        builder: (context) => const CreateQuoteView());
                  case CreateQuoteView.routeNameEdit:
                    Quote customer = settings.arguments as Quote;
                    return CupertinoPageRoute<bool>(
                        builder: (context) => CreateQuoteView(
                              quote: customer,
                            ));
                  case DashboardView.routeName:
                    return CupertinoPageRoute(
                        builder: (context) => const DashboardView(
                              title: '',
                            ));
                  case PartyView.routeName:
                    return CupertinoPageRoute(
                        builder: (context) => const PartyView(
                              title: 'Party Management',
                            ));
                  case QuoteView.routeName:
                    return CupertinoPageRoute(
                        builder: (context) => const QuoteView(
                              title: 'Quote Management',
                            ));
                  case LoginView.routeName:
                    return CupertinoPageRoute(
                        builder: (context) => const LoginView());
                  case '/':
                  default:
                    if (!futureShot.data!) {
                      return CupertinoPageRoute(
                          builder: (context) => const LoginView());
                    } else {
                      return CupertinoPageRoute(
                          builder: (context) => const DashboardView(
                                title: '',
                              ));
                    }
                }
              },
            );
          }
        });
  }
}
