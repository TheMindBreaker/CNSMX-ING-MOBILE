import 'package:ing/models/RequisitionsInfoModel.dart';
import 'package:ing/models/WareInventoryModel.dart';
import 'package:flutter/material.dart';
import 'package:ing/src/routes/home/requisition.dart';
import 'dart:developer';

import '../../../services/or.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeIndex();
}

class _HomeIndex extends State<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<RequisitionsInfoModel>(
          future: OrderService().getRequisitionsByCreator(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data?.error == true){
                return _buildAlertDialog(snapshot.data!.stack);
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

  Widget _buildOrValidation(RequisitionsInfoModel info) {


    return SizedBox(
        height: (MediaQuery.of(context).size.height),
        child:
        ListView.builder(
          shrinkWrap: true,
          itemCount: info.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: ListTile(
                  isThreeLine: true,
                  leading: const Icon(Icons.category_rounded, color: Colors.amber),
                  title: Text(info.data[index].reqID),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('LU: ' + info.data[index].plaName),
                      Text('FR: ' + info.data[index].frontName),
                      Text(info.data[index].reqCreatedDate),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReqDetails(reqId: info.data[index].id,reqCode: info.data[index].reqID, reqFront: info.data[index].frontName, reqPlace: info.data[index].plaName,)));
                  },
                )
            );
          },
        )
    );

  }

}