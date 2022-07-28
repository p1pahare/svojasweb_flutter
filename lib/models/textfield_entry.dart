import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:svojasweb/utilities/validations.dart';

class TextFieldEntry {
  TextFieldEntry(
      {required this.keyId,
      this.fieldType = FieldType.text,
      this.label = '',
      this.controller,
      this.enabled = true,
      this.visible = true,
      this.obscure = false,
      this.options,
      this.isTime = false,
      this.focusnode,
      this.isLast = false,
      this.object,
      this.validate,
      this.onDone}) {
    controller ??= TextEditingController();
    options ??= ['Select'];
    focusnode ??= FocusNode();
    validate ??= isNotBlank;
    onDone ??= (value) {
      log("onDone not set");
    };
  }
  late final String keyId;
  late FieldType fieldType;
  late String label;
  late bool enabled;
  late bool obscure;
  late bool visible;
  late List<String>? options;
  late TextEditingController? controller;
  late String? Function(String?)? validate;
  late FocusNode? focusnode;
  late bool isLast;
  late final bool isTime;
  late dynamic object;
  late void Function(String?)? onDone;
}

enum FieldType { text, dropdown, date, checkbox, autocomplete }
