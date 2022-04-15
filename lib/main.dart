import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import 'package:ing/src/welcome.dart';
import 'package:ots/ots.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(onWillPop: _onWillPop,
      child: OTS(

        showNetworkUpdates: true,
        persistNoInternetNotification: true,
        child: MaterialApp(
          title: 'CNSMX-AL',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
              bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: WelcomePage(),
        )
    )
    );
  }
}


