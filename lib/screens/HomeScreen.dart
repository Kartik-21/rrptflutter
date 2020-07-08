import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/utils/UrlData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';

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
  var email1;

  BannerAd myBanner;

  InterstitialAd myInterstitial;

  BannerAd createBannerAd() {
    return BannerAd(
      //  adUnitId: "ca-app-pub-3308779248747640/1105235590", //id
      adUnitId: "ca-app-pub-3940256099942544/6300978111", //test id
      size: AdSize.banner,
      // targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      // adUnitId: "ca-app-pub-3308779248747640/2651726336",  //id
      adUnitId: "ca-app-pub-3940256099942544/8691691433", //test id
      // targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    myBanner.dispose();
    myInterstitial.dispose();
  }

//  var name1;
//  var imgurl1;

  //get book related data from server
  Future<List<BookData>> _getBookData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email1 = preferences.getString('email') ?? null;
//    name1 = preferences.getString('name') ?? null;
//    imgurl1 = preferences.getString('imageurl') ?? null;
    print("shared email1 $email1");

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
      //  _getBookData();
      Fluttertoast.showToast(msg: "Loading...");
    });
  }

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3308779248747640~6075966022");
    myBanner = createBannerAd()
      ..load()
      ..show();
    _getBookData();
  }

  //add book to user favourite
  Future _addbook(String bid) async {
    var i = UrlData();
    var url = i.ADD_PDF_TO_USER;
    print(url);
    print(email1);
    print(bid);
    var data = {'email': email1, 'bid': bid};
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
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .button;
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
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      )),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      //debugPrint(baseurl + snapshot.data[index].book_image_url);
                      return Card(
                        elevation: 4.0,
                        //  margin: EdgeInsets.all(10.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.0),
                          child: ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                                child: FadeInImage(
                                  height: 60.0,
                                  width: 85.0,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(baseurl +
                                      snapshot.data[index].book_image_url),
                                  placeholder: AssetImage("assets/loading.png"),
                                )
//                            Image.network(
//                              baseurl + snapshot.data[index].book_image_url,
//                              height: 60.0,
//                              width: 85.0,
//                              fit: BoxFit.cover,
//                            )
                            ),
                            title: Text(
                              snapshot.data[index].book_title,
                              style: textStyle,
                            ),
                            subtitle: Text(snapshot.data[index].book_lang),
                            trailing: GestureDetector(
                              child: Icon(
                                Icons.add,
                                size: 31.0,
                              ),
                              onTap: () {
                                debugPrint("add button");
                                _addbook(snapshot.data[index].book_id);
                              },
                            ),
                            onTap: () {
                              myInterstitial = createInterstitialAd()
                                ..load()
                                ..show();
                              _pdfurldata(
                                  "$baseurl" +
                                      snapshot.data[index].book_pdf_url);
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

  BookData(this.book_id,
      this.book_title,
      this.book_image_url,
      this.book_pdf_url,
      this.book_lang,
      this.book_page,
      this.book_year,
      this.book_author,
      this.book_date,
      this.a_id);

  BookData.allpdf(this.book_id,
      this.book_title,
      this.book_image_url,
      this.book_pdf_url,
      this.book_lang,
      this.book_page,
      this.book_year,
      this.book_author);
}
