import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/constants/StringConstants.dart';

class HomeScreenRepo {
  Future<http.Response> GetAllPdf({String email}) async {
    http.Response response;

    response = await http.post(Uri.encodeFull(StringConstants.getPdfData),
        body: jsonEncode({"email": email}),
        headers: {
          "Content-Type": "application/json"
        }).timeout(StringConstants.TIMEOUT_DURATION);
    // debugPrint(response.toString());
    return response;
  }

  Future<http.Response> AddbookToUserFav({String bid, String email}) async {
    http.Response response;
    var data = {'email': email, 'bid': bid};

    response = await http.post(Uri.encodeFull(StringConstants.addPdfToUser),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json"
        }).timeout(StringConstants.TIMEOUT_DURATION);
    return response;
  }
}
