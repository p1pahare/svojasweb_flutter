import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/utilities/datefield_custm.dart';
import 'package:svojasweb/utilities/dropdown_field_custom.dart';
import 'package:svojasweb/utilities/textfield_custm.dart';

class TextFieldEntryBuilder extends StatelessWidget {
  const TextFieldEntryBuilder(
      {Key? key, this.textFieldEntry, this.onValueSelected, this.focusHandler})
      : super(key: key);
  final TextFieldEntry? textFieldEntry;
  final void Function(String?, String?)? onValueSelected;
  final void Function(bool)? focusHandler;
  @override
  Widget build(BuildContext context) {
    if (!textFieldEntry!.visible) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: min(460, MediaQuery.of(context).size.width - 40),
        child: Builder(builder: (context) {
          if (textFieldEntry?.fieldType == FieldType.dropdown) {
            return DropDownFieldCustm(
              options: textFieldEntry?.options,
              controller: textFieldEntry!.controller!,
              focusNode: textFieldEntry!.focusnode!,
              onDone: (str) {
                onValueSelected!(textFieldEntry?.keyId, str);
                focusHandler!(textFieldEntry!.isLast);
                // textFieldEntry!.isLast
                //     ? FocusScope.of(context).unfocus()
                //     : focusOnNextVisible(index);
              },
              validate: textFieldEntry?.validate,
              label: textFieldEntry?.label ?? '',
              showLabel: true,
            );
          }
          if (textFieldEntry?.fieldType == FieldType.text) {
            return TextFieldCustm(
              controller: textFieldEntry!.controller!,
              enabled: textFieldEntry!.enabled,
              focusNode: textFieldEntry!.focusnode!,
              onDone: (str) {
                onValueSelected!(textFieldEntry?.keyId, str);
                focusHandler!(textFieldEntry!.isLast);
                // textFieldEntry.isLast
                //     ? FocusScope.of(context).unfocus()
                //     : focusOnNextVisible(index);
              },
              validate: textFieldEntry?.validate,
              label: textFieldEntry!.label,
              showLabel: true,
            );
          }
          if (textFieldEntry?.fieldType == FieldType.date) {
            return DateFieldCustm(
              controller: textFieldEntry!.controller!,
              enabled: textFieldEntry!.enabled,
              focusNode: textFieldEntry!.focusnode!,
              isTime: textFieldEntry!.isTime,
              onDone: (str) {
                onValueSelected!(textFieldEntry?.keyId, str?.toString());
                focusHandler!(textFieldEntry!.isLast);
                // textFieldEntry!.isLast
                //     ? FocusScope.of(context).unfocus()
                //     : focusOnNextVisible(index);
              },
              validate: textFieldEntry?.validate,
              label: textFieldEntry!.label,
              showLabel: true,
            );
          }
          return const SizedBox(
            height: 0,
            width: 0,
          );
        }));
  }
}
