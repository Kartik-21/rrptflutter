import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rrptflutter/constants/UrlData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  String baseurl;

  //open file link content
  _openfiledata(String ur) async {
    String url = ur;
    if (await canLaunch(url)) {
      Fluttertoast.showToast(msg: "Opening File...");
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could't Open File");
    }
  }

  //get notification related data from server
  Future<List<NotificationData>> _getNotificationData() async {
    var i1 = UrlData();
    var url = i1.GET_NOTI_DATA;
    baseurl = UrlData.BASE_URL;
    print(url);
    var result = await http.get(url);
    var data = json.decode(result.body);

    List<NotificationData> notis = [];

    for (var i in data) {
      var noti =
          NotificationData(i["noti_id"], i["noti_name"], i["date"], i["a_id"]);
      debugPrint(noti.toString());
      notis.add(noti);
    }
    print(notis.length);
    return notis;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
          child: FutureBuilder(
        future: _getNotificationData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // ignore: missing_return
          //        print(snapshot.data.toString());
          if (snapshot.data == null) {
            return Center(
                child: Container(
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: 40.0,
              ),
            ));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    //  margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        title: Linkify(
                          text: snapshot.data[index].noti_name,
                          onOpen: (link) {
                            print('${link.url}');
                            _openfiledata('${link.url}');
                          },
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
