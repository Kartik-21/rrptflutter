import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rrptflutter/utils/UrlData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;

  if (user != null) {
    await _sentLoginData(user);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("imageurl", imageUrl);
  }

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

Future _sentLoginData(FirebaseUser user) async {
  var i = UrlData();
  var url = i.sentLoginData;
  print(url);
  print(user);
  print(user.email);
  var data = {'name': user.displayName, 'email': user.email};
  var result = await http.post(url, body: json.encode(data));
  var msg = json.decode(result.body);
  print("login $msg");
//  Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
}
