import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/util/UrlData.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<List<BookData>> _getBookData() async {
    var i = UrlData();
    var url = i.GET_PDF_DATA;
    baseurl = UrlData.BASE_URL;
    print(baseurl);
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

  _pdfurldata() async {}

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.button;
    // TODO: implement build
    return Container(
        child: FutureBuilder(
      future: _getBookData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //  print(snapshot.toString());
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text(
                "Loading...",
                style: textStyle,
              ),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                debugPrint(baseurl + snapshot.data[index].book_image_url);
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
                      title: Text(snapshot.data[index].book_title),
                      subtitle: Text(snapshot.data[index].book_lang),
                      trailing: GestureDetector(child: Icon(Icons.add)
                      ,onTap: (){
                        debugPrint("ok");
                        },),
                      onTap: () {
                        //pdfurldata("$baseurl"+snapshot.data[index].book_pdf_url);
                      },
                    ),
                  ),
                );
              });
        }
      },
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
