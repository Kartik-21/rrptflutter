import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
void main() {
  runApp(MaterialApp(
    title: "RRPT",
    debugShowCheckedModeBanner: true,
    home: HomePage(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      brightness: Brightness.dark,
    ),
  ));
}
