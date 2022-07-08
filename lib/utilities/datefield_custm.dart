import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFieldCustm extends StatelessWidget {
  const DateFieldCustm(
      {Key? key,
      required this.controller,
      this.obscure = false,
      this.label = '',
      this.showLabel = false,
      required this.focusNode,
      this.validate,
      this.enabled = true,
      this.isTime = false,
      this.onDone})
      : super(key: key);
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final bool enabled;
  final bool isTime;
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
          readOnly: true,
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validate ?? (str) => null,
          onTap: () {
            if (isTime) {
              _selectTime(context);
            } else {
              _selectDate(context);
            }
          },
          onFieldSubmitted: onDone ?? (str) => controller.text = str.toString(),
          decoration: InputDecoration(
              hintText: showLabel ? '' : label,
              fillColor: Colors.white.withOpacity(0.6),
              filled: true,
              errorStyle: const TextStyle(color: Colors.redAccent),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              border: const OutlineInputBorder()),
        ),
      ],
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: controller.text.isEmpty
            ? DateTime.now()
            : DateFormat.yMMMd().parse(controller.text),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      controller
        ..text = DateFormat.yMMMd().format(newSelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: controller.text.length, affinity: TextAffinity.upstream));
    }
  }

  _selectTime(BuildContext context) async {
    TimeOfDay? newSelectedDate = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(controller.text.isEmpty
            ? DateTime.now()
            : DateFormat("h:mm a").parse(controller.text)),
        // firstDate: DateTime(2000),
        // lastDate: DateTime(2040),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      final now = DateTime.now();

      controller
        ..text = DateFormat("h:mm a").format(DateTime(now.year, now.month,
            now.day, newSelectedDate.hour, newSelectedDate.minute))
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: controller.text.length, affinity: TextAffinity.upstream));
    }
  }
}
