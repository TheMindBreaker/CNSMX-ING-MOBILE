class WareHousesModel {
  bool? error;
  List<Data>? data;
  String? stack;

  WareHousesModel({this.error, this.data, this.stack});

  WareHousesModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    stack = json['stack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['stack'] = stack;
    return data;
  }
}

class Data {
  int? id;
  String? wareName;
  String? wareShorName;
  String? wareDirection;
  int? active;

  Data(
      {this.id,
        this.wareName,
        this.wareShorName,
        this.wareDirection,
        this.active});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wareName = json['wareName'];
    wareShorName = json['wareShorName'];
    wareDirection = json['wareDirection'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wareName'] = wareName;
    data['wareShorName'] = wareShorName;
    data['wareDirection'] = wareDirection;
    data['active'] = active;
    return data;
  }
}
