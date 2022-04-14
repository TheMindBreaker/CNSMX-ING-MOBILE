class WareInventory {
  WareInventory({
    required this.error,
    required this.data,
    required this.stack,
  });
  late final bool error;
  late final List<Data> data;
  late final String stack;

  WareInventory.fromJson(Map<String, dynamic> json){
    error = json['error'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    stack = json['stack'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['stack'] = stack;
    return _data;
  }
}

class Data {
  Data({
    required this.waId,
    required this.invWareID,
    required this.invProductID,
    required this.invQuantity,
    required this.wareName,
    required this.wareShorName,
    required this.wareDirection,
    required this.proID,
    required this.proCategory,
    required this.proDescription,
    required this.proUnit,
    required this.proActualPrice,
    required this.proAveragePrice,
  });
  late final int waId;
  late final int invWareID;
  late final int invProductID;
  late final double invQuantity;
  late final String wareName;
  late final String wareShorName;
  late final String wareDirection;
  late final String proID;
  late final int proCategory;
  late final String proDescription;
  late final String proUnit;
  late final double proActualPrice;
  late final double proAveragePrice;

  Data.fromJson(Map<String, dynamic> json){
    waId = json['waId'];
    invWareID = json['invWareID'];
    invProductID = json['invProductID'];
    invQuantity = json['invQuantity'].toDouble();
    wareName = json['wareName'];
    wareShorName = json['wareShorName'];
    wareDirection = json['wareDirection'];
    proID = json['proID'];
    proCategory = json['proCategory'];
    proDescription = json['proDescription'];
    proUnit = json['proUnit'];
    proActualPrice = json['proActualPrice'].toDouble();
    proAveragePrice = json['proAveragePrice'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['waId'] = waId;
    _data['invWareID'] = invWareID;
    _data['invProductID'] = invProductID;
    _data['invQuantity'] = invQuantity;
    _data['wareName'] = wareName;
    _data['wareShorName'] = wareShorName;
    _data['wareDirection'] = wareDirection;
    _data['proID'] = proID;
    _data['proCategory'] = proCategory;
    _data['proDescription'] = proDescription;
    _data['proUnit'] = proUnit;
    _data['proActualPrice'] = proActualPrice;
    _data['proAveragePrice'] = proAveragePrice;
    return _data;
  }
}