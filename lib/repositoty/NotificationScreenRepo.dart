import 'package:rrptflutter/model/notificationdata.dart';
import 'package:rrptflutter/utils/UrlConstants.dart';
import 'package:http/http.dart' as http;

class NotificationScreenRepo {
  static NotificationScreenRepo _singelton;

  NotificationScreenRepo._internal();

  static NotificationScreenRepo getInstance() {
    if (_singelton == null) {
      return _singelton = NotificationScreenRepo._internal();
    } else {
      return _singelton;
    }
  }

  //get all notification from server
  Future<List<NotificationData>> getNotificationData() async {
    try {
      print(UrlConstants.getNotificationData);
      var responce = await http.get(UrlConstants.getNotificationData);

      if (200 == responce.statusCode) {
        print("url found");
        print(responce.body);
        //    var data = json.decode(result.body);
        //    print(data);
        List<NotificationData> list =
            notificationDataFromJson(responce.body).toList();
        print(list.length);
        return list;
      } else {
        print("data error");
        return List<NotificationData>();
      }
    } catch (e) {
      print(e.message);
      return List<NotificationData>();
    }
  }
}
