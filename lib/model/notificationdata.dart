// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

List<NotificationData> notificationDataFromJson(String str) =>
    List<NotificationData>.from(
        json.decode(str).map((x) => NotificationData.fromJson(x)));

String notificationDataToJson(List<NotificationData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationData {
  NotificationData({
    this.notiId,
    this.notiName,
    this.date,
    this.aId,
  });

  String notiId;
  String notiName;
  DateTime date;
  String aId;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        notiId: json["noti_id"],
        notiName: json["noti_name"],
        date: DateTime.parse(json["date"]),
        aId: json["a_id"],
      );

  Map<String, dynamic> toJson() => {
        "noti_id": notiId,
        "noti_name": notiName,
        "date": date.toIso8601String(),
        "a_id": aId,
      };
}
