import 'package:al/models/ExitsInfo.dart';
import 'package:al/models/WareInventoryModel.dart';
import 'package:al/services/warehouse.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/rendering.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeIndex();
}

class _HomeIndex extends State<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<WareInventory>(
          future: WarehouseService().wareInventory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data?.error == true){
                return _buildAlertDialog(snapshot.data?.stack);
              } else {
                return _buildOrValidation(snapshot.data!);
              }
            } else if (snapshot.hasError) {
              return _buildAlertDialog(snapshot.error.toString());
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        )
    );
  }

  Widget _buildAlertDialog(error) {
    return AlertDialog(
      title: const Text('Error!'),
      content:
      Text(error),
    );
  }

  Widget _buildOrValidation(WareInventory info) {


    return SizedBox(
        height: (MediaQuery.of(context).size.height),
          child:
          ListView.builder(
            shrinkWrap: true,
            itemCount: info.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                    leading: const Icon(Icons.category_rounded, color: Colors.amber),
                    title: Text(info.data[index].proDescription),
                    subtitle: Text(info.data[index].invQuantity.toString() + ' ' + info.data[index].proUnit + ' + Salidas Pendientes')
                )
              );
            },
          )
        );

  }

}