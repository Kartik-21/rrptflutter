import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/constants/StringConstants.dart';

class HomeScreenReop {
  Future<http.Response> GetAllUserPdf({String email}) async {
    http.Response response;

    response = await http.post(Uri.encodeFull(StringConstants.getUserPdfData),
        body: jsonEncode({"email": email}),
        headers: {
          "Content-Type": "application/json"
        }).timeout(StringConstants.TIMEOUT_DURATION);
    // debugPrint(response.toString());
    return response;
  }

  Future<http.Response> DelPdfToUserFav({String ubid}) async {
    http.Response response;
    var data = {'ubid': ubid};

    response = await http.post(Uri.encodeFull(StringConstants.delPdfToUser),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json"
        }).timeout(StringConstants.TIMEOUT_DURATION);
    return response;
  }
}
