import 'package:ing/models/ExitsInfo.dart';
import 'package:ing/models/WareHousesModel.dart';
import 'package:ing/services/warehouse.dart';
import 'package:flutter/material.dart';
import 'package:ots/ots.dart';
import 'dart:developer' as dev;

import 'exitInfo.dart';


class ExitIndex extends StatefulWidget {
  const ExitIndex({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExitIndex();
}

class _ExitIndex extends State<ExitIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<WareHousesModel>(
          future: WarehouseService().getWarehouse(),
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

  Widget _buildOrValidation(WareHousesModel info) {


    return SizedBox(
      height: (MediaQuery.of(context).size.height),
      child:
      ListView.builder(
        shrinkWrap: true,
        itemCount: info.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child:ListTile(
                onTap: () {
                  showLoader();
                  WarehouseService().wareInventory(info.data![index].id!).then((value) => {
                    if(value.error) {
                      hideLoader(),
                      _buildAlertDialog(value.stack)
                    } else {
                      hideLoader(),
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          ExitChoice(wareId: info.data![index].id!, wareShortName: info.data![index].wareShorName!, productsInventory: value.data,)))
                    }
                  });

                },
                leading: const Icon(Icons.warehouse, color: Colors.greenAccent),
                title: Text(info.data![index].wareName!),
                subtitle: Text(info.data![index].wareShorName!,)
            ),
          );
        },
      ),
    );

  }

}