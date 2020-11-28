class NotificationModel {
  String notiId;
  String notiName;
  String date;
  String aId;

  NotificationModel({this.notiId, this.notiName, this.date, this.aId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notiId = json['noti_id'];
    notiName = json['noti_name'];
    date = json['date'];
    aId = json['a_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noti_id'] = this.notiId;
    data['noti_name'] = this.notiName;
    data['date'] = this.date;
    data['a_id'] = this.aId;
    return data;
  }
}
