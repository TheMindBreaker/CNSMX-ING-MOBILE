import 'dart:convert';
import 'dart:developer' as developer;
import 'package:ing/models/UserWarehouseModel.dart';
import 'package:ing/src/login.dart';
import 'package:ing/src/welcome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ing/src/mainMenu.dart';
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
    prefs.setString('cnsmxJwtIng', jwt);
    prefs.setString('cnsmxUserIng', json.decode(decodedToken).toString());
  }
  Future<String> getJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cnsmxJwtIng')!;
  }

  Future<void> isLogged(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('cnsmxJwtIng') == null && prefs.getString('cnsmxJwtIng') == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
    else {
      final parts = prefs.getString('cnsmxJwtIng')!.split('.');
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
    prefs.remove('cnsmxUserIng');
    prefs.remove('cnsmxJwtIng');
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

