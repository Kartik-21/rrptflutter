import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:rrptflutter/screens/LoginScreen.dart';
import 'package:share/share.dart';
import 'package:rrptflutter/screens/drawer_screen/HomeScreen.dart';
import 'package:rrptflutter/screens/services/SigninWithGoogle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rrptflutter/generated/l10n.dart';

class DrawerHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawerHomeScreenState();
  }
}

class _DrawerHomeScreenState extends State<DrawerHomeScreen> {
  var sharedEmail;
  var sharedName;
  var sharedImgUrl;
  double _height, _width, _blockOfHeight, _blockOfWidth;

  @override
  void initState() {
    super.initState();
  }

  Future _getAccountData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedEmail = preferences.getString('email') ?? "";
    sharedName = preferences.getString('name') ?? "";
    sharedImgUrl = preferences.getString('imageurl') ?? "";
    return preferences;
  }

  @override
  Widget build(BuildContext context) {
    _height = _height ?? MediaQuery.of(context).size.height;
    _width = _width ?? MediaQuery.of(context).size.width;
    _blockOfHeight = _height / 100;
    _blockOfWidth = _width / 100;

    return Container(
        height: _height,
        width: _width,
        child: FutureBuilder(
            future: _getAccountData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.toString());
                return Scaffold(
                  appBar: AppBar(
                    title: Text(S.of(context).homePage),
                    elevation: 5.0,
//                    actions: <Widget>[
//                      PopupMenuButton(
//                        icon: Icon(Icons.more_vert),
//                        itemBuilder: (context) {
//                          PopupMenuItem(
//                              value: 1,
//                              child: FlatButton(
//                                child: Text("Exit"),
//                                onPressed: () {
//                                  Fluttertoast.showToast(msg: "Exit");
//                                  dispose();
//                                },
//                              ));
//                        },
//                      ),
//                    ],
                  ),
                  drawer: Drawer(
                    child: ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                            accountName: Text(sharedEmail),
                            accountEmail: Text(sharedName),
                            currentAccountPicture: CircleAvatar(
                                backgroundImage: NetworkImage(sharedImgUrl))),
                        ListTile(
                          title: Text(S.of(context).homePage),
                          trailing: Icon(Icons.arrow_right),
                          leading: Icon(Icons.home),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text(S.of(context).favourite),
                          trailing: Icon(Icons.arrow_right),
                          leading: Icon(Icons.favorite),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "/favourite");
                          },
                        ),
                        ListTile(
                          title: Text(S.of(context).notification),
                          trailing: Icon(Icons.arrow_right),
                          leading: Icon(Icons.notifications),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "/notification");
                          },
                        ),
                        ListTile(
                          title: Text(S.of(context).share),
                          trailing: Icon(Icons.arrow_right),
                          leading: Icon(Icons.share),
                          onTap: () {
                            Navigator.of(context).pop();
                            Share.share(
                                'check out my application https://example.com');
                          },
                        ),
                        ListTile(
                          title: Text(S.of(context).rateUs),
                          trailing: Icon(Icons.arrow_right),
                          leading: Icon(Icons.rate_review),
                          onTap: () {
                            Navigator.of(context).pop();
//                            Share.share(
//                                'check out my application https://example.com');
                            Fluttertoast.showToast(msg: "rate us");
                          },
                        ),
                        ListTile(
                          title: Text(S.of(context).about),
                          trailing: Icon(Icons.arrow_right),
                          leading: Icon(Icons.info),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "/about");
                          },
                        ),
                        ListTile(
                          title: Text(S.of(context).logout),
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

  @override
  void dispose() {
    super.dispose();
  }
}
