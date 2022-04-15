import 'dart:typed_data';
import 'package:ing/models/RequisitionsInfoModel.dart' as InfoModel;
import 'package:flutter/material.dart';
import 'package:ing/models/RequisitionsProductModel.dart';
import 'package:ing/services/or.dart';
import 'package:ing/services/warehouse.dart';
import 'package:ing/src/mainMenu.dart';
import '../../../models/ExitsDetails.dart';
import 'dart:convert';
import 'package:images_picker/images_picker.dart';



class ReqDetails extends StatefulWidget {
  final int reqId;
  final String reqCode;
  final String reqFront;
  final String reqPlace;
  const ReqDetails({Key? key, required this.reqId, required this.reqFront, required this.reqCode, required this.reqPlace}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReqDetails();
}

class _ReqDetails extends State<ReqDetails> {


  Color photoColor = Colors.red;
  Color signatureColor = Colors.red;
  Media? _image;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: Text('ReqID: ' + widget.reqId.toString()),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu()));
            }, icon: const Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: const <Widget>[],
                ),
              ),

              ListTile(
                isThreeLine: true,
                leading: const Icon(Icons.verified_user, color: Colors.blue),
                title: Text('Clave: ' + widget.reqCode),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Frente: ' + widget.reqFront),
                      Text('Lugar: ' + widget.reqPlace)
                    ]
                ),
              ),

              const Divider(
                height: 10,
                thickness: 10,
              ),
              FutureBuilder<RequisitionsProductModel>(
                future: OrderService().getRequisitionProducts(widget.reqId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data?.error == true){
                      return _buildAlertDialog(snapshot.data?.stack);
                    } else {
                      return _buildList(snapshot.data!);
                    }
                  }
                  else if (snapshot.hasError) {
                    return _buildAlertDialog(snapshot.error.toString());
                  }

                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              ),



            ],
          )
      ),
    );

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
  Widget _buildList(RequisitionsProductModel details) {
    return SizedBox(
        height: (MediaQuery.of(context).size.height),
        child:
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount:details.data.length,
          itemBuilder: (context,index){
            return
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.shopping_bag, color: Colors.teal),
                      title: Text(details.data[index].proDescription),
                      subtitle: Text(details.data[index].reqQuantity.toString() + ' ' + details.data[index].proUnit),
                    )
                  ],
                ),
              );
          },
        )
    );
  }

}