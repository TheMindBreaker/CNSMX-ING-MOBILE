import 'dart:io';
import 'package:ing/models/ExitsDetails.dart';
import 'package:ing/models/WareHousesModel.dart';
import 'package:ing/models/WareEnterProduct.dart';
import 'package:ing/models/ExitsInfo.dart';
import 'package:ing/models/WareInventoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:ots/ots.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';

class WarehouseService {
  Future<WareHousesModel> getWarehouse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };
    final response = await http.get(Uri.https('connect.construtec.mx', 'Purchases/WareHouse/getWarehouse'), headers: headers);
    return WareHousesModel.fromJson(json.decode(response.body));
  }
  Future<WareEnterProduct> wareEnterProduct(int productId,int orderId,int reqId,String orderCode,String requisitionCode,int wareId,double enter, int purProductId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };
    final response = await http.post(Uri.https('connect.construtec.mx', 'Purchases/WareHouse/enterOrderProduct'),
        body: {'productId':productId.toString(),
          'orderId':orderId.toString(),
          'reqId':reqId.toString(),
          'orderCode':orderCode,
          'requisitionCode':requisitionCode,
          'wareId':wareId.toString(),
          'enter':enter.toString(),
          'purProductId': purProductId.toString(),
        },
        headers: headers);
    return WareEnterProduct.fromJson(json.decode(response.body));
  }
  Future<ExistsInfo> wareExistInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var wareId = prefs.getInt('cnsmxWarehouse');
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };
    final response = await http.get(Uri.https('connect.construtec.mx', 'Purchases/WareHouse/getExistsInfo/'+ wareId.toString()),
        headers: headers);
    return ExistsInfo.fromJson(json.decode(response.body));
  }
  Future<WareInventory> wareInventory(int wareId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };
    final response = await http.get(Uri.https('connect.construtec.mx', 'Purchases/WareHouse/getInventoryOfWarehouse/'+ wareId.toString()),
        headers: headers);
    return WareInventory.fromJson(json.decode(response.body));
  }
  Future<ExistsDetails> wareExistDetails(int exitId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };
    final response = await http.get(Uri.https('connect.construtec.mx', 'Purchases/WareHouse/getExistsDetails/'+ exitId.toString()),
        headers: headers);
    return ExistsDetails.fromJson(json.decode(response.body));
  }

  Future<WareEnterProduct> releaseExit(int exitId, String photo, String signature) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };
    final response = await http.post(Uri.https('connect.construtec.mx', 'Purchases/WareHouse/releaseExit', ),
        headers: headers,
        body: {'exitId':exitId.toString(),
          'photoBlob':photo.toString(),
          'signBlob':signature.toString(),
        });
    return WareEnterProduct.fromJson(json.decode(response.body));
  }
}
