import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/model/userbookdata.dart';
import 'package:rrptflutter/utils/UrlConstants.dart';

class FavouriteScreenRepo {
  static FavouriteScreenRepo _singleton;

  FavouriteScreenRepo._internal();

  static FavouriteScreenRepo getInstance() {
    if (_singleton == null) {
      return _singleton = FavouriteScreenRepo._internal();
    } else {
      return _singleton;
    }
  }

  Future<List<UserBookData>> getUserPdf({String email}) async {
    try {
      var data1 = {'email': email};
      print("repo $email");
      var responce = await http.post(UrlConstants.getUserPdfData,
          body: json.encode(data1));

      if (200 == responce.statusCode) {
        print("url found");
        print(responce.body);
        //    var data = json.decode(result.body);
        //    print(data);
        List<UserBookData> list = userBookDataFromJson(responce.body).toList();
        print(list.length);
        return list;
      } else {
        print("data error");
        return List<UserBookData>();
      }
    } catch (e) {
      print(e);
      return List<UserBookData>();
    }
  }

  //delete book to user favourite
  Future delbook({String ubid}) async {
    //var i = UrlData();
    var url = UrlConstants.delPdfToUser;
    var data = {'ubid': ubid};
    var result = await http.post(url, body: json.encode(data));
    var msg = json.decode(result.body);
    print(msg);
    return msg;
    // Fluttertoast.showToast(msg: msg);
  }
}
