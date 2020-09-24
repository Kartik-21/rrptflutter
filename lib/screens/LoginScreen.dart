import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:rrptflutter/utils/SigninWithGoogle.dart';
import 'package:rrptflutter/screens/DrawerHomeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  double _height, _width, _blockOfHeight, _blockOfWidth;

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
          title: Text("Login"),
          elevation: 5.0, centerTitle: true,
          //   centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: Text(
                      "Welcome To",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "RRPT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    child: Text(
                      "Login in to Continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Divider(
                    indent: 40.0,
                    endIndent: 40.0,
                    thickness: 2,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 00.0),
                    child: SignInButton(
                      Buttons.GoogleDark,
                      onPressed: () async {
                        //it is used when any exeption is not then "then" used.."then" not allowed any exeption
                        signInWithGoogle().then((String value) {
                          print(value);
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: value.toString());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DrawerHomeScreen();
                          }));
                        }).catchError((e) {
                          signOutGoogle();
                          Fluttertoast.showToast(
                              msg: "Error in SignIn",
                              toastLength: Toast.LENGTH_LONG);
                        });
                      },
                    ),
                  ),
//                Padding(
//                  padding:
//                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
//                  child: SignInButton(
//                    Buttons.Apple,
//                    onPressed: () {
//                      Fluttertoast.showToast(msg: "It is under Development");
//                    },
//                  ),
//                ),
//                Padding(
//                  padding:
//                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 00.0),
//                  child: SignInButton(
//                    Buttons.Email,
//                    onPressed: () {
//                      Fluttertoast.showToast(msg: "It is under Development");
//                    },
//                  ),
//                ),
                  Divider(
                    indent: 40.0,
                    endIndent: 40.0,
                    thickness: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
