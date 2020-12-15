import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:rrptflutter/models/UserPdfModel.dart';
import 'package:rrptflutter/repo/FavouriteScreenRepo.dart';
import 'package:rrptflutter/constants/StringConstants.dart';

part 'favouritescreen_event.dart';

part 'favouritescreen_state.dart';

class FavouriteScreenBloc
    extends Bloc<FavouriteScreenEvent, FavouriteScreenState> {
  FavouriteScreenBloc() : super(FavouriteScreenInitState());
  FavouriteScreenRepo _favouriteScreenRepo = FavouriteScreenRepo();

  @override
  Stream<FavouriteScreenState> mapEventToState(
      FavouriteScreenEvent event) async* {
    if (event is FetchUserPdfData) {
      Response response;

      yield FavouriteScreenLoadingState();
      try {
        response = await _favouriteScreenRepo.GetAllUserPdf(email: event.email);

        // Map<String, dynamic> jsonMap = json.decode(response.body);
        if (response != null) {
          if (response.statusCode.isBetween(200, 299)) {
            List<UserPdfModel> pdfs(String str) => List<UserPdfModel>.from(
                json.decode(str).map((x) => UserPdfModel.fromJson(x)));
            yield FavouriteScreenLoadedState(
                pdfs: pdfs(response.body).toList());
          } else if (response.statusCode.isBetween(400, 599)) {
            if (response.statusCode == 401) {
              yield FavouriteScreenErrorState(
                  errorMsg: StringConstants.SOMETHING_WENT_WRONG);
            }
          }
        }
      } on TimeoutException {
        yield FavouriteScreenErrorState(
            errorMsg: StringConstants.TIMEOUT_OCCURRED);
      } on SocketException {
        yield FavouriteScreenErrorState(errorMsg: StringConstants.NO_INTERNET);
      } on Exception {
        yield FavouriteScreenErrorState(
            errorMsg: StringConstants.SOMETHING_WENT_WRONG);
      }
    } else if (event is RemovePdfToFav) {
      Response response;
      try {
        response = await _favouriteScreenRepo.DelPdfToUserFav(ubid: event.ubid);
        // Map<String, dynamic> jsonMap = json.decode(response.body);
        if (response != null) {
          if (response.statusCode.isBetween(200, 299)) {
            yield FavouriteScreenMsgState(msg: jsonDecode(response.body));
          } else if (response.statusCode.isBetween(400, 599)) {
            if (response.statusCode == 401) {
              yield FavouriteScreenErrorState(
                  errorMsg: StringConstants.SOMETHING_WENT_WRONG);
            }
          }
        }
      } on TimeoutException {
        yield FavouriteScreenErrorState(
            errorMsg: StringConstants.TIMEOUT_OCCURRED);
      } on SocketException {
        yield FavouriteScreenErrorState(errorMsg: StringConstants.NO_INTERNET);
      } on Exception {
        yield FavouriteScreenErrorState(
            errorMsg: StringConstants.SOMETHING_WENT_WRONG);
      }
    }
  }

  @override
  void onTransition(
      Transition<FavouriteScreenEvent, FavouriteScreenState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
