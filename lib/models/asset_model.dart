import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocassetmanagement/models/tableable.dart';
import 'package:uuid/uuid.dart';

class Asset implements Tableable {
  Asset(
      {String? id,
      required String description,
      required int assetType,
      required int serialNum,
      required String status,
      required Function() onViewMore,
      required Function() onEdit})
      : assetType = 0,
        assetProfileId = 0,
        serialNum = 0,
        status = '',
        description = '',
        externalAccessories = '',
        internalFeatures = '',
        wirelessNIC = '',
        id = id ?? _uuid.v1();

  Asset.fromFirestore(DocumentSnapshot snapshot)
      : assetProfileId = snapshot['assetProfileId'] ?? 0,
        assetType = snapshot['assetCategoryId'] ?? '',
        serialNum = snapshot['serialNum'] ?? 0,
        status = snapshot['status'] ?? '',
        description = snapshot['description'] ?? '',
        externalAccessories = snapshot['externalAccessories'] ?? '',
        internalFeatures = snapshot['internalFeatures'] ?? '',
        wirelessNIC = snapshot['wirelessNIC'] ?? '',
        id = snapshot.id;

  late int assetType;
  late int assetProfileId;
  late int serialNum;
  late String status;
  late String externalAccessories;
  late String internalFeatures;
  late String wirelessNIC;
  static const _uuid = Uuid();
  late String description;
  late final String id;

  get onViewMore => null;

  get onEdit => null;

  @override
  List<String> header() {
    return ['Description', 'Type', 'Serial Number', 'Status', 'Action'];
  }

  @override
  List<Object?> asRow() {
    return [
      description,
      assetType,
      serialNum,
      status,
      ActionCell(onViewMore: onViewMore ?? () {}, onEdit: onEdit ?? () {}),
    ];
  }
}

class ActionCell {
  final VoidCallback onViewMore;
  final VoidCallback onEdit;

  ActionCell({required this.onViewMore, required this.onEdit});

  DataCell toDataCell() {
    return DataCell(Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: onViewMore,
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onEdit,
        ),
      ],
    ));
  }
}
