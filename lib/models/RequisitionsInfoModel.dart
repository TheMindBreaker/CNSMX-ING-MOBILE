class RequisitionsInfoModel {
  RequisitionsInfoModel({
    required this.error,
    required this.data,
    required this.stack,
  });
  late final bool error;
  late final List<Data> data;
  late final String stack;

  RequisitionsInfoModel.fromJson(Map<String, dynamic> json){
    error = json['error'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    stack = json['stack'].toString();
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
    required this.reqID,
    required this.reqCreatedBy,
    required this.userNameCreated,
    required this.reqCreatedDate,
    required this.reqStatus,
    required this.reqPlace,
    required this.plaName,
    required this.reqFront,
    required this.frontName,
    required this.reqNeededDate,
    required this.reqAgent,
    required this.userNameAgent,
    required this.reqAuthBy,
    required this.creatorEmail,
  });
  late final int id;
  late final String reqID;
  late final int reqCreatedBy;
  late final String userNameCreated;
  late final String reqCreatedDate;
  late final int reqStatus;
  late final int reqPlace;
  late final String plaName;
  late final int reqFront;
  late final String frontName;
  late final String reqNeededDate;
  late final int reqAgent;
  late final String userNameAgent;
  late final int reqAuthBy;
  late final String creatorEmail;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    reqID = json['reqID'];
    reqCreatedBy = json['reqCreatedBy'];
    userNameCreated = json['userName_Created'];
    reqCreatedDate = json['reqCreatedDate'];
    reqStatus = json['reqStatus'];
    reqPlace = json['reqPlace'];
    plaName = json['plaName'];
    reqFront = json['reqFront'];
    frontName = json['frontName'];
    reqNeededDate = json['reqNeededDate'];
    reqAgent = json['reqAgent'];
    userNameAgent = json['userName_Agent'];
    reqAuthBy = 0;
    creatorEmail = json['creatorEmail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['reqID'] = reqID;
    _data['reqCreatedBy'] = reqCreatedBy;
    _data['userName_Created'] = userNameCreated;
    _data['reqCreatedDate'] = reqCreatedDate;
    _data['reqStatus'] = reqStatus;
    _data['reqPlace'] = reqPlace;
    _data['plaName'] = plaName;
    _data['reqFront'] = reqFront;
    _data['frontName'] = frontName;
    _data['reqNeededDate'] = reqNeededDate;
    _data['reqAgent'] = reqAgent;
    _data['userName_Agent'] = userNameAgent;
    _data['reqAuthBy'] = reqAuthBy;
    _data['creatorEmail'] = creatorEmail;
    return _data;
  }
}