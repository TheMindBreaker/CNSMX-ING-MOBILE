class ExistsInfo {
  ExistsInfo({
    required this.error,
    required this.data,
    required this.stack,
  });
  late final bool error;
  late final List<Data> data;
  late final String stack;

  ExistsInfo.fromJson(Map<String, dynamic> json){
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
    required this.frontId,
    required this.placeId,
    required this.receiverName,
    required this.createdBy,
    required this.createdDate,
    this.exitedBy,
    this.exitDate,
    this.signaturePath,
    this.photoPath,
    required this.wareId,
    required this.status,
    required this.plaName,
    required this.frontName,
    required this.userName,
    required this.wareName,
    required this.wareShorName,
  });
  late final int id;
  late final int frontId;
  late final int placeId;
  late final String receiverName;
  late final int createdBy;
  late final String createdDate;
  late final Null exitedBy;
  late final Null exitDate;
  late final Null signaturePath;
  late final Null photoPath;
  late final int wareId;
  late final int status;
  late final String plaName;
  late final String frontName;
  late final String userName;
  late final String wareName;
  late final String wareShorName;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    frontId = json['frontId'];
    placeId = json['placeId'];
    receiverName = json['receiverName'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    exitedBy = null;
    exitDate = null;
    signaturePath = null;
    photoPath = null;
    wareId = json['wareId'];
    status = json['status'];
    plaName = json['plaName'];
    frontName = json['frontName'];
    userName = json['userName'];
    wareName = json['wareName'];
    wareShorName = json['wareShorName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['frontId'] = frontId;
    _data['placeId'] = placeId;
    _data['receiverName'] = receiverName;
    _data['createdBy'] = createdBy;
    _data['createdDate'] = createdDate;
    _data['exitedBy'] = exitedBy;
    _data['exitDate'] = exitDate;
    _data['signaturePath'] = signaturePath;
    _data['photoPath'] = photoPath;
    _data['wareId'] = wareId;
    _data['status'] = status;
    _data['plaName'] = plaName;
    _data['frontName'] = frontName;
    _data['userName'] = userName;
    _data['wareName'] = wareName;
    _data['wareShorName'] = wareShorName;
    return _data;
  }
}