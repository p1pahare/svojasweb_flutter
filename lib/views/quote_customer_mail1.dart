import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuoteCustomerMail1 extends StatefulWidget {
  static const routeName = '/QuoteCustomerMail1';
  const QuoteCustomerMail1({Key? key, this.party, this.quote})
      : super(key: key);
  final Party? party;
  final Quote? quote;
  @override
  State<QuoteCustomerMail1> createState() => _QuoteCustomerMail1State();
}

class _QuoteCustomerMail1State extends State<QuoteCustomerMail1> {
  late WebViewController _controller;

  Future<String> feedHtml() async {
    return await rootBundle.loadString("lib/assets/customer_html.html");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acknowledge Customer"),
      ),
      body: FutureBuilder<String>(
          future: feedHtml(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 30),
                        color: Colors.white,
                        child: Center(
                          child: WebView(
                            initialUrl: 'about:blank',
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              _controller = webViewController;
                              _controller.loadHtmlString(snapshot.data!);
                            },
                          ),
                        )),
                  ),
                  ButtonCustm(label: 'Confirm', function1: () {}),
                ],
              );
            }
          }),
    );
  }
}
