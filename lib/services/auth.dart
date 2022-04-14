import 'dart:convert';
import 'dart:developer' as developer;
import 'package:al/models/UserWarehouseModel.dart';
import 'package:al/src/login.dart';
import 'package:al/src/welcome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:al/src/mainMenu.dart';
class AuthService {

  Future<ApiResponse> authenticateUser(String userEmail, String mobileACCO) async {


    ApiResponse _apiResponse = ApiResponse();
      var response = await http.post(Uri.https('connect.construtec.mx', '/mobile/Account/login'), body: {
        'userEmail': userEmail,
        'mobileACCO': mobileACCO,
      });
      if(response.statusCode == 200) {
        if(json.decode(response.body)['error']) {
          _apiResponse.isError = true;
          _apiResponse.apiError = json.decode(response.body)['stack'];

        }
        else {
          _apiResponse.isError = false;
          _apiResponse.apiToken = jsonDecode(response.body)['token'];
        }
      } else {
        _apiResponse.isError = true;
        _apiResponse.apiError = "Error al conectar a Connect";
      }
    return _apiResponse;
  }
  Future<ApiResponse> getPlacesAuth(int userID) async {


    ApiResponse _apiResponse = ApiResponse();
    var response = await http.post(Uri.https('connect.construtec.mx', '/mobile/Account/login'));
    if(response.statusCode == 200) {
      if(json.decode(response.body)['error']) {
        _apiResponse.isError = true;
        _apiResponse.apiError = json.decode(response.body)['stack'];

      }
      else {
        _apiResponse.isError = false;
        _apiResponse.apiToken = jsonDecode(response.body)['token'];
      }
    } else {
      _apiResponse.isError = true;
      _apiResponse.apiError = "Error al conectar a Connect";
    }
    return _apiResponse;
  }
  void setUserIdent(jwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final parts = jwt.split('.');
    var decodedToken = decodeBase64(parts[1]);
    prefs.setString('cnsmxJwt', jwt);
    prefs.setString('cnsmxUser', json.decode(decodedToken).toString());
  }
  Future<String> getJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cnsmxJwt')!;
  }

  Future<int> getWareId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cnsmxWarehouse')!;
  }
  Future<void> isLogged(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('cnsmxJwt') == null && prefs.getString('cnsmxJwt') == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    else {
      final parts = prefs.getString('cnsmxJwt')!.split('.');
      var decodedToken = decodeBase64(parts[1]);
      var expDate = DateTime.fromMillisecondsSinceEpoch(json.decode(decodedToken)['exp'] * 1000);
      if(expDate.compareTo(DateTime.now())>0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MainMenu( )));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }

    }
  }
  logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cnsmxUser');
    prefs.remove('cnsmxJwt');
    prefs.remove('cnsmxWarehouse');
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext ctx) => WelcomePage()));

  }
  String decodeBase64(String str) {
    //'-', '+' 62nd char of encoding,  '_', '/' 63rd char of encoding
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) { // Pad with trailing '='
      case 0: // No pad chars in this case
        break;
      case 2: // Two pad chars
        output += '==';
        break;
      case 3: // One pad char
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
  Future<UserWarehouseModel> getUserWarehouse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var jwt = prefs.getString('cnsmxJwt')!;

    var headers = {
      'Authorization': 'Bearer ' + jwt
    };


    var response = await http.post(Uri.https('connect.construtec.mx', 'mobile/Account/getWarehouse'), headers: headers);
    developer.log(response.body.toString());
    return UserWarehouseModel.fromJson(json.decode(response.body));
  }
  Future<int> setWarehouse(String jwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserWarehouseModel warehouse = await getUserWarehouse();
    prefs.setInt('cnsmxWarehouse', warehouse.data.wareId);
    return warehouse.data.wareId;
  }
  void viewWarehouse() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
class ApiResponse {
  // _data will hold any response converted into
  // its own object. For example user.
  late bool _isError = false;
  late String _token = '';
  // _apiError will hold the error object
  late String _apiError = '';

  String get apiError {
    return _apiError;
  }

  void set isError(bool isError) {
    _isError = isError;
  }

  bool get isError {
    return _isError;
  }

  void set apiError(String error) {
    _apiError = error;
  }

  String get apiToken {
    return _token;
  }

  void set apiToken(String token) {
    _token = token;
  }
}

