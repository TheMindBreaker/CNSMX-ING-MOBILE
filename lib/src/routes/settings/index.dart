import 'dart:convert';
import 'package:al/models/WareHousesModel.dart';
import 'package:al/services/warehouse.dart';
import 'package:flutter/material.dart';
import 'package:ots/ots.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../services/auth.dart';
import '../../mainMenu.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'dart:developer' as dev;


class SettIndex extends StatefulWidget {
  const SettIndex({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettIndex();
}

class _SettIndex extends State<SettIndex> {
  int? WareId;
  String? jwt;

  PackageInfo? appInfo;


  @override
  Widget build(BuildContext context) {
    AuthService().getWareId().then((value) => WareId = value);
    AuthService().getJwt().then((value) => jwt = value);
    PackageInfo.fromPlatform().then((value) => appInfo = value);
    return Scaffold(
      body: FutureBuilder<WareHousesModel>(
        future: WarehouseService().getWarehouse(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data?.error == true){
              return _buildAlertDialog(snapshot.data?.stack);
            } else {
              return _buildSettings(snapshot.data!.data!);
            }
          } else if (snapshot.hasError) {
            return _buildAlertDialog(snapshot.error.toString());
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  Widget _buildSettings (List<Data> userSettings) {

    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text('Almacen Actual: ' + WareId.toString()),
            trailing: const Icon(Icons.refresh, color: Colors.blue),
            subtitle: const Text('Puede consultar la lista de almacenes con el encargado de almacen'),
            onTap: () {
              showLoader();
              AuthService().setWarehouse(jwt!).then((value) => {
                hideLoader(),
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu())),
            });},
          ),
        ),
        const Divider(thickness: 20, color: Colors.white54),
        Card(
          child: ListTile(
            leading: const Icon(Icons.info, color: Colors.blue,),
            title: Text('Name: ' + appInfo!.appName, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            subtitle: Text('V: ' + appInfo!.version, textAlign: TextAlign.center,),
            trailing: const Icon(Icons.info, color: Colors.blue),
          ),
        ),
        Card(
          color: Colors.blueAccent,
          child: ListTile(
            leading: const Icon(Icons.update, color: Colors.white,),
            title: const Text('Actualizar App', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
            trailing: const Icon(Icons.update, color: Colors.white),
            onTap: () {
              upgrade();
            },
          ),
        ),

        const Divider(thickness: 20, color: Colors.white54),

        Card(
          color: Colors.redAccent,
          child: ListTile(
            leading: const Icon(Icons.door_back_door, color: Colors.white,),
            title: const Text('Cerrar Session', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
            trailing: const Icon(Icons.door_back_door, color: Colors.white),
            onTap: () {AuthService().logout(context);},
          ),
        )
      ],
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

  void upgrade() async {
    showLoader();
    RUpgrade.upgrade(
        'https://github.com/TheMindBreaker/CNSMX-AL-MOBILE/raw/main/CurrentAPK/app-release.apk',
        fileName: 'app-release.apk',isAutoRequestInstall: true, notificationVisibility: NotificationVisibility.VISIBILITY_VISIBLE_NOTIFY_COMPLETED
    ).then((value) => {
      dev.log(value.toString()),
      hideLoader()
    });
  }

}