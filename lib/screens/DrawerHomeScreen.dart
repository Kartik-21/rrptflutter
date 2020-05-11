import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  var email1;
  var name1;
  var imgurl1;

  Future _getAccountData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email1 = preferences.getString('email') ?? "";
    name1 = preferences.getString('name') ?? "";
    imgurl1 = preferences.getString('imageurl') ?? "";
    return preferences;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: FutureBuilder(
            future: _getAccountData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.toString());
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Home"),
                    elevation: 5.0,
                  ),
                  drawer: Drawer(
                    child: ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                            accountName: Text(name1),
                            accountEmail: Text(email1),
                            currentAccountPicture: CircleAvatar(
                                backgroundImage: NetworkImage(imgurl1))),
                        ListTile(
                          title: Text("Home Page"),
                          trailing: Icon(Icons.arrow_right),
                          leading: Icon(Icons.home),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text("Favourite"),
                          trailing: Icon(Icons.arrow_right),
                          leading: Icon(Icons.favorite),
                          onTap: () {
                            Navigator.of(context).pop();
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
                            Share.share(
                                'check out my application https://example.com');
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
                          onTap: () async {
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
              } else {
                return SpinKitFadingCircle(
                  size: 50.0,
                  color: Colors.white,
                );
              }
            }));
  }
}
