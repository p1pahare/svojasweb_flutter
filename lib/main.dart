import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/blocs/buying/buying_cubit.dart';
import 'package:svojasweb/blocs/create_buyings/create_buyings_cubit.dart';
import 'package:svojasweb/blocs/create_party/create_party_cubit.dart';
import 'package:svojasweb/blocs/create_quote/create_quote_cubit.dart';
import 'package:svojasweb/blocs/create_quotec/create_quotec_cubit.dart';
import 'package:svojasweb/blocs/create_shipment/create_shipment_cubit.dart';
import 'package:svojasweb/blocs/dashboard/dashboard_cubit.dart';
import 'package:svojasweb/blocs/login/login_cubit.dart';
import 'package:svojasweb/blocs/party/party_cubit.dart';
import 'package:svojasweb/blocs/port/port_cubit.dart';
import 'package:svojasweb/blocs/quote/quote_cubit.dart';
import 'package:svojasweb/blocs/quotec/quotec_cubit.dart';
import 'package:svojasweb/blocs/shipment/shipment_cubit.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/basic_repository.dart';
import 'package:svojasweb/repositories/buying_repository.dart';
import 'package:svojasweb/repositories/cquote_repository.dart';
import 'package:svojasweb/repositories/party_repository.dart';
import 'package:svojasweb/repositories/port_repository.dart';
import 'package:svojasweb/repositories/quote_repository.dart';
import 'package:svojasweb/repositories/quotec_repostiory.dart';
import 'package:svojasweb/services/preferences.dart';
import 'package:svojasweb/views/bol_view.dart';
import 'package:svojasweb/views/buyings_received_view.dart';
import 'package:svojasweb/views/confirm_shipments.dart';
import 'package:svojasweb/views/confirmed_quote_view.dart';
import 'package:svojasweb/views/create_party_view.dart';
import 'package:svojasweb/views/create_port_view.dart';
import 'package:svojasweb/views/create_quote_view.dart';
import 'package:svojasweb/views/create_quotec_view.dart';
import 'package:svojasweb/views/dashboard_view.dart';
import 'package:svojasweb/views/login_view.dart';
import 'package:svojasweb/views/party_view.dart';
import 'package:svojasweb/views/port_view.dart';
import 'package:svojasweb/views/quote_customer_mail1.dart';
import 'package:svojasweb/views/quote_trucker_mail1.dart';
import 'package:svojasweb/views/quote_view.dart';
import 'package:svojasweb/views/quotec_view.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() {
  usePathUrlStrategy();
  WebView.platform = WebWebViewPlatform();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  setup() {
    GetIt.I.registerSingleton(Preferences());
    GetIt.I.registerSingleton(LoginCubit());
    GetIt.I.registerSingleton(DashboardCubit());
    GetIt.I.registerSingleton(BasicRepository());
    GetIt.I.registerSingleton(PartyRepository());
    GetIt.I.registerSingleton(QuoteRepository());
    GetIt.I.registerSingleton(QuotecRepository());
    GetIt.I.registerSingleton(BuyingRepository());
    GetIt.I.registerSingleton(CquoteRepository());
    GetIt.I.registerSingleton(PartyCubit());
    GetIt.I.registerSingleton(CreatePartyCubit());
    GetIt.I.registerSingleton(QuoteCubit());
    GetIt.I.registerSingleton(CreateQuoteCubit());
    GetIt.I.registerSingleton(QuotecCubit());
    GetIt.I.registerSingleton(CreateQuotecCubit());
    GetIt.I.registerSingleton(CreateBuyingsCubit());
    GetIt.I.registerSingleton(CreateShipmentCubit());
    GetIt.I.registerSingleton(BuyingCubit());
    GetIt.I.registerSingleton(ShipmentCubit());
    GetIt.I.registerSingleton(PortCubit());
    GetIt.I.registerSingleton(PortRepository());
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
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: MaterialApp(
                theme: ThemeData(
                    primarySwatch: Colors.blueGrey, disabledColor: Colors.grey),
                debugShowCheckedModeBanner: false,
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case CreatePartyView.routeName:
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => const CreatePartyView(
                                title: 'Create Party',
                              ));
                    case CreatePartyView.routeNameEdit:
                      Party customer = settings.arguments as Party;
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => CreatePartyView(
                                party: customer,
                                title: 'Edit Party',
                              ));
                    case CreatePortView.routeName:
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => const CreatePortView(
                                title: 'Create a Port',
                              ));
                    case CreateQuoteView.routeName:
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => const CreateQuoteView(
                                title: 'Create Quote',
                              ));
                    case CreateQuoteView.routeNameEdit:
                      Quote customer = settings.arguments as Quote;
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => CreateQuoteView(
                                quote: customer,
                                title: 'Edit Quote',
                              ));
                    case CreateQuotecView.routeName:
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => const CreateQuotecView(
                                title: 'Create Quote to Customer',
                              ));
                    case CreateQuotecView.routeNameEdit:
                      QuoteC customer = settings.arguments as QuoteC;
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => CreateQuotecView(
                                quotec: customer,
                                title: 'Edit Quote to Customer',
                              ));
                    case BuyingsReceived.routeName:
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => BuyingsReceived(
                                title: 'Buyings Received',
                                preFilledValue: settings.arguments is String
                                    ? (settings.arguments as String)
                                    : null,
                              ));
                    case ConfirmedQuote.routeName:
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => ConfirmedQuote(
                                title: 'Confirmed Quote',
                                prefilledValue: settings.arguments is String
                                    ? (settings.arguments as String)
                                    : null,
                              ));
                    case ConfirmShipments.routeName:
                      return CupertinoPageRoute<bool>(
                          settings: settings,
                          builder: (context) => ConfirmShipments(
                                title: 'Confirm Shipments',
                                prefilledValue: settings.arguments is String
                                    ? (settings.arguments as String)
                                    : null,
                              ));
                    case DashboardView.routeName:
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => const DashboardView(
                                title: '',
                              ));
                    case QuoteCustomerMail1.routeName:
                      Map<String, dynamic> args =
                          settings.arguments as Map<String, dynamic>;
                      Party? party = args['party'];
                      Quote? quote = args['quote'];
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => QuoteCustomerMail1(
                                party: party,
                                quote: quote,
                              ));
                    case QuoteTruckerMail1.routeName:
                      Map<String, dynamic> args =
                          settings.arguments as Map<String, dynamic>;
                      Party? party = args['party'];
                      Quote? quote = args['quote'];
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => QuoteTruckerMail1(
                                party: party,
                                quote: quote,
                              ));
                    case PartyView.routeName:
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => const PartyView(
                                title: 'Party Management',
                              ));
                    case PortView.routeName:
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => const PortView(
                                title: 'Port Management',
                              ));
                    case QuoteView.routeName:
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => const QuoteView(
                                title: 'Quote Management',
                              ));
                    case QuotecView.routeName:
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => const QuotecView(
                                title: 'Quote to Customer',
                              ));
                    case LoginView.routeName:
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => const LoginView());
                    case BolView.routeName:
                      return CupertinoPageRoute(
                          settings: settings,
                          builder: (context) => const BolView());
                    case '/':
                    default:
                      if (!futureShot.data!) {
                        return CupertinoPageRoute(
                            settings: settings,
                            builder: (context) => const LoginView());
                      } else {
                        return CupertinoPageRoute(
                            settings: settings,
                            builder: (context) => const DashboardView(
                                  title: '',
                                ));
                      }
                  }
                },
              ),
            );
          }
        });
  }
}
