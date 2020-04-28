import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/screens/LoginScreen.dart';
import 'dart:convert';
import 'package:share/share.dart';

import 'package:rrptflutter/screens/HomeScreen.dart';
import 'package:rrptflutter/screens/FavouriteScreen.dart';
import 'package:rrptflutter/constants/SigninWithGoogle.dart';

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
//                Navigator.push(context, MaterialPageRoute(builder: (context) {
//                  return FavouriteScreen();
//                }));
                Navigator.pushNamed(context, "FAVOURITE_SCREEN");
              },
            ),
            ListTile(
              title: Text("Notification"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.notifications),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "NOTIFICATION_SCREEN");
              },
            ),
            ListTile(
              title: Text("Share"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.share),
              onTap: () {
                Navigator.of(context).pop();
                Share.share('check out my application https://example.com');
              },
            ),
            ListTile(
              title: Text("About"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.perm_identity),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "ABOUT_SCREEN");
              },
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.account_box),
              onTap: () {
                Navigator.of(context).pop();
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }), ModalRoute.withName('/'));
              },
            )
          ],
        ),
      ),
      body: HomeScreen(),
    );
  }
}
