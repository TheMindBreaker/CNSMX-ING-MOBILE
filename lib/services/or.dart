import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:al/models/orderInfoModel.dart';
import 'package:al/models/orderProductsModel.dart';
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
}
