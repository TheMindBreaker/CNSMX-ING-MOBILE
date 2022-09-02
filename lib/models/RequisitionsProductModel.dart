class RequisitionsProductModel {
  RequisitionsProductModel({
    required this.error,
    required this.data,
    required this.stack,
  });
  late final bool error;
  late final List<Data> data;
  late final String stack;

  RequisitionsProductModel.fromJson(Map<String, dynamic> json){
    error = json['error'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    if(json['stack'] == null) {
      stack = '';
    } else {
      stack = json['stack'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['stack'] = stack.toString();
    return _data;
  }
}

class Data {
  Data({
    required this.id2,
    required this.reqID,
    required this.reqProductID,
    required this.reqQuantity,
    required this.reqProductNote,
    required this.reqMissing,
    required this.reqStatus,
    required this.proID,
    required this.proCategory,
    required this.proDescription,
    required this.proUnit,
    required this.proActualPrice,
    required this.proAveragePrice,
    required this.invQuantity,
    required this.reqRealMissing,
    required this.reqIDString,
    required this.reqCreatedBy,
  });
  late final int  id2;
  late final int reqID;
  late final int reqProductID;
  late final int reqQuantity;
  late final String reqProductNote;
  late final int reqMissing;
  late final int reqStatus;
  late final String proID;
  late final int proCategory;
  late final String proDescription;
  late final String proUnit;
  late final double proActualPrice;
  late final double proAveragePrice;
  late final int invQuantity;
  late final int reqRealMissing;
  late final String reqIDString;
  late final int reqCreatedBy;

  Data.fromJson(Map<String, dynamic> json){
    id2 = json['id2'];
    reqID = json['reqID'];
    reqProductID = json['reqProductID'];
    reqQuantity = json['reqQuantity'];
    reqProductNote = json['reqProductNote'];
    reqMissing = json['reqMissing'];
    reqStatus = json['reqStatus'];
    proID = json['proID'];
    proCategory = json['proCategory'];
    proDescription = json['proDescription'];
    proUnit = json['proUnit'];
    proActualPrice = json['proActualPrice'].toDouble();
    proAveragePrice = json['proAveragePrice'].toDouble();
    invQuantity = 0;
    reqRealMissing = json['reqRealMissing'];
    reqIDString = json['reqIDString'];
    reqCreatedBy = json['reqCreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id2'] = id2;
    _data['reqID'] = reqID;
    _data['reqProductID'] = reqProductID;
    _data['reqQuantity'] = reqQuantity;
    _data['reqProductNote'] = reqProductNote;
    _data['reqMissing'] = reqMissing;
    _data['reqStatus'] = reqStatus;
    _data['proID'] = proID;
    _data['proCategory'] = proCategory;
    _data['proDescription'] = proDescription;
    _data['proUnit'] = proUnit;
    _data['proActualPrice'] = proActualPrice;
    _data['proAveragePrice'] = proAveragePrice;
    _data['invQuantity'] = invQuantity;
    _data['reqRealMissing'] = reqRealMissing;
    _data['reqIDString'] = reqIDString;
    _data['reqCreatedBy'] = reqCreatedBy;
    return _data;
  }
}