class UserWarehouseModel {
  UserWarehouseModel({
    required this.error,
    required this.stack,
    required this.data,
  });
  late final bool error;
  late final String stack;
  late final Data data;

  UserWarehouseModel.fromJson(Map<String, dynamic> json){
    error = json['error'];
    stack = json['stack'].toString();
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['stack'] = stack;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.wareId,
    required this.wareUser,
  });
  late final int id;
  late final int wareId;
  late final int wareUser;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    wareId = json['wareId'];
    wareUser = json['wareUser'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['wareId'] = wareId;
    _data['wareUser'] = wareUser;
    return _data;
  }
}