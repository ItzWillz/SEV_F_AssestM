import 'package:flutter/material.dart';
import '../models/asset_model.dart';
import '../models/tableable.dart';

class MyDataSource extends DataTableSource {
  MyDataSource({
    required this.data,
    required this.onViewMore,
    required this.onEdit,
  });

  final List<Asset> data;
  final Function(Asset) onViewMore;
  final Function(Asset) onEdit;

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    final Asset asset = data[index];
    return DataRow(cells: [
      DataCell(Text(asset.description)),
      DataCell(Text(asset.assetType.toString())),
      DataCell(Text(asset.serialNum.toString())),
      DataCell(Text(asset.status)),
      DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => onViewMore(asset),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => onEdit(asset),
          )
        ],
      )),
    ]);
  }
}

class AssetListDataTable extends StatelessWidget {
  const AssetListDataTable({
    Key? key,
    required this.data,
    required this.onViewMore,
    required this.onEdit,
  }) : super(key: key);

  final List<Asset> data;
  final Function(Asset) onViewMore;
  final Function(Asset) onEdit;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const Text('Table is empty');

    return PaginatedDataTable(
      columns: data.first
          .header()
          .map((label) => DataColumn(label: Text(label)))
          .toList(),
      source: MyDataSource(data: data, onViewMore: onViewMore, onEdit: onEdit),
    );
  }
}
