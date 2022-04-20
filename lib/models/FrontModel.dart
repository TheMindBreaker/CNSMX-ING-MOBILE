import 'dart:developer' as dev;

class FrontModel {
  FrontModel({
    required this.error,
    required this.data,
  });
  late final bool error;
  late final List<Data> data;
  late String stack;

  FrontModel.fromJson(Map<String, dynamic> json){
    error = json['error'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    json["stack"] != null ? stack = json["stack"] : stack = '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.frontName,
    required this.idPlace,
    required this.plaName,
    required this.reqStatus,
  });
  late final int id;
  late final String frontName;
  late final int idPlace;
  late final String plaName;
  late final int reqStatus;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    frontName = json['frontName'];
    idPlace = json['idPlace'];
    plaName = json['plaName'];
    reqStatus = json['reqStatus'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['frontName'] = frontName;
    _data['idPlace'] = idPlace;
    _data['plaName'] = plaName;
    _data['reqStatus'] = reqStatus;
    return _data;
  }
}