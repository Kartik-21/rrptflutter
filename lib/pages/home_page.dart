import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo[400]),
            ),
            ListTile(
              title: Text("Home Page"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.home),
              onTap: () {},
            ),
            ListTile(
              title: Text("Favourite"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.favorite),
              onTap: () {},
            ),
            ListTile(
              title: Text("Notification"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.notifications),
              onTap: () {},
            ),
            ListTile(
              title: Text("Share"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.share),
              onTap: () {},
            ),
            ListTile(
              title: Text("About"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.perm_identity),
              onTap: () {},
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.account_box),
              onTap: () {},
            )
          ],
        ),
      ),
      body: Container(),
    );
  }
}
