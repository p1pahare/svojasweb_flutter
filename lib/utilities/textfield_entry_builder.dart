import 'dart:math';
import 'package:flutter/material.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/models/textfield_entry.dart';
import 'package:svojasweb/utilities/autocomplete_demo.dart';
import 'package:svojasweb/utilities/checkfield_custm.dart';
import 'package:svojasweb/utilities/datefield_custm.dart';
import 'package:svojasweb/utilities/dropdown_field_custom.dart';
import 'package:svojasweb/utilities/helper_functions.dart';
import 'package:svojasweb/utilities/textfield_custm.dart';
import 'package:svojasweb/views/subviews/view_party.dart';
import 'package:svojasweb/views/subviews/view_quote.dart';
import 'package:svojasweb/views/subviews/view_quotec.dart';

class TextFieldEntryBuilder extends StatelessWidget {
  const TextFieldEntryBuilder({
    Key? key,
    this.textFieldEntry,
    this.onValueSelected,
    this.focusHandler,
  }) : super(key: key);
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
          if (textFieldEntry?.fieldType == FieldType.autocomplete) {
            return Column(
              children: [
                AutoCompleteDemo(
                  label: textFieldEntry!.label,
                  validate: textFieldEntry?.validate,
                  onSelect: (object) {
                    if (textFieldEntry?.object is List) {
                      textFieldEntry?.object.add(object);
                    } else {
                      textFieldEntry?.object = object;
                    }
                    focusHandler!(textFieldEntry!.isLast);
                    onValueSelected!(
                        textFieldEntry?.keyId, getNameFromObject(object));
                  },
                  optionListing: textFieldEntry!.optionListing,
                ),
                if (textFieldEntry!.object != null)
                  if (textFieldEntry!.object is Party)
                    ViewParty(party: textFieldEntry!.object)
                  else if (textFieldEntry!.object is Quote)
                    ViewQuote(quote: textFieldEntry!.object)
                  else if (textFieldEntry!.object is QuoteC)
                    ViewQuotec(quoteC: textFieldEntry!.object)
              ],
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
          if (textFieldEntry?.fieldType == FieldType.checkbox) {
            return CheckboxFieldCustm(
              controller: textFieldEntry!.controller!,
              focusNode: textFieldEntry!.focusnode!,
              label: textFieldEntry!.label,
              onDone: (str) => onValueSelected!(textFieldEntry?.keyId, str),
              showLabel: true,
              defValue: textFieldEntry?.object,
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
