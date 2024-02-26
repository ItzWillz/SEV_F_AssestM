import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/asset_model.dart';
import '../view_models/cells/asset_cell.dart';
import '../models/tableable.dart';

class MyDataSource extends DataTableSource {
  MyDataSource({required this.data});

  final List<Object> data;

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    final row = data[index];

    if (row is Tableable) {
      return DataRow(cells: row.asRow().map(_toDataCell).toList());
    } else {
      if (kDebugMode) print('$row doens\'t implement tableable.');
      return DataRow(
          cells: List.filled(data.length, const DataCell(Placeholder())));
    }
  }

  DataCell _toDataCell(Object? label) {
    if (label is AssetCell) {
      label.addListener(() => notifyListeners());
      return label.toDataCell();
    } else if (label is ActionCell) {
      return label.toDataCell();
    }

    return DataCell(Text(label?.toString() ?? ''));
  }
}

class AssetDataTable extends StatelessWidget {
  AssetDataTable({super.key, required this.data})
      : dataSource = MyDataSource(data: data);

  final List<Object> data;
  final DataTableSource dataSource;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Text('Table is empty');
    }
    final asset = data.first;

    if (asset is Tableable) {
      return PaginatedDataTable(
        columns: asset.header().map(columnHeader).toList(),
        source: dataSource,
      );
    }

    return Text(
        '${asset.runtimeType} does not implement Tableable. Please fix this.');
  }

  DataColumn columnHeader(String label) {
    return DataColumn(label: Text(label.toString()));
  }
}
