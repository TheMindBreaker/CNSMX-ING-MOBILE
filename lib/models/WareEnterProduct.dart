class WareEnterProduct {
  late bool error;
  Data? data;
  String? stack;

  WareEnterProduct({required this.error,this.data, this.stack});

  WareEnterProduct.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = Data.fromJson(json['data']);
    stack = json['stack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['stack'] = stack;
    return data;
  }
}

class Data {
  int? fieldCount;
  int? affectedRows;
  int? insertId;
  int? serverStatus;
  int? warningCount;
  String? message;
  bool? protocol41;
  int? changedRows;

  Data(
      {this.fieldCount,
        this.affectedRows,
        this.insertId,
        this.serverStatus,
        this.warningCount,
        this.message,
        this.protocol41,
        this.changedRows});

  Data.fromJson(Map<String, dynamic> json) {
    fieldCount = json['fieldCount'];
    affectedRows = json['affectedRows'];
    insertId = json['insertId'];
    serverStatus = json['serverStatus'];
    warningCount = json['warningCount'];
    message = json['message'];
    protocol41 = json['protocol41'];
    changedRows = json['changedRows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fieldCount'] = fieldCount;
    data['affectedRows'] = affectedRows;
    data['insertId'] = insertId;
    data['serverStatus'] = serverStatus;
    data['warningCount'] = warningCount;
    data['message'] = message;
    data['protocol41'] = protocol41;
    data['changedRows'] = changedRows;
    return data;
  }
}
