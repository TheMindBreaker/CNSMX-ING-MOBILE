import 'package:al/services/auth.dart';
import 'package:al/src/routes/enter/index.dart';
import 'package:al/src/routes/exit/index.dart';
import 'package:al/src/routes/home/index.dart';
import 'package:al/src/routes/settings/index.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenu createState() => _MainMenu();
}

class _MainMenu extends State<MainMenu>
{
  int currentIndex = 0;

  List listOfColors = [
    const HomeIndex(),
    const EnterIndex(),
    const ExitIndex(),
    const SettIndex(),
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => AuthService().logout(context), icon: const Icon(Icons.exit_to_app)),
        ],
        title: const Text(
          'Inventario Seguro',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: listOfColors[currentIndex],

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Inicio'),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.plus_one),
            title: const Text('Entradas'),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.exposure_minus_1),
            title: const Text('Salidas'),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Conf'),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}