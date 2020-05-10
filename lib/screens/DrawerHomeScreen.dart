import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/screens/LoginScreen.dart';
import 'dart:convert';
import 'package:share/share.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rrptflutter/screens/HomeScreen.dart';
import 'package:rrptflutter/screens/FavouriteScreen.dart';
import 'package:rrptflutter/utils/SigninWithGoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        elevation: 5.0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
//            UserAccountsDrawerHeader(
//                accountName: Text('$name'),
//                accountEmail: Text('$email'),
//                currentAccountPicture:
//                    CircleAvatar(backgroundImage: NetworkImage(imageUrl))),
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
                Navigator.pushNamed(context, "/favourite");
              },
            ),
            ListTile(
              title: Text("Notification"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.notifications),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/notification");
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
              leading: Icon(Icons.info),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/about");
              },
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_right),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.of(context).pop();
                signOutGoogle();
                //  Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }), ModalRoute.withName('/login'));
              },
            )
          ],
        ),
      ),
      body: HomeScreen(),
    );
  }
}
