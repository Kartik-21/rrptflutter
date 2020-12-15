import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:rrptflutter/blocs/NotificationScreenBloc/notificationscreen_bloc.dart';
import 'package:rrptflutter/models/NotificationModel.dart';
import 'package:rrptflutter/constants/StringConstants.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:rrptflutter/screens/widgets/LoadingWidget.dart';
import 'package:rrptflutter/screens/widgets/MyErrorWidget.dart';
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
  var ii = StringConstants();
  BannerAd myBanner;
  var bottomPadding = 60.0;
  double _height, _width, _blockOfHeight, _blockOfWidth;

  List<NotificationModel> list;

  NotificationScreenBloc _notificationScreenBloc;

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

  @override
  void initState() {
    super.initState();

    _notificationScreenBloc = BlocProvider.of<NotificationScreenBloc>(context);
    _notificationScreenBloc.add(FetchNotificationData());
    //   _getNotificationData();
    // FirebaseAdMob.instance.initialize(appId: ii.myAppIdForAds);
    // myInterstitial = ii.createInterstitialAd()
    //   ..load()
    //   ..show();
    // myBanner = createBannerAd()
    //   ..load()
    //   ..show(
    //     anchorType: AnchorType.bottom,
    //   );
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
          body: BlocConsumer<NotificationScreenBloc, NotificationScreenState>(
            listener: (context, state) {
              if (state is NotificationScreenMsgState) {
                Fluttertoast.showToast(msg: state.msg);
              }
            },
            builder: (context, state) {
              if (state is NotificationScreenInitState) {
                return LoadingWidget();
              } else if (state is NotificationScreenLoadingState) {
                return LoadingWidget();
              } else if (state is NotificationScreenLoadedState) {
                list = state.noti;
                return _notiWidget(context, state.noti);
              } else if (state is NotificationScreenErrorState) {
                return MyErrorWidget(state.errorMsg);
              } else if (state is NotificationScreenMsgState) {
                return _notiWidget(context, list);
              }
              return null;
            },
          )),
    );
  }

  Widget _notiWidget(BuildContext context, List<NotificationModel> model) {
    return Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
            child: ListView.builder(
                reverse: true,
                itemCount: model.length,
                itemBuilder: (BuildContext context, int index) {
                  return ChatBubble(
                    clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 20),
                    backGroundColor: Theme.of(context).accentColor,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Text(
                        model[index].notiName,
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
                })));
  }

  @override
  void dispose() {
    super.dispose();
    // myInterstitial.dispose();
    // myBanner.dispose();
  }
}
