import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rrptflutter/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutScreenState();
  }
}

class _AboutScreenState extends State<AboutScreen> {
  double _height, _width, _blockOfHeight, _blockOfWidth;

  _openfiledata(String ur) async {
    String url = ur;
    if (await canLaunch(url)) {
      //  Fluttertoast.showToast(msg: "Opening File...");
      await launch(url);
    } else {
      //Fluttertoast.showToast(msg: "Could't Open File");
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = _height ?? MediaQuery.of(context).size.height;
    _width = _width ?? MediaQuery.of(context).size.width;
    _blockOfHeight = _height / 100;
    _blockOfWidth = _width / 100;

    return Container(
      width: _width,
      height: _height,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).about),
          elevation: 5.0,
        ),
        body: Container(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: Image.asset(
                      "assets/icon/icon.png",
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        S.of(context).applicationTitle,
                        style: TextStyle(fontSize: 25.0),
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        "v 1.1.0",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 230.0),
                      child: Linkify(
                        text: "rrpt.books@gmail.com",
                        onOpen: (link) {
                          _openfiledata('${link.url}');
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Copyright 2020 All rights reserved.",
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
