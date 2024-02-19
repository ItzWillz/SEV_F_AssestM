import 'package:flutter/material.dart';

import 'asset_cell.dart';

class DropdownCell extends AssetCell {
  String? value;
  final List<String> items;
  final void Function(String?) updateValue;

  DropdownCell({
    this.value,
    required this.items,
    required this.updateValue,
  });

  @override
  DataCell toDataCell() {
    return DataCell(
      DropdownButton<String>(
        value: value,
        items: items.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          this.value = value;
          updateValue(value);
          notifyListeners();
        },
      ),
    );
  }
}
