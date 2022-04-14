class OrderProductsModel {
  bool? error;
  String? stack;
  List<Data>? data;

  OrderProductsModel({this.error, this.stack, this.data});

  OrderProductsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    stack = json['stack'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['stack'] = stack;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? purID;
  int? reqId;
  int? purProductID;
  double  purQuantity = 0.0;
  double? purUnitPrice;
  String? purNote;
  double purDelived = 0.0;
  int? reqProductID;
  int? proCategory;
  String? proDescription;
  String? proUnit;
  double? proActualPrice;
  double? proAveragePrice;
  int? proActive;
  int? proProtocol;
  String? reqProductNote;
  String? proID;
  int? realProId;

  Data(
      {this.id,
        this.purID,
        this.reqId,
        this.purProductID,
        required this.purQuantity,
        this.purUnitPrice,
        this.purNote,
        required this.purDelived,
        this.reqProductID,
        this.proCategory,
        this.proDescription,
        this.proUnit,
        this.proActualPrice,
        this.proAveragePrice,
        this.proActive,
        this.proProtocol,
        this.reqProductNote,
        this.realProId,
        this.proID});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purID = json['purID'];
    reqId = json['reqId'];
    purProductID = json['purProductID'];
    purQuantity = json['purQuantity'].toDouble();
    purUnitPrice = json['purUnitPrice'].toDouble();
    purNote = json['purNote'];
    purDelived = json['purDelived'].toDouble();
    reqProductID = json['reqProductID'];
    proCategory = json['proCategory'];
    proDescription = json['proDescription'];
    proUnit = json['proUnit'];
    proActualPrice = json['proActualPrice'].toDouble();
    proAveragePrice = json['proAveragePrice'].toDouble();
    proActive = json['proActive'];
    proProtocol = json['proProtocol'];
    reqProductNote = json['reqProductNote'];
    proID = json['proID'];
    realProId = json['realProId'];
  }
  setNewQty (double newQty) {
    purDelived = newQty;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purID'] = this.purID;
    data['reqId'] = this.reqId;
    data['purProductID'] = this.purProductID;
    data['purQuantity'] = this.purQuantity;
    data['purUnitPrice'] = this.purUnitPrice;
    data['purNote'] = this.purNote;
    data['purDelived'] = this.purDelived;
    data['reqProductID'] = this.reqProductID;
    data['proCategory'] = this.proCategory;
    data['proDescription'] = this.proDescription;
    data['proUnit'] = this.proUnit;
    data['proActualPrice'] = this.proActualPrice;
    data['proAveragePrice'] = this.proAveragePrice;
    data['proActive'] = this.proActive;
    data['proProtocol'] = this.proProtocol;
    data['reqProductNote'] = this.reqProductNote;
    data['proID'] = this.proID;
    data['realProId'] = this.realProId;
    return data;
  }
}
