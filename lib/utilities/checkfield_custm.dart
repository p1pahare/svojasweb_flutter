import 'package:flutter/material.dart';
import 'package:svojasweb/utilities/textfield_custm.dart';

class CheckboxFieldCustm extends StatelessWidget {
  const CheckboxFieldCustm(
      {Key? key,
      required this.controller,
      this.label = '',
      this.showLabel = false,
      this.defValue,
      required this.focusNode,
      this.enabled = true,
      this.onDone})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final bool enabled;
  final bool showLabel;
  final String? defValue;
  final FocusNode focusNode;
  final void Function(String?)? onDone;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: controller.text.isNotEmpty,
      onChanged: (isYes) {
        if (enabled) {
          controller.text = (isYes ?? false) ? defValue ?? '.' : '';
        }
        onDone?.call(controller.text);
      },
      focusNode: focusNode,
      title: controller.text.isNotEmpty
          ? TextFieldCustm(
              controller: controller,
              label: label,
              focusNode: FocusNode(),
              showLabel: true,
              onDone: onDone,
            )
          : Text(
              showLabel ? label : '',
              style: const TextStyle(color: Colors.black),
            ),
    );
  }
}
