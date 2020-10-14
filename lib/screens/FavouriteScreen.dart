import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rrptflutter/model/userbookdata.dart';
import 'package:rrptflutter/utils/UrlConstants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:rrptflutter/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rrptflutter/bloc/FavouriteScreenBloc.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavouriteScreenState();
  }
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  // var baseurl;
  var sharedEmail;

  // var ii = UrlConstants();
  var bottomPadding = 60.0;
  double _height, _width, _blockOfHeight, _blockOfWidth;

  //  var sharedEmail;
//  var sharedImgUrl;
  InterstitialAd myInterstitial;
  BannerAd myBanner;

  Future<void> _sharedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedEmail = preferences.getString('email') ?? null;
    favbloc.GetUserBook("$sharedEmail");

    //  baseurl = UrlConstants.baseUrlOfServer;
//    sharedName = preferences.getString('name') ?? null;
//    sharedImgUrl = preferences.getString('imageurl') ?? null;
    print("shared email1 $sharedEmail");
  }

  BannerAd createBannerAd() {
    return BannerAd(
      //  adUnitId: "ca-app-pub-3308779248747640/1105235590", //id
      adUnitId: UrlConstants.checkPlatefromForBannerAd(), //test id
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
    _sharedData();
    //UrlData i = UrlData();
    // FirebaseAdMob.instance.initialize(appId: UrlConstants.myAppIdForAds);
    // myInterstitial = ii.createInterstitialAd()
    //   ..load()
    //   ..show();
    //
    // myBanner = createBannerAd()
    //   ..load()
    //   ..show(
    //     anchorType: AnchorType.bottom,
    //   );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.button;
    _height = _height ?? MediaQuery.of(context).size.height;
    _width = _width ?? MediaQuery.of(context).size.width;
    _blockOfHeight = _height / 100;
    _blockOfWidth = _width / 100;
    // print("now call");
    //  favbloc.GetUserBook("$sharedEmail");
    return Container(
      width: _width,
      height: _height,
      child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).favourite),
            elevation: 5.0,
          ),
          body: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Container(
                child: RefreshIndicator(
              onRefresh: _getData,
              child: StreamBuilder<List<UserBookData>>(
                stream: favbloc.userPdf,
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
                                      image: NetworkImage(
                                          "${UrlConstants.baseUrlOfServer}" +
                                              "${snapshot.data[index].bookImageUrl}"),
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
                                    favbloc.DelUserBook(
                                        ubid: snapshot.data[index].userBookId);
                                    setState(() {
                                      debugPrint("delete button setstate");
                                      favbloc.GetUserBook("$sharedEmail");
                                      // _getUserBookData();
                                    });
                                  },
                                ),
                                onTap: () {
                                  favbloc.openfile(
                                      "${UrlConstants.baseUrlOfServer}" +
                                          "${snapshot.data[index].bookPdfUrl}");
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
    // myInterstitial.dispose();
    // myBanner.dispose();
  }
}
