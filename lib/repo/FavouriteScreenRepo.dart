import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/constants/StringConstants.dart';

class FavouriteScreenRepo {
  Future<http.Response> GetAllUserPdf({String email}) async {
    http.Response response;
    print("repo $email");
    response = await http.post(Uri.encodeFull(StringConstants.getUserPdfData),
        body: jsonEncode({"email": email}),
        headers: {
          "Content-Type": "application/json"
        }).timeout(StringConstants.TIMEOUT_DURATION);
    // debugPrint(response.body);
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