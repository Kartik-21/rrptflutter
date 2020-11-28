part of 'homescreen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {}

//fetch pdf for home screen
class FetchPdfData extends HomeScreenEvent {
  final String email;

  FetchPdfData({@required this.email});

  @override
  List<Object> get props => [email];
}

class AddPdfToFav extends HomeScreenEvent {
  // var data = {'email': sharedEmail, 'bid': bid};

  final String email, bid;

  AddPdfToFav({@required this.email, @required this.bid});

  @override
  List<Object> get props => [email, bid];
}
