import 'dart:typed_data';
import 'package:ing/models/WareHouseProductModel.dart';
import 'package:ing/models/WareInventoryModel.dart';
import 'package:ing/src/mainMenu.dart';
import 'package:flutter/material.dart';
import 'package:ing/services/warehouse.dart';




class ExitChoice extends StatefulWidget {
  final int wareId;
  final String wareShortName;
  const ExitChoice({Key? key, required this.wareId, required this.wareShortName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExitChoice();
}

class _ExitChoice extends State<ExitChoice> {
  List<WareHouseProductModel> product = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: Text('AL: ' + widget.wareShortName),
          actions: <Widget>[

            Padding(padding: const EdgeInsets.all(10.0),

              child:  Container(
                  height: 150.0,
                  width: 30.0,
                  child:  GestureDetector(
                    onTap: () {},
                    child:  Stack(
                      children: <Widget>[
                         const IconButton(icon:  Icon(Icons.shopping_cart,
                          color: Colors.white,),
                          onPressed: null,
                        ),
                        product.isEmpty ?  Container() :
                         Positioned(

                            child:  Stack(
                              children: <Widget>[
                                 const Icon(
                                    Icons.brightness_1,
                                    size: 20.0, color: Colors.white54),
                                 Positioned(
                                    top: 3.0,
                                    right: 4.0,
                                    child:  Center(
                                      child:  Text(
                                        product.length.toString(),
                                        style:  const TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    )),


                              ],
                            )),

                      ],
                    ),
                  )
              )

              ,)],

      ),
      body: SizedBox(
        height: (MediaQuery.of(context).size.height),
        child: FutureBuilder<WareInventory>(
          future: WarehouseService().wareInventory(widget.wareId),
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
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const <Widget>[ CircularProgressIndicator()]
                )
            );
          },
        ),

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
  Widget _buildList(WareInventory details) {
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
                      onTap: () {
                        setState(() {
                          product.add(WareHouseProductModel(
                              waId: details.data[index].waId,
                              invWareID: details.data[index].invWareID,
                              invProductID: details.data[index].invProductID,
                          ));
                        });
                      },
                      leading: const Icon(Icons.shopping_bag, color: Colors.teal),
                      title: Text(details.data[index].proDescription),
                      subtitle: Text(details.data[index].invQuantity.toString() + ' ' + details.data[index].proUnit),
                    )
                  ],
                ),
              );
          },
        )
    );
  }

}