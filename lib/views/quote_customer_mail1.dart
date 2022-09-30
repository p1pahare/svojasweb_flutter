import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/repositories/basic_repository.dart';
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

  Future<List<String?>> feedHtml() async {
    if (widget.party == null || widget.quote == null) {
      return [null, null];
    } else {
      String body =
          await rootBundle.loadString("lib/assets/customer_html.html");
      body = body
          .replaceFirst('yyyyCustomerNameyyyy', "${widget.party?.partyName}")
          .replaceAll('yyyyUseryyyy', '');
      return [
        "${widget.quote?.quoteId} // Quote Received // ${widget.party?.partyName} ${widget.party?.orgName}",
        body
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acknowledge Customer"),
      ),
      body: FutureBuilder<List<String?>>(
          future: feedHtml(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data?[0] == null || snapshot.data?[1] == null) {
              return const Center(child: Text("Something went Wrong"));
            } else {
              return Column(
                children: [
                  Text(
                    snapshot.data![0].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
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
                              _controller
                                  .loadHtmlString(snapshot.data![1].toString());
                            },
                          ),
                        )),
                  ),
                  ButtonCustm(
                      label: 'Confirm',
                      function1: () async {
                        final ApiResponse response =
                            await GetIt.I<BasicRepository>().sendMail(
                                email: widget.party?.emailId,
                                due: snapshot.data?[1],
                                task: snapshot.data?[0]);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(response.data.toString()),
                          duration: const Duration(seconds: 2),
                        ));
                        await Future.delayed(const Duration(seconds: 3));
                        if (response.status) Navigator.pop(context);
                      }),
                ],
              );
            }
          }),
    );
  }
}
