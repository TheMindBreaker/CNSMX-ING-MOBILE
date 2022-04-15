import 'package:ing/src/mainMenu.dart';
import 'package:flutter/material.dart';
import 'package:ing/services/auth.dart';
import 'package:ing/src/Widgets/bezierContainer.dart';
import 'dart:developer' as developer;
import 'package:ots/ots.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  _LoginPageState createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController accoController = TextEditingController();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Regresar',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
  Widget _entryField(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
  Widget _entryFieldAcco(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 10,),
          TextField(
              keyboardType: TextInputType.number,
              controller: accoController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {

    return InkWell(
      onTap: () {_handleSubmitted(emailController.text, accoController.text);},
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromRGBO(215,35,35,1), Color.fromRGBO(250,36,36,1)])),
        child: const Text('Validar', style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return Image.asset('assets/logos/CNSMX-01.png', width: 200,);
  }
  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email"),
        _entryFieldAcco("ACCO"),
      ],
    );
  }

  void _handleSubmitted(email, acco) async {
      showLoader(
        isModal: true,
      );
      ApiResponse _apiResponse = await AuthService().authenticateUser(email, acco);
      if(_apiResponse.isError) {
        hideLoader();
        showNotification(
          title: 'Error!!!!!',
          message: _apiResponse.apiError,
          backgroundColor: Colors.red,
          autoDismissible: true,
          notificationDuration: 4000,
        );
      }
      else {
        hideLoader();
        AuthService().setUserIdent(_apiResponse.apiToken);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainMenu()),
        );
        bakeToast("Usuario Iniciado", type: ToastType.success);
      }

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: const Key('_scaffoldKey'),
        body: Container(
          height: height,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child:Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: const BezierContainer()),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 50),
                      _emailPasswordWidget(),
                      SizedBox(height: 20),
                      _submitButton(),
                      SizedBox(height: height * .055),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),

            ],
          ),
          ),
        )
    );
  }

}

