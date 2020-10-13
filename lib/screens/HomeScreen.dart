import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rrptflutter/bloc/HomeScreenBloc.dart';
import 'package:rrptflutter/model/bookdata.dart';
import 'package:rrptflutter/utils/UrlConstants.dart';
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
  var ii = UrlConstants();
  var bottomPadding = 60.0;

  //get book related data from server
  Future<void> _sharedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    sharedEmail = preferences.getString('email') ?? null;
//    sharedName = preferences.getString('name') ?? null;
//    sharedImgUrl = preferences.getString('imageurl') ?? null;
    print("shared email1 $sharedEmail");
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

  @override
  void initState() {
    super.initState();
    //UrlData i = UrlData();
    homebloc.GetAllPdf();
    _sharedData();
    // FirebaseAdMob.instance.initialize(appId: UrlConstants.myAppIdForAds);
    // myInterstitial = ii.createInterstitialAd()
    //   ..load()
    //   ..show();
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

    return Container(
      height: _height,
      width: _width,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
            child: RefreshIndicator(
          onRefresh: _getData,
          // child: FutureBuilder(
          //   future: _getBookData(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          child: StreamBuilder<List<BookData>>(
            stream: homebloc.getPdf,
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
                                  image: NetworkImage(UrlConstants
                                          .baseUrlOfServer + //in server only path of the image ex- /images/xyz.png
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
                                //      _addbook(snapshot.data[index].bookId);
                                homebloc.AddFav(
                                    bid: snapshot.data[index].bookId,
                                    email: sharedEmail);
                                // Map<String, dynamic> map =
                                //     Map<String, dynamic>();
                                // map['email'] = "$sharedEmail";
                                // map['bid'] = snapshot.data[index].bookId;
                                // //        print(map);
                                // homebloc.addbookid.add(map);
                              },
                            ),
                            onTap: () {
                              homebloc.openfiledata(
                                  UrlConstants.baseUrlOfServer +
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // myInterstitial.dispose();
    // myBanner.dispose();
  }
}
