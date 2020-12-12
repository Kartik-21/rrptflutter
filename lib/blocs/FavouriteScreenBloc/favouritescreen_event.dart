part of 'favouritescreen_bloc.dart';

abstract class FavouriteScreenEvent extends Equatable {}

//fetch pdf for home screen
class FetchUserPdfData extends FavouriteScreenEvent {
  final String email;

  FetchUserPdfData({@required this.email});

  @override
  List<Object> get props => [email];
}

class RemovePdfToFav extends FavouriteScreenEvent {
  // var data = {'email': sharedEmail, 'bid': bid};

  final String ubid;

  RemovePdfToFav({@required this.ubid});

  @override
  List<Object> get props => [ubid];
}
