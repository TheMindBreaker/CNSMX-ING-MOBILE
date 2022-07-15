import 'dart:async';
import 'package:ing/models/WareHouseProductModel.dart';
import 'package:flutter/material.dart';
import 'package:ing/src/mainMenu.dart';
import 'package:ing/src/routes/exit/selectFrontAndValidate.dart';
import 'package:ots/ots.dart';
import 'dart:developer' as dev;



class Cart extends StatefulWidget {
  final int wareId;
  final String wareShortName;
  final List<WareHouseProductModel> products;
  const Cart({Key? key, required this.products,required this.wareId, required this.wareShortName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Cart();
}

class _Cart extends State<Cart> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: const Text('Carrito'),
          actions: [
            widget.products.isNotEmpty?
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      SelectFrontAndValidate(cart: widget.products, wareId: widget.wareId, wareShortName: widget.wareShortName,)));
                },
                icon: const Icon(Icons.arrow_forward)):
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu()));
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: SizedBox(
            height: (MediaQuery.of(context).size.height),
            child:
              widget.products.isEmpty?
              const Center( child:Text('No Hay nada en el carrito')):
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:widget.products.length,
                itemBuilder: (context,index){
                  return
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              _quantitySelect(context, widget.products[index], index);
                            },
                            title: Text(widget.products[index].proDescription),
                            trailing: IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  widget.products.removeAt(index);
                                });
                              },
                            ),
                            subtitle:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('PED: ' + widget.products[index].quantity.toString() + ' ' + widget.products[index].proUnit),
                                Text('DIS: ' + widget.products[index].actualInventory.toString() + ' ' + widget.products[index].proUnit),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                },
              )

        )
    );

  }


  Future<void> _quantitySelect(BuildContext context, WareHouseProductModel product, int index) async {
    double act = product.actualInventory;
    final _quantity = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: Text(product.proDescription, textScaleFactor: 1)
            ),
            actions: <Widget>[
              TextField(
                controller: _quantity,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  label: Text('Unidad: ' + product.proUnit),
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
                  var tmp = double.parse(_quantity.text);
                  if(tmp > 0 && tmp <= act) {
                    setState(() {
                      product.quantity = tmp;
                      Navigator.pop(context);
                    });
                  } else {
                    showNotification(
                      title: 'Error!!!!!',
                      message: 'La Cantidad es mayor a la disponible: ' + product.actualInventory.toString() + ' ' + product.proUnit,
                      backgroundColor: Colors.red,
                      autoDismissible: true,
                    );
                  }
                },
              ),
            ],
          );
        });
  }


}