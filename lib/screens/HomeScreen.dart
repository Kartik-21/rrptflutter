import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/utils/SigninWithGoogle.dart';
import 'dart:convert';
import 'package:rrptflutter/utils/UrlData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var baseurl;
  var pdfurl;

  //get book related data from server
  Future<List<BookData>> _getBookData() async {
    var i = UrlData();
    var url = i.GET_PDF_DATA;
    baseurl = UrlData.BASE_URL;
    print(url);
    var result = await http.get(url);
    var data = json.decode(result.body);

    List<BookData> books = [];

    for (var i in data) {
      var book = BookData.allpdf(
          i["book_id"],
          i["book_title"],
          i["book_image_url"],
          i["book_pdf_url"],
          i["book_lang"],
          i["book_page"],
          i["book_year"],
          i["book_author"]);
      books.add(book);
    }
    print(books.length);
    return books;
  }

  Future<void> _getData() async {
    setState(() {
     _getBookData();
    });
  }

  @override
  void initState() {
    super.initState();
    _getBookData();
  }

  //add book to user favourite
  Future _addbook(String bid) async {
    var i = UrlData();
    var base = UrlData.BASE_URL;
    var url = i.ADD_PDF_TO_USER;
    var data = {'email': email, 'bid': bid};
    var result = await http.post(url, body: json.encode(data));
    var msg = json.decode(result.body);
    print(msg);
    Fluttertoast.showToast(msg: msg);
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
    TextStyle textStyle = Theme.of(context).textTheme.button;
    // TODO: implement build
    return Container(
        child: RefreshIndicator(
      onRefresh: _getData,
      child: FutureBuilder(
        future: _getBookData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //    print(snapshot.data.toString());
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child:
//                  SpinKitThreeBounce(
//                color: Colors.white,
//                size: 40.0,
//              )
             CircularProgressIndicator(
               //strokeWidth: 5.0,
             backgroundColor: Colors.white,
             )
              )
              ,
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
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
                        subtitle: Text(snapshot.data[index].book_lang),
                        trailing: GestureDetector(
                          child: Icon(Icons.add),
                          onTap: () {
                            debugPrint("add button");
                            _addbook(snapshot.data[index].book_id);
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
      ),
    ));
  }
}

class BookData {
  String book_id;
  String book_title;
  String book_image_url;
  String book_pdf_url;
  String book_lang;
  String book_page;
  String book_year;
  String book_author;
  String book_date;
  String a_id;

  BookData(
      this.book_id,
      this.book_title,
      this.book_image_url,
      this.book_pdf_url,
      this.book_lang,
      this.book_page,
      this.book_year,
      this.book_author,
      this.book_date,
      this.a_id);

  BookData.allpdf(
      this.book_id,
      this.book_title,
      this.book_image_url,
      this.book_pdf_url,
      this.book_lang,
      this.book_page,
      this.book_year,
      this.book_author);
}
