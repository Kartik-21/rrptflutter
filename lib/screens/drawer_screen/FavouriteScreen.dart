import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:rrptflutter/blocs/FavouriteScreenBloc/favouritescreen_bloc.dart';
import 'package:rrptflutter/models/UserPdfModel.dart';
import 'package:rrptflutter/constants/StringConstants.dart';
import 'package:rrptflutter/screens/widgets/LoadingWidget.dart';
import 'package:rrptflutter/screens/widgets/MyErrorWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:rrptflutter/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavouriteScreenState();
  }
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  var baseurl;
  var sharedEmail;
  var ii = StringConstants();
  var bottomPadding = 60.0;
  double _height, _width, _blockOfHeight, _blockOfWidth;
  List<UserPdfModel> list = [];

  FavouriteScreenBloc _favouriteScreenBloc;

  //  var sharedEmail;
//  var sharedImgUrl;
  InterstitialAd myInterstitial;
  BannerAd myBanner;
  SharedPreferences preferences;

  Future<void> _getSharedData() async {
    preferences = await SharedPreferences.getInstance();
    sharedEmail = preferences.getString('email') ?? null;
//    name1 = preferences.getString('name') ?? null;
//    imgurl1 = preferences.getString('imageurl') ?? null;
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

  @override
  void initState() {
    super.initState();
    _getSharedData();
    _favouriteScreenBloc = BlocProvider.of<FavouriteScreenBloc>(context);
    // _favouriteScreenBloc.add(FetchUserPdfData(email: sharedEmail));
    //UrlData i = UrlData();
    // FirebaseAdMob.instance.initialize(appId: ii.myAppIdForAds);
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
    TextStyle textStyle = Theme.of(context).textTheme.button;
    _height = _height ?? MediaQuery.of(context).size.height;
    _width = _width ?? MediaQuery.of(context).size.width;
    _blockOfHeight = _height / 100;
    _blockOfWidth = _width / 100;
    _getSharedData();
    _favouriteScreenBloc.add(FetchUserPdfData(email: sharedEmail));

    return Container(
      width: _width,
      height: _height,
      child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).favourite),
            elevation: 5.0,
          ),
          body: BlocConsumer<FavouriteScreenBloc, FavouriteScreenState>(
            listener: (context, state) {
              if (state is FavouriteScreenMsgState) {
                Fluttertoast.showToast(msg: state.msg);
              }
            },
            builder: (context, state) {
              if (state is FavouriteScreenInitState) {
                return LoadingWidget();
              } else if (state is FavouriteScreenLoadingState) {
                return LoadingWidget();
              } else if (state is FavouriteScreenLoadedState) {
                list = state.pdfs;
                return _favWidget(context, state.pdfs);
              } else if (state is FavouriteScreenErrorState) {
                return MyErrorWidget(state.errorMsg);
              } else if (state is FavouriteScreenMsgState) {
                return _favWidget(context, list);
              }
              return null;
            },
          )),
    );
  }

  Widget _favWidget(BuildContext context, List<UserPdfModel> model) {
    TextStyle textStyle = Theme.of(context).textTheme.button;
    baseurl = StringConstants.baseUrlOfServer;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
          child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 4.0,
                  //  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child:
                              // FadeInImage(
                              //   height: 60.0,
                              //   width: 85.0,
                              //   fit: BoxFit.cover,
                              //   image:
                              //   NetworkImage(
                              //       // baseurl +
                              //       // snapshot.data[index].bookImageUrl
                              //   "https://drive.google.com/file/d/11NbbI8R9bIWm2WeiFiCnglfBlRKvzBVr/view?usp=sharing"
                              //   ),
                              //   placeholder:
                              //       AssetImage("assets/loading.gif"),
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
                      //   subtitle: Text(snapshot.data[index].book_lang),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () {
                          _favouriteScreenBloc.add(
                              RemovePdfToFav(ubid: model[index].userBookId));
                          setState(() {});
                        },
                      ),
                      onTap: () {
                        _pdfurldata(baseurl + model[index].bookPdfUrl);
                      },
                    ),
                  ),
                );
              })),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // myInterstitial.dispose();
    // myBanner.dispose();
  }
}
