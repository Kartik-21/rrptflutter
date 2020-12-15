part of 'notificationscreen_bloc.dart';

abstract class NotificationScreenState extends Equatable {}

class NotificationScreenLoadingState extends NotificationScreenState {
  @override
  List<Object> get props => [];
}

class NotificationScreenInitState extends NotificationScreenState {
  @override
  List<Object> get props => [];
}

class NotificationScreenErrorState extends NotificationScreenState {
  final String errorMsg;

  NotificationScreenErrorState({@required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}

class NotificationScreenLoadedState extends NotificationScreenState {
  final List<NotificationModel> noti;

  NotificationScreenLoadedState({@required this.noti});

  @override
  List<Object> get props => [];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}

class NotificationScreenMsgState extends NotificationScreenState {
  final String msg;

  NotificationScreenMsgState({this.msg});

  @override
  List<Object> get props => [msg];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}
