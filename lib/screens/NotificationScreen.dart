import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/utils/UrlData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_admob/firebase_admob.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  String baseurl;
  InterstitialAd myInterstitial;
  var ii = UrlData();
  BannerAd myBanner;
  var bottomPadding = 60.0;
  double _height, _width, _blockOfHeight, _blockOfWidth;

  BannerAd createBannerAd() {
    return BannerAd(
      //  adUnitId: "ca-app-pub-3308779248747640/1105235590", //id
      adUnitId: ii.checkPlatefromForBannerAd(), //test id
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
    //   _getNotificationData();
    // UrlData i = UrlData();
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

  //open file link content
  _openfiledata(String ur) async {
    String url = ur;
    if (await canLaunch(url)) {
      Fluttertoast.showToast(msg: "Opening File...");
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could't Open File");
    }
  }

  //get notification related data from server
  Future<List<NotificationData>> _getNotificationData() async {
    // var i1 = UrlData();
    var url = ii.getNotiData;
    baseurl = UrlData.baseUrlOfServer;
    print(url);
    var result = await http.get(url);
    var data = json.decode(result.body);
    List<NotificationData> notis = [];
    for (var i in data) {
      var noti =
          NotificationData(i["noti_id"], i["noti_name"], i["date"], i["a_id"]);
      notis.add(noti);
    }
    print(notis.length);
    return notis;
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
          title: Text("Notification"),
          elevation: 5.0,
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Container(
            child: FutureBuilder(
              future: _getNotificationData(),
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
                            child: Text(
                              snapshot.data[index].noti_name,
                              style: TextStyle(color: Colors.white),
                            ),
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

class NotificationData {
  String noti_id;
  String noti_name;

  NotificationData(this.noti_id, this.noti_name, this.date, this.a_id);

  String date;
  String a_id;
}
