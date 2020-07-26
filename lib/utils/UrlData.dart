import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io' show Platform;

class UrlData {
  //static final String BASE_URL = "http://192.168.42.81/rrptflutteradmin/rrptflutter/";
//  static final String BASE_URL =
//      "http://192.168.43.24/rrptflutteradmin/rrptflutter/";
  static final String BASE_URL =
      "http://rrptbooks.atwebpages.com/rrptflutteradmin/rrptflutter/";
  final String GET_PDF_DATA = BASE_URL + "getpdfdata.php";
  final String GET_NOTI_DATA = BASE_URL + "getnotidata.php";
  final String SENT_LOGIN_DATA = BASE_URL + "sentlogindata.php";
  final String GET_USER_PDF_DATA = BASE_URL + "getuserpdfdata.php";
  final String ADD_PDF_TO_USER = BASE_URL + "addpdftouser.php";
  final String DEL_PDF_TO_USER = BASE_URL + "delpdftouser.php";

  final String myAppIdForAds = "ca-app-pub-4833612091218866~5375970321"; //appid

  String checkPlatefromForInterstitialAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712"; // test id image
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/8691691433"; //test id video
    }
    return null;
  }

  String checkPlatefromForBannerAd() {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111"; //test id banner
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1033173712"; // test id banner
    }
    return null;
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      // adUnitId: "ca-app-pub-3308779248747640/2651726336",  //id
      adUnitId: checkPlatefromForInterstitialAd(), //test id
      // targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }

//  BannerAd createBannerAd() {
//    return BannerAd(
//      //  adUnitId: "ca-app-pub-3308779248747640/1105235590", //id
//      adUnitId: checkPlatefromForBannerAd(), //test id
//      size: AdSize.fullBanner,  //size=60.0
//      // targetingInfo: targetingInfo,
//      listener: (MobileAdEvent event) {
//        print("BannerAd event is $event");
//      },
//    );
//  }
}
