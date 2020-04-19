import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rrptflutter/screens/HomeScreen.dart';
import 'package:rrptflutter/screens/FavouriteScreen.dart';

class DrawerHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DrawerHomeScreenState();
  }
}

class _DrawerHomeScreenState extends State<DrawerHomeScreen> {
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
              decoration: BoxDecoration(color: Colors.black12),
            ),
            ListTile(
              title: Text("Home Page"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return HomeScreen();
//                })
//                );
              },
            ),
            ListTile(
              title: Text("Favourite"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FavouriteScreen();
                }));
              },
            ),
            ListTile(
              title: Text("Notification"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.notifications),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Share"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.share),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("About"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.perm_identity),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.account_box),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: HomeScreen(),
    );
  }
}
