import 'dart:developer';
import 'package:adjusted_html_view_web/adjusted_html_view_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:svojasweb/utilities/button_custm.dart';
import 'dart:js' as js;
// ignore: avoid_web_libraries_in_flutter

class BolView extends StatefulWidget {
  const BolView({Key? key}) : super(key: key);
  static const routeName = '/BolView';

  @override
  State<BolView> createState() => _BolViewState();
}

class _BolViewState extends State<BolView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _tec = TextEditingController();

  String htmlText = """
<!DOCTYPE html>
<html>
<body>

<h2>The window.print() Method</h2>

<p>Click the button to print the current page.</p>

<a href="javascript:window.print()">Print this page</a>

</body>
</html>
""";

  String pickupWareHouse = """
TRT INTERNATIONAL
250 Port Street Newark, NJ 07114
                      """;
  String referenceNumber = """SVJ22325-B""";
  String customerRefernce = """AMFU4992206""";
  String deliveryWarehouse = """
ECOPAX LLC
1355 EASTON ROAD,BETHLEHEM
BETHLEHEM PA 18015
                      """;
  String billTo = """
Svojas Inc.
Five Greentree Centre
525 NJ-73 Ste 104, 
Marlton, NJ 08053
""";
  String carrier = """
De Mase Trucking""";
  String noOfPackages = " 3 ";
  String commodity = """
SERVE PLUG ASSIST (ON THE MACHINE)
METAL PANELS MOUNTING PADS
HS CODE : 848079 HS CODE : 847740
VACUUM PUMP IN WC (PART OF MACHINE
KGM HLC0011270 )HS
CODE 847740
PRE-HEATER HS CODE 847990
ROLL LIFTER (PART OF MACHINE )HS CODE
847740
METAL PANELS (PART OF MACHINE )HS CODE
847740
METAL PANELS AND MECHANICAL PARTS IN
WC (PART OF
MACHINE )HS CODE 847740
""";
  String grossWeight = "100000lbs";
  String wareHouseLoaderSign = """
                
                
                          """;

  String gateIn = """    """;
  String gateOut = """    """;

  @override
  void initState() {
    feedHtml();
    super.initState();
  }

  Future feedHtml() async {
    htmlText = await rootBundle.loadString("lib/assets/bill_of_lading.html");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 28.0,
            horizontal: MediaQuery.of(context).size.width / 6,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderImage(),
                const SubHeading(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextColumn(
                      title: "Pickup Warehouse:",
                      value: pickupWareHouse,
                      onTap: () => getText().then((value) => value != null
                          ? setState(() => pickupWareHouse = value)
                          : null),
                    ),
                    const Expanded(child: WidthBlock()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextColumn(
                          title: "Reference Number:",
                          value: referenceNumber,
                          onTap: () => getText().then((value) => value != null
                              ? setState(() => referenceNumber = value)
                              : null),
                        ),
                        TextColumn(
                          title: "Customer Reference:",
                          value: customerRefernce,
                          onTap: () => getText().then((value) => value != null
                              ? setState(() => customerRefernce = value)
                              : null),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextColumn(
                      title: "Delivery Warehouse:",
                      value: deliveryWarehouse,
                      onTap: () => getText().then((value) => value != null
                          ? setState(() => deliveryWarehouse = value)
                          : null),
                    ),
                    const Expanded(child: WidthBlock()),
                    TextColumn(
                      title: "Bill To:",
                      value: billTo,
                      onTap: () => getText().then((value) => value != null
                          ? setState(() => billTo = value)
                          : null),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextColumn(
                      title: "Carrier:",
                      value: carrier,
                      onTap: () => getText().then((value) => value != null
                          ? setState(() => carrier = value)
                          : null),
                    ),
                    const Expanded(child: WidthBlock()),
                    const WidthBlock(),
                  ],
                ),
                const Divider(
                  color: Colors.black,
                ),
                const HeightBlock(),
                const Divider(
                  color: Colors.black,
                ),
                TableRow(
                  data1: "No of Packages",
                  data2: "Commodity Description",
                  data3: "Gross Weight",
                  isBold: true,
                  onTap: () {
                    getText().then((value) => value != null
                        ? setState(() => noOfPackages = value)
                        : null);
                  },
                  onTap2: () {
                    getText().then((value) => value != null
                        ? setState(() => commodity = value)
                        : null);
                  },
                  onTap3: () {
                    getText().then((value) => value != null
                        ? setState(() => grossWeight = value)
                        : null);
                  },
                ),
                const Divider(
                  color: Colors.black,
                ),
                TableRow(
                  data1: noOfPackages,
                  data2: commodity,
                  data3: grossWeight,
                  haveDivider: true,
                  onTap: () {
                    getText().then((value) => value != null
                        ? setState(() => noOfPackages = value)
                        : null);
                  },
                  onTap2: () {
                    getText().then((value) => value != null
                        ? setState(() => commodity = value)
                        : null);
                  },
                  onTap3: () {
                    getText().then((value) => value != null
                        ? setState(() => grossWeight = value)
                        : null);
                  },
                ),
                const Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextColumn(
                        title: "Warehouse Loader Sign:",
                        value: wareHouseLoaderSign,
                        onTap: () => getText().then((value) => value != null
                            ? setState(() => wareHouseLoaderSign = value)
                            : null),
                      ),
                      const Expanded(child: Center(child: WidthBlock())),
                      const VerticalDivider(
                        width: 2.5,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextColumn(
                                title: "Gate In:",
                                value: gateIn,
                                onTap: () => getText().then((value) =>
                                    value != null
                                        ? setState(() => gateIn = value)
                                        : null),
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextColumn(
                                title: "Gate Out:",
                                value: gateOut,
                                onTap: () => getText().then((value) =>
                                    value != null
                                        ? setState(() => gateOut = value)
                                        : null),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const HeightBlock(),
                ButtonCustm(
                  label: 'Print',
                  function1: () async {
                    await feedHtml();
                    htmlText = htmlText
                        .replaceAll("yyyypickupWarehouseyyyy", pickupWareHouse)
                        .replaceAll("yyyyreferenceNumberyyyy", referenceNumber)
                        .replaceAll("yyyydateyyyy",
                            DateFormat("MMMM dd, yyyy").format(DateTime.now()))
                        .replaceAll(
                            "yyyycustomerReferenceyyyy", customerRefernce)
                        .replaceAll(
                            "yyyydeliveryWarehouseyyyy", deliveryWarehouse)
                        .replaceAll("yyyycarrieryyyy", carrier)
                        .replaceAll("yyyynoOfPackagesyyyy", noOfPackages)
                        .replaceAll("yyyycommodityyyyy", commodity)
                        .replaceAll("yyyygrossWeightyyyy", grossWeight)
                        .replaceAll(
                            "yyyywarehouseLoaderSignyyyy", wareHouseLoaderSign)
                        .replaceAll("yyyygateInyyyy", gateIn)
                        .replaceAll("yyyygateOutyyyy", gateOut);
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                HtmlView(htmlText: htmlText)));
                    await Future.delayed(const Duration(seconds: 3));
                    // js.context.callMethod('print');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> getText() async {
    return await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Enter Value"),
              content: SizedBox(
                width: 320,
                child: TextField(
                  controller: _tec,
                  minLines: 3,
                  maxLines: 5,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, null),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () => Navigator.pop(context, _tec.text),
                    child: const Text("OK")),
              ],
            ));
  }
}

class TableRow extends StatelessWidget {
  const TableRow(
      {Key? key,
      required this.data1,
      required this.data2,
      required this.data3,
      required this.onTap,
      required this.onTap2,
      required this.onTap3,
      this.haveDivider = false,
      this.isBold = false})
      : super(key: key);
  final String data1;
  final String data2;
  final String data3;
  final VoidCallback onTap;
  final VoidCallback onTap2;
  final VoidCallback onTap3;
  final bool isBold;
  final bool haveDivider;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: data1,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
          style: TextStyle(
              fontSize: 18,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        if (haveDivider) const VerticalDivider(),
        Expanded(
            child: Center(
          child: Text.rich(
            TextSpan(
              text: data2,
              recognizer: TapGestureRecognizer()..onTap = onTap2,
            ),
            style: TextStyle(
              fontSize: 18,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.start,
          ),
        )),
        if (haveDivider)
          const Divider(
            thickness: 2,
            color: Colors.red,
          ),
        Text.rich(
          TextSpan(
            text: data3,
            recognizer: TapGestureRecognizer()..onTap = onTap3,
          ),
          style: TextStyle(
              fontSize: 18,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}

class WidthBlock extends StatelessWidget {
  const WidthBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 6,
    );
  }
}

class HeightBlock extends StatelessWidget {
  const HeightBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
    );
  }
}

class SubHeading extends StatelessWidget {
  const SubHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
                text: '525 NJ-73 Ste 104, Marlton, NJ 08053  |  P: '),
            TextSpan(
              text: ' 201-490-0220 ',
              style: const TextStyle(color: Colors.blueAccent),
              recognizer: TapGestureRecognizer()
                ..onTap = () => log('Tap Here onTap'),
            ),
            const TextSpan(text: ' | E: '),
            TextSpan(
              text: '  info@svojasinc.com ',
              style: const TextStyle(color: Colors.blueAccent),
              recognizer: TapGestureRecognizer()
                ..onTap = () => log('Tap Here onTap'),
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('lib/assets/picture_1.png'),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            "Order Confirmation",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 35),
          ),
        ),
      ],
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn(
      {Key? key, required this.title, required this.value, required this.onTap})
      : super(key: key);
  final String title;
  final String value;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: RichText(
        text: TextSpan(
          text: '$title\n',
          recognizer: TapGestureRecognizer()..onTap = onTap,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          children: [
            TextSpan(
              text: value,
              recognizer: TapGestureRecognizer()..onTap = onTap,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class HtmlView extends StatelessWidget {
  const HtmlView({Key? key, required this.htmlText}) : super(key: key);
  final String htmlText;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 30),
      color: Colors.white,
      child: AdjustedHtmlView(
        htmlText: htmlText,
        htmlValidator: HtmlValidator.loose(),
      ),
    ));
  }
}
