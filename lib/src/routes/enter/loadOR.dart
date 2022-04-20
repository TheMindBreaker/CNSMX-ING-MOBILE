import 'package:ing/models/orderInfoModel.dart';
import 'package:ing/src/mainMenu.dart';
import 'package:flutter/material.dart';
import 'package:ing/services/or.dart';


class LoadOr extends StatefulWidget {
  final String? orCode;
  const LoadOr({Key? key, required this.orCode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadOr();
}


class _LoadOr extends State<LoadOr> {

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu())),
          ),
          title: Text('IOR:'+ widget.orCode!)
      ),
      body: Center(
        child: FutureBuilder<OrderInfoModel>(
          future: OrderService().getOr(widget.orCode!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data?.error == true){
                return _buildAlertDialog(snapshot.data?.stack);
              } else {
                return _buildOrValidation(snapshot.data?.data?.purID, snapshot.data);
              }
            } else if (snapshot.hasError) {
              return _buildAlertDialog(snapshot.error.toString());
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }


  bool isSameOr(String? inputOr, String? apiOr) {
    return false;
  }

  Widget _buildAlertDialog(error) {
    return AlertDialog(
      title: const Text('Error!'),
      content:
      Text(error),
      actions: <Widget>[
        TextButton(
            child: const Text("Regresar"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
  Widget _buildOrValidation(String? data, OrderInfoModel? info) {
    final _formKey = GlobalKey<FormState>();


    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: TextFormField(
                cursorColor: Colors.black,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Debe de escribir los datos';
                  } else {
                    if(text.toUpperCase() != data!.substring(data.length - 4).toString()) {
                      return 'La orden no es correcta';
                    } else {
                      return null;
                    }
                  }
                },
                decoration: const InputDecoration(
                  filled: true,
                  label: Text('Inserte los ultimos 4 de la OR'),
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                ),
              ),
            ),
            Center(
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold)
                  ),
                  child: const Text('Continuar'),
                )
            )
          ],
        )
    );
  }

}

