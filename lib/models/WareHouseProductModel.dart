class WareHouseProductModel {
  WareHouseProductModel({
    required this.waId,
    required this.invWareID,
    required this.invProductID,
    required this.proDescription,
    required this.proUnit,
    required this.quantity,
    required this.actualInventory,
  });
  late final int waId;
  late final int invWareID;
  late final int invProductID;
  late final String proDescription;
  late final String proUnit;
  double? quantity;
  late final double actualInventory;


  WareHouseProductModel.fromJson(Map<String, dynamic> json){
    waId = json['waId'];
    invWareID = json['invWareID'];
    invProductID = json['invProductID'];
    proDescription = json['proDescription'];
    proUnit = json['proUnit'];
    quantity = json['quantity'];
    actualInventory = json['actualInventory'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['waId'] = waId;
    _data['invWareID'] = invWareID;
    _data['invProductID'] = invProductID;
    _data['proDescription'] = proDescription;
    _data['proUnit'] = proUnit;
    _data['quantity'] = quantity;
    _data['actualInventory'] = actualInventory;

    return _data;
  }
}