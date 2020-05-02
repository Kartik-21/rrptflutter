import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/utils/SigninWithGoogle.dart';
import 'package:rrptflutter/utils/UrlData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FavouriteScreenState();
  }
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  var baseurl;

  Future<void> _getData() async {
    setState(() {
      _getUserBookData();
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserBookData();
  }

  //get userbook related data from server
  Future<List<UserBookData>> _getUserBookData() async {
    var i = UrlData();
    var url = i.GET_USER_PDF_DATA;
    baseurl = UrlData.BASE_URL;
    print(url);
    var data1 = {'email': email};
    var result = await http.post(url, body: json.encode(data1));
    var data = json.decode(result.body);
    List<UserBookData> books = [];
    for (var i in data) {
      var book = UserBookData(
        i["user_book_id"],
        i["book_title"],
        i["book_image_url"],
        i["book_pdf_url"],
      );
      books.add(book);
    }
    print(books.length);
    return books;
  }

  //open a pdf file
  _pdfurldata(String ur) async {
    String url = ur;
    if (await canLaunch(url)) {
      Fluttertoast.showToast(msg: "Opening File...");
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could't Open File");
    }
  }

  //delete book to user favourite
  Future _delbook(String ubid) async {
    var i = UrlData();
    // var base = UrlData.BASE_URL;
    var url = i.DEL_PDF_TO_USER;
    var data = {'ubid': ubid};
    var result = await http.post(url, body: json.encode(data));
    var msg = json.decode(result.body);
    print(msg);
    Fluttertoast.showToast(msg: msg);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.button;

    return Scaffold(
        appBar: AppBar(
          title: Text("Favourite book"),
        ),
        body: Container(
            child: RefreshIndicator(
          onRefresh: _getData,

          child: FutureBuilder(
            future: _getUserBookData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //  print(snapshot.data.toString());
              if (snapshot.data == null) {
                return Container(
                  height: 0.0,
                  width: 0.0,
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      //debugPrint(baseurl + snapshot.data[index].book_image_url);
                      return Card(
                        //  margin: EdgeInsets.all(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.0),
                          child: ListTile(
                            leading: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: Image.network(
                                  baseurl + snapshot.data[index].book_image_url,
                                  height: 60.0,
                                  width: 85.0,
                                  fit: BoxFit.cover,
                                )),
                            title: Text(
                              snapshot.data[index].book_title,
                              style: textStyle,
                            ),
                            //   subtitle: Text(snapshot.data[index].book_lang),
                            trailing: GestureDetector(
                              child: Icon(Icons.delete),
                              onTap: () {
                                setState(() {
                                  debugPrint("delete button");
                                  _delbook(snapshot.data[index].user_book_id);
                                  _getUserBookData();
                                });
                              },
                            ),
                            onTap: () {
                              _pdfurldata("$baseurl" +
                                  snapshot.data[index].book_pdf_url);
                            },
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        )));
  }
}

class UserBookData {
  String user_book_id;
  String book_title;
  String book_image_url;
  String book_pdf_url;

  UserBookData(this.user_book_id, this.book_title, this.book_image_url,
      this.book_pdf_url);
}
