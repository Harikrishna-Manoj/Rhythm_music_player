part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class GetAllFavouriteSongs extends FavouriteEvent {}

class AddOrRemoveFavourite extends FavouriteEvent {
  final int id;
  final BuildContext context;
  final Color colors;
  final Color textColor;

  AddOrRemoveFavourite(
      {required this.id,
      required this.colors,
      required this.textColor,
      required this.context});
}

class RemoveFromFavourite extends FavouriteEvent {
  final int songId;
  final BuildContext context;

  RemoveFromFavourite({required this.songId, required this.context});
}

class RemoveSongFromFavouritePage extends FavouriteEvent {
  final int index;
  final BuildContext context;
  final String message;
  final Color colors;
  final Color textColor;
  RemoveSongFromFavouritePage(
      {required this.index,
      required this.context,
      required this.message,
      required this.colors,
      required this.textColor});
}
