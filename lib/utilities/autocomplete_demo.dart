import 'package:flutter/material.dart';
import 'package:svojasweb/models/party.dart';

class AutoCompleteDemo<T extends Object> extends StatelessWidget {
  final Future<Iterable<T>> Function(String)? optionListing;
  final void Function(T)? onSelect;
  final String? label;
  const AutoCompleteDemo(
      {Key? key,
      required this.optionListing,
      this.label,
      this.onSelect,
      this.showLabel = true})
      : super(key: key);
  final bool showLabel;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) Text(label ?? ''),
        Autocomplete<T>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return optionListing!(textEditingValue.text);
          },
          displayStringForOption: (T option) =>
              option is Party ? "${option.partyName}" : "",
          fieldViewBuilder: (BuildContext context,
              TextEditingController fieldTextEditingController,
              FocusNode ffocusNode,
              VoidCallback onFieldSubmitted) {
            return TextField(
              controller: fieldTextEditingController,
              focusNode: ffocusNode,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: label,
                  fillColor: Colors.white.withOpacity(0.6),
                  filled: true,
                  errorStyle: const TextStyle(color: Colors.redAccent),
                  disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  border: const OutlineInputBorder()),
            );
          },
          onSelected: onSelect,
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<T> onSelected, Iterable<T> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                child: Container(
                  width: 300,
                  color: Colors.cyan,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final T option = options.elementAt(index);

                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(
                              option is Party
                                  ? option.partyName ?? ""
                                  : "option.name",
                              style: const TextStyle(color: Colors.white)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}