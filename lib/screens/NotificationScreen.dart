import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/util/UrlData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  String baseurl;

  //get book related data from server
  Future<List<NotificationData>> _getNotificationData() async {
    var i = UrlData();
    var url = i.GET_NOTI_DATA;
    baseurl = UrlData.BASE_URL;
    print(url);
    var result = await http.get(url);
    var data = json.decode(result.body);

    List<NotificationData> notis = [];

    for (var i in data) {
      var noti =
          NotificationData(i["noti_id"], i["noti_name"], i["date"], i["a_id"]);
      notis.add(noti);
    }
    print(notis.length);
    //   return notis;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
          child: FutureBuilder(
        future: _getNotificationData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: SpinKitThreeBounce(
                color: Colors.white,
                size: 40.0,
              )),
            );
          } else {
            ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    //  margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0),
                      child: ListTile(
                        title: Text(
                          //snapshot.data[index].book_title,
                          "hello here",
                          style: textStyle,
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      )),
    );
  }
}

class NotificationData {
  String noti_id;
  String noti_name;

  NotificationData(this.noti_id, this.noti_name, this.date, this.a_id);

  String date;
  String a_id;
}
