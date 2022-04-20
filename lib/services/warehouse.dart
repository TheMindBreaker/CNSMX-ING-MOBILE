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

import '../models/WareHouseProductModel.dart';

class WarehouseService {
  Future<WareHousesModel> getWarehouse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };
    final response = await http.get(Uri.https('connect.construtec.mx', 'Purchases/WareHouse/getWarehouse'), headers: headers);
    return WareHousesModel.fromJson(json.decode(response.body));
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

  Future<WareEnterProduct> createExit(int wareId, int frontId, int placeId, List<WareHouseProductModel> cart, String receptorName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };
    final response = await http.post(Uri.http('192.168.8.52:4000', 'Purchases/WareHouse/createExit', ),
        headers: headers,
        body: {'wareId':wareId.toString(),
          'frontId':frontId.toString(),
          'placeId':placeId.toString(),
          'receptorName':receptorName,
          'cart': jsonEncode(cart),
        });
    return WareEnterProduct.fromJson(json.decode(response.body));
  }
}
