import 'package:al/models/ExitsInfo.dart';
import 'package:al/services/warehouse.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

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
        body: FutureBuilder<ExistsInfo>(
          future: WarehouseService().wareExistInfo(),
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

  Widget _buildOrValidation(ExistsInfo info) {


    return SizedBox(
      height: (MediaQuery.of(context).size.height),
      child:
        ListView.builder(
          shrinkWrap: true,
          itemCount: info.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child:ListTile(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ExitInfo(exitId: info.data[index].id , info: info)));
                  },
                  leading: const Icon(Icons.transit_enterexit, color: Colors.green),
                  title: Text(info.data[index].frontName),
                  subtitle: Text(info.data[index].receiverName,)
              ),
            );
          },
        ),
    );

  }

}