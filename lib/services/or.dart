import 'package:http/http.dart' as http;
import 'package:ing/models/RequisitionsInfoModel.dart';
import 'package:ing/models/RequisitionsProductModel.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:ing/models/orderInfoModel.dart';
import 'package:ing/models/orderProductsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OrderService {
  Future<OrderInfoModel> getOr(String orId) async {
    final response = await http.get(Uri.https('connect.construtec.mx', 'Purchases/Requisitions/getOrById/' + orId));
    return OrderInfoModel.fromJson(json.decode(response.body));
  }
  Future<OrderProductsModel> getOrProducts(String orId) async {
    final response = await http.get(Uri.https('connect.construtec.mx', 'Purchases/Requisitions/getOrProducts/' + orId));
    return OrderProductsModel.fromJson(json.decode(response.body));
  }
  Future<OrderProductsModel> enterProduct(double qty, int productId, intOrderID, String idProvider) async {
    final response = await http.get(Uri.https('connect.construtec.mx', 'Purchases/Requisitions/getOrProducts/'));
    return OrderProductsModel.fromJson(json.decode(response.body));
  }

  Future<RequisitionsInfoModel> getRequisitionsByCreator() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };

    final response = await http.get(Uri.http('192.168.8.91:4000', 'Purchases/Requisitions/getByCreatorMobile'), headers: headers);
    return RequisitionsInfoModel.fromJson(json.decode(response.body));;
  }

  Future<RequisitionsProductModel> getRequisitionProducts(int reqId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Authorization': 'Bearer ' + prefs.getString('cnsmxJwtIng')!
    };

    final response = await http.get(Uri.http('192.168.8.91:4000', 'Purchases/Requisitions/getProducts/' + reqId.toString()), headers: headers);
    return RequisitionsProductModel.fromJson(json.decode(response.body));;
  }
}
