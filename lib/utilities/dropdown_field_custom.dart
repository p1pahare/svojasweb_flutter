import 'package:flutter/material.dart';

class DropDownFieldCustm extends StatelessWidget {
  const DropDownFieldCustm(
      {Key? key,
      required this.controller,
      this.obscure = false,
      this.label = '',
      this.showLabel = false,
      required this.focusNode,
      this.validate,
      this.options = const ['Select'],
      this.onDone})
      : super(key: key);
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final bool showLabel;
  final List<String>? options;
  final String? Function(String?)? validate;
  final FocusNode focusNode;
  final void Function(String?)? onDone;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) Text(label),
        DropdownButtonFormField<String>(
          value: options?.first,
          items: options
              ?.map<DropdownMenuItem<String>>(
                  (e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validate ?? (str) => null,
          onChanged: (str) {
            controller.text = str ?? '';
            if (onDone != null) {
              onDone!(str);
            }
          },
          decoration: InputDecoration(
              hintText: label,
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
