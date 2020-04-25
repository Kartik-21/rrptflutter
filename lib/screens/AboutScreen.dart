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
      body: Center(
        child: Container(
          height: 300.0,
          width: 300.0,
          child: Center(
              child: Column(
            children: <Widget>[
              Image.asset(
                "assets/icon/icon.png",
                height: 150.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "v 1.0.0",
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  )),
            ],
          )),
        ),
      ),
    );
  }
}
