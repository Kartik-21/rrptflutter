import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/model/userbookdata.dart';
import 'dart:convert';
import 'package:rrptflutter/utils/UrlData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavouriteScreenState();
  }
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  var baseurl;
  var sharedEmail;
  var ii = UrlData();
  var bottomPadding = 60.0;
  double _height, _width, _blockOfHeight, _blockOfWidth;

  //  var sharedEmail;
//  var sharedImgUrl;
  InterstitialAd myInterstitial;
  BannerAd myBanner;

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

  Future<void> _getData() async {
    setState(() {
      //   _getUserBookData();
      Fluttertoast.showToast(msg: "Loading...");
    });
  }

  @override
  void initState() {
    super.initState();
    //   _getUserBookData();
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
  }

  //get userbook related data from server
  Future<List<UserBookData>> _getUserBookData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedEmail = preferences.getString('email') ?? null;
//    name1 = preferences.getString('name') ?? null;
//    imgurl1 = preferences.getString('imageurl') ?? null;

    try {
      var url = ii.getUserPdfData;
      baseurl = UrlData.baseUrlOfServer;
      print(url);
      var data1 = {'email': sharedEmail};
      var responce = await http.post(url, body: json.encode(data1));

      if (200 == responce.statusCode) {
        print("url found");
        print(responce.body);
        //    var data = json.decode(result.body);
        //    print(data);
        List<UserBookData> list = userBookDataFromJson(responce.body).toList();
        print(list.length);
        return list;
      } else {
        print("data error");
        return List<UserBookData>();
      }
    } catch (e) {
      print(e.message);
      return List<UserBookData>();
    }
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
    //var i = UrlData();
    var url = ii.delPdfToUser;
    var data = {'ubid': ubid};
    var result = await http.post(url, body: json.encode(data));
    var msg = json.decode(result.body);
    print(msg);
    Fluttertoast.showToast(msg: msg);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.button;
    _height = _height ?? MediaQuery.of(context).size.height;
    _width = _width ?? MediaQuery.of(context).size.width;
    _blockOfHeight = _height / 100;
    _blockOfWidth = _width / 100;

    return Container(
      width: _width,
      height: _height,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Favourite"),
            elevation: 5.0,
          ),
          body: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Container(
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
                          return Card(
                            elevation: 4.0,
                            //  margin: EdgeInsets.all(10.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
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
                                      placeholder:
                                          AssetImage("assets/loading.gif"),
                                    )),
                                title: Text(
                                  snapshot.data[index].bookTitle,
                                  style: textStyle,
                                ),
                                //   subtitle: Text(snapshot.data[index].book_lang),
                                trailing: GestureDetector(
                                  child: Icon(Icons.delete),
                                  onTap: () {
                                    _delbook(snapshot.data[index].userBookId);
                                    setState(() {
                                      debugPrint("delete button");
                                      // _getUserBookData();
                                    });
                                  },
                                ),
                                onTap: () {
                                  _pdfurldata(baseurl +
                                      snapshot.data[index].bookPdfUrl);
                                },
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            )),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    myInterstitial.dispose();
    myBanner.dispose();
  }
}
