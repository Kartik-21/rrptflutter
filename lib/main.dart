import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:rrptflutter/screens/AboutScreen.dart';
import 'package:rrptflutter/screens/DrawerHomeScreen.dart';
import 'package:rrptflutter/screens/FavouriteScreen.dart';
import 'package:rrptflutter/screens/HomeScreen.dart';
import 'package:rrptflutter/screens/NotificationScreen.dart';
import 'package:rrptflutter/screens/SplashScreen.dart';
import 'package:rrptflutter/screens/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: "RRPT",
        debugShowCheckedModeBanner: true,
        home: LoginScreen(),
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
          brightness: Brightness.dark,
        ),
        routes: <String, WidgetBuilder>{
          "HOME_SCREEN": (context) => HomeScreen(),
          "FAVOURITE_SCREEN": (context) => FavouriteScreen(),
          "NOTIFICATION_SCREEN": (context) => NotificationScreen(),
          "ABOUT_SCREEN": (context) => AboutScreen(),
        });
  }
}
