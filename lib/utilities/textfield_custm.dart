import 'dart:developer';

import 'package:flutter/material.dart';

class TextFieldCustm extends StatelessWidget {
  const TextFieldCustm(
      {Key? key,
      required this.controller,
      this.obscure = false,
      this.label = '',
      this.showLabel = false,
      required this.focusNode,
      this.validate,
      this.enabled = true,
      this.onDone})
      : super(key: key);
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final bool enabled;
  final bool showLabel;
  final String? Function(String?)? validate;
  final FocusNode focusNode;
  final void Function(String?)? onDone;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) Text(label),
        TextFormField(
          textInputAction: TextInputAction.done,
          controller: controller,
          obscureText: obscure,
          enabled: enabled,
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validate ?? (str) => null,
          onFieldSubmitted: onDone ?? (str) => log("field submitted"),
          decoration: InputDecoration(
              hintText: showLabel ? '' : label,
              fillColor: Colors.white.withOpacity(0.6),
              filled: true,
              errorStyle: const TextStyle(color: Colors.redAccent),
              disabledBorder: const OutlineInputBorder(),
              border: const OutlineInputBorder()),
        ),
      ],
    );
  }
}
