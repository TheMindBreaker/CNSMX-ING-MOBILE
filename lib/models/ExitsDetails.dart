class ExistsDetails {
  ExistsDetails({
    required this.error,
    required this.data,
    required this.stack,
  });
  late final bool error;
  late final List<Data> data;
  late final String stack;

  ExistsDetails.fromJson(Map<String, dynamic> json){
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
    required this.id,
    required this.exitId,
    required this.productId,
    required this.sysProdId,
    required this.quantity,
    required this.waId,
    required this.invQuantity,
    required this.proID,
    required this.proCategory,
    required this.proDescription,
    required this.proUnit,
    required this.proAveragePrice,
    required this.proActualPrice,
    required this.proActive,
  });
  late final int id;
  late final int exitId;
  late final int productId;
  late final int sysProdId;
  late final double quantity;
  late final int waId;
  late final double invQuantity;
  late final String proID;
  late final int proCategory;
  late final String proDescription;
  late final String proUnit;
  late final double proAveragePrice;
  late final double proActualPrice;
  late final int proActive;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    exitId = json['exitId'];
    productId = json['productId'];
    sysProdId = json['sysProdId'];
    quantity = json['quantity'].toDouble();
    waId = json['waId'];
    invQuantity = json['invQuantity'].toDouble();
    proID = json['proID'];
    proCategory = json['proCategory'];
    proDescription = json['proDescription'];
    proUnit = json['proUnit'];
    proAveragePrice = json['proAveragePrice'].toDouble();
    proActualPrice = json['proActualPrice'].toDouble();
    proActive = json['proActive'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['exitId'] = exitId;
    _data['productId'] = productId;
    _data['sysProdId'] = sysProdId;
    _data['quantity'] = quantity;
    _data['waId'] = waId;
    _data['invQuantity'] = invQuantity;
    _data['proID'] = proID;
    _data['proCategory'] = proCategory;
    _data['proDescription'] = proDescription;
    _data['proUnit'] = proUnit;
    _data['proAveragePrice'] = proAveragePrice;
    _data['proActualPrice'] = proActualPrice;
    _data['proActive'] = proActive;
    return _data;
  }
}