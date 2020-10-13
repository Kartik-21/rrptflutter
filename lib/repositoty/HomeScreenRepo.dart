import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/model/bookdata.dart';
import 'package:rrptflutter/utils/UrlConstants.dart';

class HomeScreenRepo {
  static HomeScreenRepo _singleton;

  HomeScreenRepo._internal();

  static HomeScreenRepo getInstance() {
    if (_singleton == null) {
      return _singleton = HomeScreenRepo._internal();
    } else {
      return _singleton;
    }
  }

  //get all pdf from server
  Future<List<BookData>> getAllPdf() async {
    try {
      print(UrlConstants.getPdfData);
      var responce = await http.get(UrlConstants.getPdfData);

      if (200 == responce.statusCode) {
        print("url found");
        print(responce.body);
        //    var data = json.decode(result.body);
        //    print(data);
        List<BookData> list = bookDataFromJson(responce.body).toList();
        print(list.length);
        return list;
      } else {
        print("data error");
        return List<BookData>();
      }
    } catch (e) {
      print(e.message);
      return List<BookData>();
    }
  }


  // add favourite book you list
  Future<String> addFavouriteBook({String email, String bid}) async {
    try {
      print(UrlConstants.addPdfToUser);
      // print(sharedEmail);
      // print(bid);
      var data = {'email': email, 'bid': bid};
      var result =
          await http.post(UrlConstants.addPdfToUser, body: json.encode(data));
      var msg = json.decode(result.body);
      print(msg);
      //   Fluttertoast.showToast(msg: msg);
      return msg;
    } catch (e) {
      print(e.message);
      return "";
    }
  }
}
