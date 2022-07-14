import 'package:flutter/material.dart';

class CheckboxFieldCustm extends StatelessWidget {
  const CheckboxFieldCustm(
      {Key? key,
      required this.controller,
      this.label = '',
      this.showLabel = false,
      required this.focusNode,
      this.enabled = true,
      this.onDone})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final bool enabled;
  final bool showLabel;
  final FocusNode focusNode;
  final void Function(String?)? onDone;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: controller.text == 'Yes',
      onChanged: (isYes) {
        if (enabled) {
          (isYes ?? false) ? controller.text = 'Yes' : 'No';
        }
        onDone?.call(controller.text);
      },
      focusNode: focusNode,
      title: Text(showLabel ? label : ''),
    );
  }
}
