part of 'favouritescreen_bloc.dart';

abstract class FavouriteScreenState extends Equatable {}

class FavouriteScreenLoadingState extends FavouriteScreenState {
  @override
  List<Object> get props => [];
}

class FavouriteScreenInitState extends FavouriteScreenState {
  @override
  List<Object> get props => [];
}

class FavouriteScreenErrorState extends FavouriteScreenState {
  final String errorMsg;

  FavouriteScreenErrorState({@required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}

class FavouriteScreenLoadedState extends FavouriteScreenState {
  final List<UserPdfModel> pdfs;

  FavouriteScreenLoadedState({@required this.pdfs});

  @override
  List<Object> get props => [];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}

class FavouriteScreenMsgState extends FavouriteScreenState {
  final String msg;

  FavouriteScreenMsgState({this.msg});

  @override
  List<Object> get props => [msg];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}
