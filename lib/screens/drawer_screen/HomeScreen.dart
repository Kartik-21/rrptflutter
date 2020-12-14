import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/blocs/HomeScreenBloc/homescreen_bloc.dart';
import 'package:rrptflutter/models/PdfModel.dart';
import 'package:rrptflutter/models/bookdata.dart';
import 'dart:convert';
import 'package:rrptflutter/constants/StringConstants.dart';
import 'package:rrptflutter/screens/widgets/LoadingWidget.dart';
import 'package:rrptflutter/screens/widgets/MyErrorWidget.dart';
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

  List<PdfModel> list = [];

  HomeScreenBloc homeScreenBloc;

//  var sharedName;
//  var sharedImgUrl;
  InterstitialAd myInterstitial;
  BannerAd myBanner;
  var ii = StringConstants();
  var bottomPadding = 60.0;
  SharedPreferences preferences;

  Future<void> _getSharedData() async {
    preferences = await SharedPreferences.getInstance();
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
    _getSharedData();
    homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
    // homeScreenBloc.add(FetchPdfData(email: sharedEmail));

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

  @override
  Widget build(BuildContext context) {
    _height ??= MediaQuery
        .of(context)
        .size
        .height;
    _width ??= MediaQuery
        .of(context)
        .size
        .width;
    _blockOfHeight ??= _height / 100;
    _blockOfWidth ??= _width / 100;
    print("sh $sharedEmail");
    homeScreenBloc.add(FetchPdfData(email: sharedEmail));

    return Container(
      height: _height,
      width: _width,
      child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
          if (state is HomeScreenMsgState) {
            Fluttertoast.showToast(msg: state.msg);
          }
        },
        builder: (context, state) {
          if (state is HomeScreenInitState) {
            return LoadingWidget();
          } else if (state is HomeScreenLoadingState) {
            return LoadingWidget();
          } else if (state is HomeScreenLoadedState) {
            list = state.pdfs;
            return _homeWidget(context, state.pdfs);
          } else if (state is HomeScreenErrorState) {
            return MyErrorWidget(state.errorMsg);
          } else if (state is HomeScreenMsgState) {
            return _homeWidget(context, list);
          }
          return null;
        },
      ),
    );
  }

  Widget _homeWidget(BuildContext context, List<PdfModel> model) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .button;
    baseurl = StringConstants.baseUrlOfServer;

    return Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: RefreshIndicator(
              onRefresh: _getData,
              child: ListView.builder(
                  itemCount: model.length,
                  itemBuilder: (BuildContext context, int index) {
                    //debugPrint(baseurl + snapshot.data[index].book_image_url);
                    return Card(
                      elevation: 4.0,
                      //  margin: EdgeInsets.all(10.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.0),
                        child: ListTile(
                          leading: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  5)),
                              child:
                              // FadeInImage(
                              //   height: 60.0,
                              //   width: 85.0,
                              //   fit: BoxFit.cover,
                              //   image: NetworkImage(
                              //       baseurl + model[index].bookImageUrl),
                              //   placeholder: AssetImage(
                              //     "assets/loading1.gif",
                              //   ),
                              // )
                              Image.network(
                                "https://drive.google.com/file/d/1ACFVY6l-wQkip0oJ93wufBEdJzk-XEUB/view?usp=sharing",
                                height: 60.0,
                                width: 85.0,
                                fit: BoxFit.cover,
                              )),
                          title: Text(
                            model[index].bookTitle,
                            style: textStyle,
                          ),
                          subtitle: Text(model[index].bookLang),
                          trailing: GestureDetector(
                            child: Icon(
                              Icons.add,
                              size: 31.0,
                            ),
                            onTap: () {
                              homeScreenBloc.add(AddPdfToFav(
                                  email: sharedEmail,
                                  bid: model[index].bookId));
                            },
                          ),
                          onTap: () {
                            _pdfurldata("$baseurl" + model[index].bookPdfUrl);
                          },
                        ),
                      ),
                    );
                  })),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    // myInterstitial.dispose();
    // myBanner.dispose();
  }
}
