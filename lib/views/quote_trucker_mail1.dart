import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/repositories/basic_repository.dart';
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

  Future<List<String?>> feedHtml() async {
    if (widget.party == null || widget.quote == null) {
      return [null, null];
    } else {
      String body = await rootBundle.loadString("lib/assets/trucker_html.html");
      body = body
          .replaceFirst('yyyyTruckerNameyyyy', "${widget.party?.partyName}")
          .replaceFirst('yyyyPortNameyyyy', "${widget.quote?.pickupRamp}")
          .replaceFirst('yyyyDeliverAddressFullyyyy',
              "${widget.quote?.deliveryAddress}, ${widget.quote?.deliveryCity}, ${widget.quote?.deliveryState}, ${widget.quote?.deliveryZip}")
          .replaceFirst(
              'yyyySizeOfContaineryyyy', "${widget.quote?.sizeOfContainer}")
          .replaceFirst(
              'yyyyTypeOfContaineryyyy', "${widget.quote?.typeOfContainer}")
          .replaceFirst('yyyyGrossWeightyyyy', "${widget.quote?.grossWeight}")
          .replaceFirst('yyyyCommodityyyyy', "${widget.quote?.commodity}")
          .replaceFirst('yyyyOnlyIfHazYesyyyy,',
              (widget.quote?.haz ?? false) ? "Only If Haz (Yes)" : "")
          .replaceFirst('yyyyOnlyIfReeferYesyyyy,',
              (widget.quote?.reefer ?? false) ? "Only If Reefer (Yes)" : "")
          .replaceFirst(
              'yyyyTemperatureyyyy',
              (widget.quote?.reefer ?? false)
                  ? "${widget.quote?.reeferTemp}"
                  : "")
          .replaceFirst(
              'yyyyHazUnNumberyyyy',
              (widget.quote?.haz ?? false)
                  ? "${widget.quote?.hazUnNumber}"
                  : "")
          .replaceFirst('yyyyHazClassyyyy',
              (widget.quote?.haz ?? false) ? "${widget.quote?.hazClass}" : "")
          .replaceFirst(
              'yyyyProperShippingNameyyyy',
              (widget.quote?.haz ?? false)
                  ? "${widget.quote?.hazProperShippingName}"
                  : "")
          .replaceAll('yyyyUseryyyy', '');
      return [
        "${widget.quote?.quoteId} // Quote Request (${widget.quote?.transitType}) // ${widget.party?.orgName}",
        body
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Rates to Trucker"),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data![0].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 30),
                        color: Colors.white,
                        child: Center(
                          child: AbsorbPointer(
                            child: WebView(
                              zoomEnabled: false,
                              initialUrl: 'about:blank',
                              onWebViewCreated:
                                  (WebViewController webViewController) {
                                _controller = webViewController;
                                _controller.loadHtmlString(
                                    snapshot.data![1].toString());
                              },
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ButtonCustm(
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
                  ),
                ],
              );
            }
          }),
    );
  }
}
