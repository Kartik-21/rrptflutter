import 'package:fluttertoast/fluttertoast.dart';
import 'package:rrptflutter/model/userbookdata.dart';
import 'package:rrptflutter/repositoty/FavouriteScreenRepo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class FavouriteScreenBloc {
  FavouriteScreenRepo _favouriteScreenRepo = FavouriteScreenRepo.getInstance();

  PublishSubject<List<UserBookData>> _userbooksubject =
      PublishSubject<List<UserBookData>>();

  Stream<List<UserBookData>> get userPdf => _userbooksubject.stream;

  GetUserBook(String email) async {
    print("bloc $email");
    List<UserBookData> responce =
        await _favouriteScreenRepo.getUserPdf(email: email);
    _userbooksubject.sink.add(responce);
  }

  openfile(String ur) async {
    String url = ur;
    print(url);
    if (await canLaunch(url)) {
      Fluttertoast.showToast(msg: "Opening File...");
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could't Open File");
    }
  }

  DelUserBook({String ubid}) async {
    var result = await _favouriteScreenRepo.delbook(ubid: ubid);
    Fluttertoast.showToast(msg: result);
  }

  dispose() {
    _userbooksubject?.close();
  }
}

final favbloc = FavouriteScreenBloc();
