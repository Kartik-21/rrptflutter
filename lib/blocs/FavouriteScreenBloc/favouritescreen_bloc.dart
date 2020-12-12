import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:rrptflutter/models/UserPdfModel.dart';

part 'favouritescreen_event.dart';

part 'favouritescreen_state.dart';

class FavouriteScreenBloc
    extends Bloc<FavouriteScreenEvent, FavouriteScreenState> {
  FavouriteScreenBloc() : super(FavouriteScreenInitState());

  @override
  Stream<FavouriteScreenState> mapEventToState(FavouriteScreenEvent event) {
    throw UnimplementedError();
  }
}
