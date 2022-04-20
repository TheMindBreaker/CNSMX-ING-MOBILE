import 'package:flutter/material.dart';
import 'package:ing/models/WareHouseProductModel.dart';
import 'package:ing/services/or.dart';
import 'package:ing/services/warehouse.dart';
import 'package:ots/ots.dart';
import '../../mainMenu.dart';
import 'dart:developer' as dev;
class SelectFrontAndValidate extends StatefulWidget {
  final int wareId;
  final String wareShortName;
  final List<WareHouseProductModel> cart;
  const SelectFrontAndValidate({Key? key, required this.cart,required this.wareId,required this.wareShortName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectFrontAndValidate();
}
class _SelectFrontAndValidate extends State<SelectFrontAndValidate> {
  String frontName = 'Not Selected';
  String plaName = 'Not Selected';
  int placeId = 0;
  TextEditingController frontNo = TextEditingController();
  TextEditingController receptorName = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    frontNo.dispose();
    receptorName.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: const Text('Datos para salida'),
          actions: [
            widget.cart.isNotEmpty?
            IconButton(
                onPressed: () {
                  sendExit();
                },
                icon: const Icon(Icons.check)):
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu()));
                },
                icon: const Icon(Icons.home))
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                const Divider(),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    searchFront(value);
                  },
                  controller: frontNo,
                  decoration: const InputDecoration(
                      labelText: "No. Frente",
                      hintText: "No. Frente",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.info, color: Colors.blueAccent,),
                    title: Text('PL: ' + plaName),
                    subtitle: Text('FR: ' + frontName),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: receptorName,
                  decoration: const InputDecoration(
                      labelText: "Receptor",
                      hintText: "Receptor",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
                const Divider(thickness: 10, color: Colors.white70,),
                const Center(child: Text('Productos Selecionados'),),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:widget.cart.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: ListTile(
                          title: Text(widget.cart[index].proDescription),
                          subtitle: Text('PED: ' + widget.cart[index].quantity.toString() + ' ' + widget.cart[index].proUnit),
                        ),
                      );
                    }
                )
              ],
              ),
            )
        )
    );
  }

  searchFront(String frontNo) {
    if(frontNo.isEmpty) {
      setState(() {
        frontName = 'Not Selected';
        plaName = 'Not Selected';
      });
    } else {
      OrderService().getFront(int.parse(frontNo)).then((value) => {
        if(value.error) {
          setState(() {
            frontName = 'No Existe';
            plaName = 'No Existe';
          }),
        }
        else {
          if(value.data.isEmpty) {
            setState(() {
              frontName = 'No Existe';
              plaName = 'No Existe';
            })
          }else {
            setState(() {
              frontName = value.data[0].frontName;
              plaName = value.data[0].plaName;
              placeId = value.data[0].idPlace;
            })
          }
        }

      });
    }
  }

  sendExit() {
    if(frontNo.text.isEmpty || receptorName.text.isEmpty | widget.wareId.toString().isEmpty) {
      showNotification(
        title: 'Error!!!!!',
        message: 'Faltan datos para enviar salida',
        backgroundColor: Colors.red,
        autoDismissible: true,
      );
    } else {
      if(widget.cart.isEmpty) {
        showNotification(
          title: 'Error!!!!!',
          message: 'El Carrito esta vacio',
          backgroundColor: Colors.red,
          autoDismissible: true,
        );
      } else {
        showLoader();
        WarehouseService().createExit(widget.wareId, int.parse(frontNo.text), placeId, widget.cart, receptorName.text).then((value) =>
        {
          if(value.error) {
            showNotification(
              title: 'Error!!!!!',
              message: 'Tuvimos error al crear la salida, favor de volver a intentar mas tarde',
              backgroundColor: Colors.red,
              autoDismissible: true,
            ),
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu())),
            hideLoader(),
          } else {
            showNotification(
                title: 'Exito',
                message: 'Salida creada con exito ' + value.data!.insertId.toString(),
                backgroundColor: Colors.green,
                autoDismissible: true
            ),
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu())),
            hideLoader(),
          }
        });
      }
    }
  }
}