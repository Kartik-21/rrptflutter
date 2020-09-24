import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rrptflutter/screens/AboutScreen.dart';
import 'package:rrptflutter/screens/DrawerHomeScreen.dart';
import 'package:rrptflutter/screens/FavouriteScreen.dart';
import 'package:rrptflutter/screens/FirstScreen.dart';
import 'package:rrptflutter/screens/NotificationScreen.dart';
import 'package:rrptflutter/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "RRPT",
        debugShowCheckedModeBanner: true,
        home: FirstScreen(),
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
          brightness: Brightness.dark,
          fontFamily: "ManropSemiBold"
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/login": (context) => LoginScreen(),
          "/favourite": (context) => FavouriteScreen(),
          "/notification": (context) => NotificationScreen(),
          "/about": (context) => AboutScreen(),
        });
  }
}
