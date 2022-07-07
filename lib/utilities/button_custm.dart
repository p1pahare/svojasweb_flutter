import 'package:flutter/material.dart';

class ButtonCustm extends StatelessWidget {
  const ButtonCustm(
      {Key? key,
      this.label = '',
      this.function1,
      this.function2,
      this.padding = 18.0,
      this.function3})
      : super(key: key);
  final String label;
  final double padding;
  final VoidCallback? function1;
  final Future<void>? function2;
  final Future<void>? function3;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        // style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange, ),),

        onPressed: () async {
          if (function1 != null) {
            function1!.call();
          }
          if (function2 != null) {
            await function2;
          }
          if (function3 != null) {
            await function3;
          }
        },
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Text(label),
        ));
  }
}
