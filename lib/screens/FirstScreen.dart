import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rrptflutter/screens/DrawerHomeScreen.dart';
import 'package:rrptflutter/screens/LoginScreen.dart';

class FirstScreen extends StatelessWidget {
  double _height, _width, _blockOfHeight, _blockOfWidth;

  @override
  Widget build(BuildContext context) {
    _height = _height ?? MediaQuery.of(context).size.height;
    _width = _width ?? MediaQuery.of(context).size.width;
    _blockOfHeight = _height / 100;
    _blockOfWidth = _width / 100;

    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
//          FirebaseUser user = snapshot.data;
//          var name = user.displayName;
//          var email = user.email;
//          print(email);
//          print(name);
//          Fluttertoast.showToast(msg: name + " " + email);
//          print("main $user");
          return DrawerHomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
