import 'dart:async';

import 'package:ing/models/WareHouseProductModel.dart';
import 'package:ing/models/WareInventoryModel.dart';
import 'package:flutter/material.dart';
import 'package:ing/services/warehouse.dart';
import 'package:ing/src/routes/exit/cart.dart';
import 'dart:developer' as dev;



class ExitChoice extends StatefulWidget {
  final int wareId;
  final String wareShortName;
  final List<Data> productsInventory;
  const ExitChoice({Key? key, required this.wareId, required this.wareShortName, required this.productsInventory}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExitChoice();
}

class _ExitChoice extends State<ExitChoice> {
  List<WareHouseProductModel> product = [];
  List<Data> inventory = [];
  List<Data> realinventory = [];

  @override
  void initState() {
    // TODO: implement initState
    inventory.addAll(widget.productsInventory);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text('AL: ' + widget.wareShortName),
        actions: <Widget>[
          Padding(padding: const EdgeInsets.all(10.0),

            child: SizedBox(
                height: 150.0,
                width: 30.0,
                child:  GestureDetector(
                  onTap: () {},
                  child:  Stack(
                    children: <Widget>[
                      IconButton(
                        icon:  const Icon(Icons.shopping_cart, color: Colors.white,),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Cart(products: product, wareShortName: widget.wareShortName, wareId: widget.wareId,)));
                        },
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
        child: _buildList(inventory)

      ),
    );

  }
  Widget _buildList(List<Data> details) {
    //TextEditingController editingController = TextEditingController();
    inventory = details;

    return SizedBox(
        height: (MediaQuery.of(context).size.height),
        child:
        Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  //controller: editingController,
                  decoration: const InputDecoration(
                      labelText: "Buscar",
                      hintText: "Buscar",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(child:
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:inventory.length,
                itemBuilder: (context,index){
                  return
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            onTap: () {
                              setState(() {
                                if(product.any((element) => element.waId == inventory[index].waId) == false) {
                                  product.add(WareHouseProductModel(
                                      waId: inventory[index].waId,
                                      invWareID: inventory[index].invWareID,
                                      invProductID: inventory[index].invProductID,
                                      proDescription: inventory[index].proDescription,
                                      proUnit: inventory[index].proUnit,
                                      quantity: 0.0,
                                      actualInventory: inventory[index].invQuantity
                                  ));
                                }

                              });
                            },
                            leading: const Icon(Icons.shopping_bag, color: Colors.teal),
                            title: Text(inventory[index].proDescription),
                            subtitle: Text(inventory[index].invQuantity.toString() + ' ' + inventory[index].proUnit),
                          )
                        ],
                      ),
                    );
                },
              )
              )]
        )
    );
  }

  void filterSearchResults(String query) {
    List<Data> dummySearchList = [];
    if(query.isEmpty) {
      setState(() {
        inventory.clear();
        inventory.addAll(widget.productsInventory);
      });
    } else {
      for (var element in widget.productsInventory) {
        if(element.proDescription.toUpperCase().contains(query.toUpperCase())) {
          dummySearchList.add(element);
        }
      }
      setState(() {
        inventory.clear();
        inventory.addAll(dummySearchList);
      });
    }
  }

  bool exitsOnProducts(int waId){
    return product.any((element) => element.waId == waId);

  }

}