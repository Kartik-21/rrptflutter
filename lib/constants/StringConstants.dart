import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io' show Platform;

class StringConstants {
  //static final String BASE_URL = "http://192.168.42.81/rrptflutteradmin/rrptflutter/";
//  static final String BASE_URL =
//      "http://192.168.43.24/rrptflutteradmin/rrptflutter/";
  static final String baseUrlOfServer =
      "http://rrptbooks.atwebpages.com/rrptflutteradmin/rrptflutter/";
  static final String getPdfData = baseUrlOfServer + "getpdfdata.php";
  static final String getNotiData = baseUrlOfServer + "getnotidata.php";
  static final String sentLoginData = baseUrlOfServer + "sentlogindata.php";
  static final String getUserPdfData = baseUrlOfServer + "getuserpdfdata.php";
  static final String addPdfToUser = baseUrlOfServer + "addpdftouser.php";
  static final String delPdfToUser = baseUrlOfServer + "delpdftouser.php";

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

  static const TIMEOUT_DURATION = Duration(seconds: 20);

  static const String SOMETHING_WENT_WRONG =
      "Something went wrong, please try again";
  static const String SERVER_COULD_NOT_REACHED =
      "Server couldn't reached, please check your internet connection";
  static const String REQUEST_TIMED_OUT = "Request timed out";
  static const String NO_INTERNET =
      "Server couldn't reached, please check your internet connection";
  static const String TIMEOUT_OCCURRED = "Request timed out";
  static const String SUCCESSFULLY_UPDATED_THE_DATA =
      "Data updated successfully";
  static const String ERROR_WHILE_FETCHING_DATA = "Error while fetching data";
  static const String SUCCESS = "Success";
  static const String LOCATION_ALREADY_SELECTED = "Location already selected";
  static const String SESSION_EXPIRED =
      "Session has expired, please login again";
}

extension IntExtension on int {
  bool isBetween(int lowerValue, int upperValue) {
    return (this >= lowerValue && this <= upperValue);
  }
}
