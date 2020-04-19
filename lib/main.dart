import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:rrptflutter/screens/DrawerHomeScreen.dart';
import 'package:rrptflutter/screens/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    title: "RRPT",
    debugShowCheckedModeBanner: true,
    home: DrawerHomeScreen(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    ),
//    routes: <String ,WidgetBuilder>{
//      HOME_PAGE=> HomePage();
//      ,
//
//    },
  ));
}
