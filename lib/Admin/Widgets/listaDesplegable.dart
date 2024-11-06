import 'package:flutter/material.dart';

Widget buildDropdown({
  required String labelText,
  required String? value,
  required Map<String, List<String>> items,
  required void Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    ),
    value: value,
    items: items.keys.map((String key) {
      return DropdownMenuItem<String>(
        value: key,
        child: Text(key),
      );
    }).toList(),
    onChanged: onChanged,
  );
}
