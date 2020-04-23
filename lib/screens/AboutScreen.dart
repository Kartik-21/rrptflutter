import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Container(
        child: Center(
            child: Column(
          children: <Widget>[
            Image(
              image: AssetImage("assets/icon/icon.png"),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "v^1.0.0",
                  textAlign: TextAlign.center,
                )),
          ],
        )),
      ),
    );
  }
}
