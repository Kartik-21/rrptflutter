import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rrptflutter/constants/StringConstants.dart';

class NotificationScreenRepo {
  Future<http.Response> GetNotification() async {
    http.Response response;

    response = await http.post(Uri.encodeFull(StringConstants.getNotiData),
        headers: {
          "Content-Type": "application/json"
        }).timeout(StringConstants.TIMEOUT_DURATION);
    return response;
  }
}
