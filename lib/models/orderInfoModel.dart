class OrderInfoModel {
  bool? error;
  String? stack;
  Data? data;

  OrderInfoModel({this.error, this.data});

  OrderInfoModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    stack = json['stack'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['stack'] = stack;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? purID;
  String? purIDProvider;
  int? reqID;
  String? purDate;
  int? purStatus;
  int? purCreatedBy;
  int? purAuthBy;
  String? purEDT;
  int? purProvider;
  String? purNote;
  String? purAuthDate;
  double? purTotal;
  double? purPaymentMissing;
  int? purFrontId;
  int? purAddNotes;
  String? frontName;
  String? plaName;
  int? placeId;
  int? frontId;
  String? userName;
  String? provName;
  String? provRFC;
  String? provPurchasedEmail;
  String? provPaymentEmail;
  String? provComertial;
  double? cfdiMissing;
  String? reqCode;

  Data(
      {this.id,
        this.purID,
        this.purIDProvider,
        this.reqID,
        this.purDate,
        this.purStatus,
        this.purCreatedBy,
        this.purAuthBy,
        this.purEDT,
        this.purProvider,
        this.purNote,
        this.purAuthDate,
        this.purTotal,
        this.purPaymentMissing,
        this.purFrontId,
        this.purAddNotes,
        this.frontName,
        this.plaName,
        this.placeId,
        this.frontId,
        this.userName,
        this.provName,
        this.provRFC,
        this.provPurchasedEmail,
        this.provPaymentEmail,
        this.provComertial,
        this.cfdiMissing,
        this.reqCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purID = json['purID'];
    purIDProvider = json['purID_Provider'];
    reqID = json['reqID'];
    purDate = json['purDate'];
    purStatus = json['purStatus'];
    purCreatedBy = json['purCreatedBy'];
    purAuthBy = json['purAuthBy'];
    purEDT = json['purEDT'];
    purProvider = json['purProvider'];
    purNote = json['purNote'];
    purAuthDate = json['purAuthDate'];
    purTotal = json['purTotal'].toDouble();
    purPaymentMissing = json['purPaymentMissing'].toDouble();
    purFrontId = json['purFrontId'];
    purAddNotes = json['purAddNotes'];
    frontName = json['frontName'];
    plaName = json['plaName'];
    placeId = json['placeId'];
    frontId = json['frontId'];
    userName = json['userName'];
    provName = json['provName'];
    provRFC = json['provRFC'];
    provPurchasedEmail = json['provPurchasedEmail'];
    provPaymentEmail = json['provPaymentEmail'];
    provComertial = json['provComertial'];
    cfdiMissing = json['cfdiMissing'].toDouble();
    reqCode = json['reqCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purID'] = this.purID;
    data['purID_Provider'] = this.purIDProvider;
    data['reqID'] = this.reqID;
    data['purDate'] = this.purDate;
    data['purStatus'] = this.purStatus;
    data['purCreatedBy'] = this.purCreatedBy;
    data['purAuthBy'] = this.purAuthBy;
    data['purEDT'] = this.purEDT;
    data['purProvider'] = this.purProvider;
    data['purNote'] = this.purNote;
    data['purAuthDate'] = this.purAuthDate;
    data['purTotal'] = this.purTotal;
    data['purPaymentMissing'] = this.purPaymentMissing;
    data['purFrontId'] = this.purFrontId;
    data['purAddNotes'] = this.purAddNotes;
    data['frontName'] = this.frontName;
    data['plaName'] = this.plaName;
    data['placeId'] = this.placeId;
    data['frontId'] = this.frontId;
    data['userName'] = this.userName;
    data['provName'] = this.provName;
    data['provRFC'] = this.provRFC;
    data['provPurchasedEmail'] = this.provPurchasedEmail;
    data['provPaymentEmail'] = this.provPaymentEmail;
    data['provComertial'] = this.provComertial;
    data['cfdiMissing'] = this.cfdiMissing;
    data['reqCode'] = this.reqCode;
    return data;
  }
}