import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuoteTruckerMail1 extends StatefulWidget {
  static const routeName = '/QuoteTruckerMail1';
  const QuoteTruckerMail1({Key? key, this.party, this.quote}) : super(key: key);
  final Party? party;
  final Quote? quote;
  @override
  State<QuoteTruckerMail1> createState() => _QuoteTruckerMail1State();
}

class _QuoteTruckerMail1State extends State<QuoteTruckerMail1> {
  late WebViewController _controller;

  Future<String> feedHtml() async {
    return await rootBundle.loadString("lib/assets/trucker_html.html");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Rates to Trucker"),
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
