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
      this.onChange,
      this.onDone})
      : super(key: key);
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final bool enabled;
  final bool showLabel;
  final String? Function(String?)? validate;
  final FocusNode focusNode;
  final void Function(String?)? onChange;
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
          readOnly: !enabled,
          keyboardType: TextInputType.text,
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validate ?? (str) => null,
          onChanged: onChange ?? (str) => log("field changed"),
          onFieldSubmitted: onDone ?? (str) => log("field submitted"),
          decoration: InputDecoration(
              hintText: showLabel ? '' : label,
              fillColor: Colors.white.withOpacity(0.6),
              labelStyle: const TextStyle(color: Colors.grey),
              filled: true,
              errorStyle: const TextStyle(color: Colors.redAccent),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: const OutlineInputBorder()),
        ),
      ],
    );
  }
}
