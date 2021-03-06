import 'package:ing/services/auth.dart';
import 'package:ing/src/routes/exit/index.dart';
import 'package:ing/src/routes/home/index.dart';
import 'package:ing/src/routes/settings/index.dart';
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
        backgroundColor: Colors.black,
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
            activeColor: Colors.black12,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.warehouse),
            title: const Text('Salidas'),
            activeColor: Colors.black12,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Conf'),
            activeColor: Colors.black12,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}