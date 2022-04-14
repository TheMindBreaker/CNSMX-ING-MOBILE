import 'dart:typed_data';
import 'package:al/src/mainMenu.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:al/services/warehouse.dart';
import 'package:ots/ots.dart';
import 'dart:developer' as developer;
import '../../../models/ExitsDetails.dart';
import '../../../models/ExitsInfo.dart';
import 'package:signature/signature.dart';
import 'dart:convert';
import 'package:images_picker/images_picker.dart';



class ExitInfo extends StatefulWidget {
  final int exitId;
  final ExistsInfo info;
  const ExitInfo({Key? key, required this.exitId, required this.info}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExitInfo();
}

class _ExitInfo extends State<ExitInfo> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.white,
    exportBackgroundColor: Colors.black,
  );


  Color photoColor = Colors.red;
  Color signatureColor = Colors.red;
  Media? _image;

  Future<void> _openImagePicker() async {
    await ImagesPicker.openCamera(
      pickType: PickType.image,
      quality: 0.5,
      maxSize: 500,
    ).then((value) => {
      _image = value![0]
    });

    setState(() {
      photoColor = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: Text('Exit ID: ' + widget.exitId.toString())
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(Icons.key),
                        color: signatureColor,
                        onPressed: _showSignature
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera),
                      color: photoColor,
                      onPressed: _openImagePicker,
                    ),
                    signatureColor == Colors.green && photoColor == Colors.green?
                    IconButton(
                      icon: const Icon(Icons.check),
                      color: Colors.blue,
                      onPressed: validateAndUpload,
                    ) : const Text('Faltan Datos'),
                  ],
                ),
              ),

              ListTile(
                leading: const Icon(Icons.verified_user, color: Colors.blue),
                title: Text('Entregar a: ' + widget.info.data[0].receiverName),
                subtitle: Text('Frente: ' + widget.info.data[0].frontName),
              ),

              const Divider(
                height: 10,
                thickness: 10,
              ),
              FutureBuilder<ExistsDetails>(
                future: WarehouseService().wareExistDetails(widget.exitId),
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



            ],
          )
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
  Widget _buildList(ExistsDetails details) {
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
                      leading: const Icon(Icons.shopping_bag, color: Colors.teal),
                      title: Text(details.data[index].proDescription),
                      subtitle: Text(details.data[index].quantity.toString() + ' ' + details.data[index].proUnit),
                    )
                  ],
                ),
              );
          },
        )
    );
  }


  Future _showSignature()  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Firma de receptor'),
          content: SingleChildScrollView(
            child: Signature(
              controller: _controller,
              height: 300,
              backgroundColor: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              color: Colors.green,
              onPressed: () async {
                if (_controller.isNotEmpty) {
                  final Uint8List? data = await _controller.toPngBytes();
                  if (data != null) {
                    setState(() {
                      signatureColor = Colors.green;
                    });
                    Navigator.pop(context);
                  }
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.undo),
              color: Colors.blue,
              onPressed: () {
                setState(() => _controller.undo());
              },
            ),
            IconButton(
              icon: const Icon(Icons.redo),
              color: Colors.blue,
              onPressed: () {
                setState(() => _controller.redo());
              },
            ),
            //CLEAR CANVAS
            IconButton(
              icon: const Icon(Icons.clear),
              color: Colors.red,
              onPressed: () {
                setState(() {
                  _controller.clear();
                  signatureColor = Colors.red;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void validateAndUpload() async{
    showLoader();
    if(_image != null) {
      if (_controller.isNotEmpty) {
        final Uint8List? data = await _controller.toPngBytes();
        if (data != null) {
          _controller.toPngBytes().then((value) => {
            //developer.log(base64.encode(value!))
            WarehouseService().releaseExit(widget.exitId, base64.encode(File(_image!.path).readAsBytesSync()), base64.encode(value!)).then((value) =>
            {
              if(value.error) {
                bakeToast('Error:' + value.stack!, type: ToastType.error),
                hideLoader()
              } else {
                bakeToast('Se agrego sin problemas', type: ToastType.success),
                hideLoader(),
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MainMenu())),
              }
            })
            //developer.log(base64.encode(File(_image!.path).readAsBytesSync()))
          });
        } else {
          bakeToast('Falta firma', type: ToastType.error);
          hideLoader();
        }
      } else {
        bakeToast('Faltan los datos para cargar', type: ToastType.error);
        hideLoader();
      }
    } else {
      bakeToast('Favor de volver a tomar la foto', type: ToastType.info);
      hideLoader();
    }

  }


}