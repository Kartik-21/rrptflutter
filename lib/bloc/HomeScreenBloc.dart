import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:rrptflutter/model/bookdata.dart';
import 'package:rrptflutter/repositoty/HomeScreenRepo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenBloc {
  HomeScreenRepo _homeScreenRepository = HomeScreenRepo.getInstance();

  BehaviorSubject<List<BookData>> _fetchSubject =
      BehaviorSubject<List<BookData>>();

  Stream<List<BookData>> get getPdf => _fetchSubject.stream;

  GetAllPdf() async {
    List<BookData> users = await _homeScreenRepository.getAllPdf();
    _fetchSubject.sink.add(users);
  }

  AddFav({String email, String bid}) async {
    var responce =
        await _homeScreenRepository.addFavouriteBook(email: email, bid: bid);
    Fluttertoast.showToast(msg: responce);
  }

  openfiledata(String ur) async {
    String url = ur;
    if (await canLaunch(url)) {
      Fluttertoast.showToast(msg: "Opening File...");
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could't Open File");
    }
  }

  dispose() {
    _fetchSubject?.close();
  }
}

final homebloc = HomeScreenBloc();
