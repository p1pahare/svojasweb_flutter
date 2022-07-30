import 'dart:math';

import 'package:flutter/material.dart';

class KeyValueView extends StatelessWidget {
  const KeyValueView({Key? key, required this.skey, required this.value})
      : super(key: key);
  final String skey;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 28),
      width: max(480, MediaQuery.of(context).size.width / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 1,
              child: Text(
                skey,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
          Expanded(
              flex: 4,
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w200),
                textAlign: TextAlign.end,
              ))
        ],
      ),
    );
  }
}
