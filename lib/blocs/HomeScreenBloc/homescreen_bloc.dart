import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rrptflutter/models/PdfModel.dart';
import 'package:rrptflutter/repo/HomeScreenRepo.dart';
import 'package:rrptflutter/constants/StringConstants.dart';

part 'homescreen_event.dart';

part 'homescreen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitState());

  HomeScreenReop _homeScreenReop = HomeScreenReop();

  @override
  void onTransition(Transition<HomeScreenEvent, HomeScreenState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is FetchPdfData) {
      Response response;

      yield HomeScreenLoadingState();
      try {
        response = await _homeScreenReop.GetAllPdf(email: event.email);

        print(response);
        // Map<String, dynamic> jsonMap = json.decode(response.body);
        if (response != null) {
          if (response.statusCode.isBetween(200, 299)) {
            List<PdfModel> pdfs(String str) => List<PdfModel>.from(
                json.decode(str).map((x) => PdfModel.fromJson(x)));
            yield HomeScreenLoadedState(pdfs: pdfs(response.body).toList());
          } else if (response.statusCode.isBetween(400, 599)) {
            if (response.statusCode == 401) {
              yield HomeScreenErrorState(
                  errorMsg: StringConstants.SOMETHING_WENT_WRONG);
            }
          }
        }
      } on TimeoutException {
        yield HomeScreenErrorState(errorMsg: StringConstants.TIMEOUT_OCCURRED);
      } on SocketException {
        yield HomeScreenErrorState(errorMsg: StringConstants.NO_INTERNET);
      } on Exception {
        yield HomeScreenErrorState(
            errorMsg: StringConstants.SOMETHING_WENT_WRONG);
      }
    } else if (event is AddPdfToFav) {
      Response response;
      try {
        response = await _homeScreenReop.AddbookToUserFav(
            email: event.email, bid: event.bid);
        // Map<String, dynamic> jsonMap = json.decode(response.body);
        if (response != null) {
          if (response.statusCode.isBetween(200, 299)) {
            yield HomeScreenMsgState(msg: jsonDecode(response.body));
          } else if (response.statusCode.isBetween(400, 599)) {
            if (response.statusCode == 401) {
              yield HomeScreenMsgState(
                  msg: StringConstants.SOMETHING_WENT_WRONG);
            }
          }
        }
      } on TimeoutException {
        yield HomeScreenMsgState(msg: StringConstants.TIMEOUT_OCCURRED);
      } on SocketException {
        yield HomeScreenMsgState(msg: StringConstants.NO_INTERNET);
      } on Exception {
        yield HomeScreenMsgState(msg: StringConstants.SOMETHING_WENT_WRONG);
      }
    }
  }
}
//
// try {
// List<Articles> art = await articleRepo.getArticles();
// yield ArticleLoadedState(articles: art);
// } catch (e) {
// yield ArticleErrorState(msg: e.toString());
// }
