import 'package:fluttertoast/fluttertoast.dart';
import 'package:rrptflutter/model/notificationdata.dart';
import 'package:rrptflutter/repositoty/NotificationScreenRepo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreenBloc {
  NotificationScreenRepo _notificationScreenRepo =
      NotificationScreenRepo.getInstance();

  BehaviorSubject<List<NotificationData>> _fetchSubject =
      BehaviorSubject<List<NotificationData>>();

  Stream<List<NotificationData>> get getNoti => _fetchSubject.stream;

  GetAllNoti() async {
    List<NotificationData> users =
        await _notificationScreenRepo.getNotificationData();
    _fetchSubject.sink.add(users);
  }

  openfiledata(String ur) async {
    String url = ur;
    if (await canLaunch(url)) {
      Fluttertoast.showToast(msg: "Opening File...");
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could't Open File");
    }
  }

  dispose() {
    _fetchSubject?.close();
  }
}

final notibloc = NotificationScreenBloc();
