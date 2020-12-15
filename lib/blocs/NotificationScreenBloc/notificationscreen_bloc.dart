import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rrptflutter/constants/StringConstants.dart';
import 'package:rrptflutter/models/NotificationModel.dart';
import 'package:rrptflutter/repo/NotificationScreenRepo.dart';

part 'notificationscreen_event.dart';

part 'notificationscreen_state.dart';

class NotificationScreenBloc
    extends Bloc<NotificationScreenEvent, NotificationScreenState> {
  NotificationScreenBloc() : super(NotificationScreenInitState());
  NotificationScreenRepo _notificationScreenRepo = NotificationScreenRepo();

  @override
  Stream<NotificationScreenState> mapEventToState(
      NotificationScreenEvent event) async* {
    if (event is FetchNotificationData) {
      Response response;

      yield NotificationScreenLoadingState();
      try {
        response = await _notificationScreenRepo.GetNotification();
        // Map<String, dynamic> jsonMap = json.decode(response.body);
        if (response != null) {
          if (response.statusCode.isBetween(200, 299)) {
            List<NotificationModel> pdfs(String str) =>
                List<NotificationModel>.from(
                    json.decode(str).map((x) => NotificationModel.fromJson(x)));
            yield NotificationScreenLoadedState(
                noti: pdfs(response.body).toList());
          } else if (response.statusCode.isBetween(400, 599)) {
            if (response.statusCode == 401) {
              yield NotificationScreenErrorState(
                  errorMsg: StringConstants.SOMETHING_WENT_WRONG);
            }
          }
        }
      } on TimeoutException {
        yield NotificationScreenErrorState(
            errorMsg: StringConstants.TIMEOUT_OCCURRED);
      } on SocketException {
        yield NotificationScreenErrorState(
            errorMsg: StringConstants.NO_INTERNET);
      } on Exception {
        yield NotificationScreenErrorState(
            errorMsg: StringConstants.SOMETHING_WENT_WRONG);
      }
    }
  }

  @override
  void onTransition(
      Transition<NotificationScreenEvent, NotificationScreenState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
