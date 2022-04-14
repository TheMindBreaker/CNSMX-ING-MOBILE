import 'package:al/models/WareEnterProduct.dart';
import 'package:al/models/orderInfoModel.dart';
import 'package:al/models/orderProductsModel.dart';
import 'package:al/services/or.dart';
import 'package:al/services/warehouse.dart';
import 'package:flutter/material.dart';
import 'package:al/models/orderProductsModel.dart' as products_model;
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';


import 'package:ots/ots.dart';

import '../../mainMenu.dart';


class EnterMaterial extends StatefulWidget {
  final OrderInfoModel info;
  const EnterMaterial({required this.info});

  @override
  State<StatefulWidget> createState() => _EnterMaterial();
}

class _EnterMaterial extends State<EnterMaterial> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OrderInfoModel? info = widget.info;
    Future<OrderProductsModel> details = OrderService().getOrProducts(info.data!.id.toString());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Text(info.data!.purIDProvider.toString()),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu()));
              },
              icon: const Icon(Icons.home)
          )
        ],
      ),
      body: FutureBuilder<products_model.OrderProductsModel>(
        future: OrderService().getOrProducts(info.data!.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data?.error == true){
              return _buildAlertDialog(snapshot.data?.stack);
            } else {
              return _buildList(snapshot.data! ,info);
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
  Widget _buildList(products_model.OrderProductsModel products,OrderInfoModel info) {
    List<TextEditingController> _quantityController = [];
    return SizedBox(
        height: (MediaQuery.of(context).size.height),
        child:ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount:products.data?.length,
          itemBuilder: (context,index){
            _quantityController.add(TextEditingController(text: products.data![index].purDelived.toString()));
            return
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    (products.data![index].purQuantity - products.data![index].purDelived) > 0?
                    ListTile(
                      onTap: ()  {
                        developer.log((products.data![index].purQuantity - products.data![index].purDelived).toString());
                        _displayEnter(context ,products.data![index], products,info, index);
                      },
                      leading: const Icon(Icons.shopping_bag, color: Colors.blue,),
                      title: Text(products.data![index].proID!),
                      subtitle: Text(products.data![index].proDescription!),
                    ):
                    ListTile(
                      leading: const Icon(Icons.check, color: Colors.green,),
                      title: Text(products.data![index].proID!),
                      subtitle: Text(products.data![index].proDescription!),
                    ),
                  ],
                ),
              );
          },
        )
    );
  }

  Future<void> _displayEnter(BuildContext context, products_model.Data productsData ,products_model.OrderProductsModel allData,OrderInfoModel info, int index) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int WareId = prefs.getInt('cnsmxWarehouse')!;
    final _quantity = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: Text(productsData.proDescription!, textScaleFactor: 1)
            ),
            actions: <Widget>[
              TextField(
                controller: _quantity,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Unidad: ' + productsData.proUnit!),
                  border: const OutlineInputBorder(),
                  fillColor: Colors.white,
                ),
              ),
              ElevatedButton(
                child: const Text('CERRAR'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    if(_quantity.text.isEmpty || _quantity.text == null) {
                      bakeToast('No existe texto', type: ToastType.error);
                    }
                    final n = double.parse(_quantity.text);
                    if(n == null) {
                      bakeToast(_quantity.text + ' No es un numero valido', type: ToastType.error);
                    }
                    else {
                      if(n.toDouble() <= (productsData.purQuantity - productsData.purDelived)) {
                        showLoader(
                          isModal: true,
                        );
                        Navigator.pop(context, false);
                        WarehouseService().wareEnterProduct(
                            productsData.realProId!, info.data!.id!, info.data!.reqID!, info.data!.purIDProvider!,
                            info.data!.reqCode!, WareId, n.toDouble(), productsData.purProductID!
                        ).then((WareEnterProduct value) => {
                          allData.data!.removeAt(index),
                          hideLoader(),
                          if(value.error==true){
                            bakeToast('Error de ingreso. '+ value.stack!, type: ToastType.warning),
                            setState(() {})
                          } else {
                            bakeToast('Ingresado.', type: ToastType.success),
                            setState(() {})
                          }

                        });
                      } else {
                        bakeToast('La cantidad ingresada es mayor', type: ToastType.warning);
                      }
                    }
                    //Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }


}