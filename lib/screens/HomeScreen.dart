import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/model/bookdata.dart';
import 'dart:convert';
import 'package:rrptflutter/utils/UrlData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rrptflutter/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var baseurl;
  var pdfurl;
  var sharedEmail;
  double _height, _width, _blockOfHeight, _blockOfWidth;

//  var sharedName;
//  var sharedImgUrl;
  InterstitialAd myInterstitial;
  BannerAd myBanner;
  var ii = UrlData();
  var bottomPadding = 60.0;

  //get book related data from server
  Future<List<BookData>> _getBookData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedEmail = preferences.getString('email') ?? null;
//    sharedName = preferences.getString('name') ?? null;
//    sharedImgUrl = preferences.getString('imageurl') ?? null;
    print("shared email1 $sharedEmail");

    try {
      var url = ii.getPdfData;
      baseurl = UrlData.baseUrlOfServer;
      print(url);
      var responce = await http.get(url);

      if (200 == responce.statusCode) {
        print("url found");
        print(responce.body);
        //    var data = json.decode(result.body);
        //    print(data);
        List<BookData> list = bookDataFromJson(responce.body).toList();
        print(list.length);
        return list;
      } else {
        print("data error");
        return List<BookData>();
      }
    } catch (e) {
      print(e.message);
      return List<BookData>();
    }
  }

  Future<void> _getData() async {
    setState(() {
      //  _getBookData();
      Fluttertoast.showToast(msg: "Loading...");
    });
  }

  BannerAd createBannerAd() {
    return BannerAd(
      //  adUnitId: "ca-app-pub-3308779248747640/1105235590", //id
      adUnitId: ii.checkPlatefromForBannerAd(), //test id
      size: AdSize.banner, //size=60.0
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          setState(() {
            bottomPadding = 0.0;
          });
        }
        print("BannerAd event is $event");
      },
    );
  }

  //add book to user favourite
  Future _addbook(String bid) async {
    // var i = UrlData();
    var url = ii.addPdfToUser;
    print(url);
    print(sharedEmail);
    print(bid);
    var data = {'email': sharedEmail, 'bid': bid};
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
  void initState() {
    super.initState();
    //UrlData i = UrlData();
    FirebaseAdMob.instance.initialize(appId: ii.myAppIdForAds);
    myInterstitial = ii.createInterstitialAd()
      ..load()
      ..show();
    myBanner = createBannerAd()
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
//    _getBookData();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.button;
    _height = _height ?? MediaQuery.of(context).size.height;
    _width = _width ?? MediaQuery.of(context).size.width;
    _blockOfHeight = _height / 100;
    _blockOfWidth = _width / 100;

    return Container(
      height: _height,
      width: _width,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
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
                    size: 60.0,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: FadeInImage(
                                  height: 60.0,
                                  width: 85.0,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(baseurl +
                                      snapshot.data[index].bookImageUrl),
                                  placeholder: AssetImage(
                                    "assets/loading1.gif",
                                  ),
                                )),
                            title: Text(
                              snapshot.data[index].bookTitle,
                              style: textStyle,
                            ),
                            subtitle: Text(snapshot.data[index].bookLang),
                            trailing: GestureDetector(
                              child: Icon(
                                Icons.add,
                                size: 31.0,
                              ),
                              onTap: () {
                                debugPrint("add button");
                                _addbook(snapshot.data[index].bookId);
                              },
                            ),
                            onTap: () {
                              _pdfurldata(
                                  "$baseurl" + snapshot.data[index].bookPdfUrl);
                            },
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    myInterstitial.dispose();
    myBanner.dispose();
  }
}
