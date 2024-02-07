//import 'package:uuid/uuid.dart';

class AssetInstance {
  AssetInstance({this.description = ''})   //Task({this.description = '', String? id})
      : assetTypeId = 0,
        assetProfileId = 0,
        serialNum = 0,
        status = '',
        externalAccessories = '',
        internalFeatures = '';
        //id = id ?? _uuid.v1(),
      
  int assetTypeId;
  int assetProfileId;
  int serialNum;
  String status;
  String externalAccessories;
  String internalFeatures;
  //static const _uuid = Uuid();
  final String description;
  //final String id;
}