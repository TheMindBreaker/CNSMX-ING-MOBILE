class WareHouseProductModel {
  WareHouseProductModel({
    required this.waId,
    required this.invWareID,
    required this.invProductID,
  });
  late final int waId;
  late final int invWareID;
  late final int invProductID;

  WareHouseProductModel.fromJson(Map<String, dynamic> json){
    waId = json['waId'];
    invWareID = json['invWareID'];
    invProductID = json['invProductID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['waId'] = waId;
    _data['invWareID'] = invWareID;
    _data['invProductID'] = invProductID;

    return _data;
  }
}