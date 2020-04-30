import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/constants/SigninWithGoogle.dart';
import 'package:rrptflutter/constants/UrlData.dart';
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

  //get userbook related data from server
  Future<List<UserBookData>> _getUserBookData() async {
    var i = UrlData();
    var url = i.GET_PDF_DATA;
    baseurl = UrlData.BASE_URL;
    print(url);
    var result = await http.get(url);
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.button;

    return Scaffold(
        appBar: AppBar(
          title: Text("Favourite books"),
        ),
        body: Container(
            child: FutureBuilder(
          future: _getUserBookData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //    print(snapshot.data.toString());
            if (snapshot.data == null) {
              return Container(
                child: Center(
                    child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 40.0,
                )),
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
                              debugPrint("delete");
                            },
                          ),
                          onTap: () {
                            _pdfurldata(
                                "$baseurl" + snapshot.data[index].book_pdf_url);
                          },
                        ),
                      ),
                    );
                  });
            }
          },
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
