import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rrptflutter/constants/UrlData.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  if (user != null) {
    await _sentLoginData();
  }

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

//  // Only taking the first part of the name, i.e., First Name
//  if (name.contains(" ")) {
//    name = name.substring(0, name.indexOf(" "));
//  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'SignIn Successful';
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  print("Sign Out");
}

Future _sentLoginData() async {
  var i = UrlData();
  var url = i.SENT_LOGIN_DATA;
  print(url);
  var data = {'name': name, 'email': email};
  var result = await http.post(url, body: json.encode(data));
  var msg = json.decode(result.body);
  print(msg);
//  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
}
