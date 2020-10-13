import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/bloc/NotificationScreenBloc.dart';
import 'package:rrptflutter/model/notificationdata.dart';
import 'dart:convert';
import 'package:rrptflutter/utils/UrlConstants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rrptflutter/generated/l10n.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  String baseurl;
  InterstitialAd myInterstitial;
  var ii = UrlConstants();
  BannerAd myBanner;
  var bottomPadding = 60.0;
  double _height, _width, _blockOfHeight, _blockOfWidth;

  BannerAd createBannerAd() {
    return BannerAd(
      //  adUnitId: "ca-app-pub-3308779248747640/1105235590", //id
      adUnitId: UrlConstants.checkPlatefromForBannerAd(), //test id
      size: AdSize.banner, //size=60.0
      // targetingInfo: targetingInfo,
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

//
//  Future<void> _getData() async {
//    setState(() {
//      // _getNotificationData();
//      Fluttertoast.showToast(msg: "Loading...");
//    });
//  }

  @override
  void initState() {
    super.initState();
    notibloc.GetAllNoti();

    // UrlData i = UrlData();
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
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    _height = _height ?? MediaQuery.of(context).size.height;
    _width = _width ?? MediaQuery.of(context).size.width;
    _blockOfHeight = _height / 100;
    _blockOfWidth = _width / 100;

    return Container(
      height: _height,
      width: _width,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).notification),
          elevation: 5.0,
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Container(
            child: StreamBuilder<List<NotificationData>>(
              stream: notibloc.getNoti,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //        print(snapshot.data.toString());
                if (snapshot.data == null) {
                  return Center(
                      child: Container(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 60.0,
                    ),
                  ));
                } else {
                  return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatBubble(
                          clipper:
                              ChatBubbleClipper4(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: Theme.of(context).accentColor,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Linkify(
                              text: snapshot.data[index].notiName,
                              onOpen: (link) {
                                print('${link.url}');
                                notibloc.openfiledata('${link.url}');
                              },
                              style: textStyle,
                            ),

                            // Text(
                            //   snapshot.data[index].notiName,
                            //   style: TextStyle(color: Colors.white),
                            // ),
                          ),
                        );
                        //   Card(
                        //   elevation: 4.0,
                        //   //  margin: EdgeInsets.all(10.0),
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(vertical: 5.0),
                        //     child: ListTile(
                        //       title: Linkify(
                        //         text: snapshot.data[index].noti_name,
                        //         onOpen: (link) {
                        //           print('${link.url}');
                        //           _openfiledata('${link.url}');
                        //         },
                        //         style: textStyle,
                        //       ),
                        //     ),
                        //   ),
                        // );
                      });
                }
              },
            ),
          ),
        ),
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
