import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io' show Platform;

class StringConstants {
  //static final String BASE_URL = "http://192.168.42.81/rrptflutteradmin/rrptflutter/";
//  static final String BASE_URL =
//      "http://192.168.43.24/rrptflutteradmin/rrptflutter/";
  static final String baseUrlOfServer =
      "http://rrptbooks.atwebpages.com/rrptflutteradmin/rrptflutter/";
  final String getPdfData = baseUrlOfServer + "getpdfdata.php";
  final String getNotiData = baseUrlOfServer + "getnotidata.php";
  final String sentLoginData = baseUrlOfServer + "sentlogindata.php";
  final String getUserPdfData = baseUrlOfServer + "getuserpdfdata.php";
  final String addPdfToUser = baseUrlOfServer + "addpdftouser.php";
  final String delPdfToUser = baseUrlOfServer + "delpdftouser.php";

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
