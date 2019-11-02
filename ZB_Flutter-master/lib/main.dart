import 'package:flutter/material.dart';
import 'splash_screen.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
// import 'package:flutter/services.dart';
void  main() {
  runApp(MyApp());
  // await FlutterStatusbarcolor.setStatusBarColor(Colors.green[400]);
  // if (useWhiteForeground(Colors.green[400])) {
  //   FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  // } else {
  //   FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  // }
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YLRC',
      color:Colors.red,
      theme: new ThemeData(
        primaryColor: Colors.blue,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        platform: TargetPlatform.iOS,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

