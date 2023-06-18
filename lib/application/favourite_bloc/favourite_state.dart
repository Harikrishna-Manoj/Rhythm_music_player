part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteState {
  final List<FavouritSongModel> favouriteSongs;
  final List<Audio> favouriteAudio;

  const FavouriteState(
      {required this.favouriteSongs, required this.favouriteAudio});
}

class FavouriteInitial extends FavouriteState {
  const FavouriteInitial(
      {required super.favouriteSongs, required super.favouriteAudio});
}

class DisPlayFavourite extends FavouriteState {
  const DisPlayFavourite(
      {required super.favouriteSongs, required super.favouriteAudio});
}
