part of 'homescreen_bloc.dart';

abstract class HomeScreenState extends Equatable {}

class HomeScreenLoadingState extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HomeScreenInitState extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HomeScreenErrorState extends HomeScreenState {
  final String errorMsg;

  HomeScreenErrorState({@required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];


  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;

}

class HomeScreenLoadedState extends HomeScreenState {
  final List<PdfModel> pdfs;

  HomeScreenLoadedState({@required this.pdfs});

  @override
  List<Object> get props => [];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;
}

class HomeScreenMsgState extends HomeScreenState {
  final String msg;

  HomeScreenMsgState({this.msg});

  @override
  List<Object> get props => [msg];

  @override
  bool operator ==(Object other) => false;

  @override
  int get hashCode => super.hashCode;

}
