import 'package:flutter/material.dart';
import 'package:rythm1/database/database_functions/db_function.dart';
import 'package:rythm1/database/models/favourit_song_model.dart';
import 'package:rythm1/database/models/song_model.dart';
import 'package:rythm1/rentering_items/common_widgets/common.dart';
import '../../../rentering_items/screens/music_list_screen/music_list_page.dart';

addFavourites(
    int id, BuildContext context, Color colors, Color textColor) async {
  List<SongsModel> dbSongs = songsbox.values.toList();
  List<FavouritSongModel> favouriteSongs = favouritDatabase.values.toList();
  bool isPresent = favouriteSongs.any((element) => element.id == id);
  if (!isPresent) {
    SongsModel song = dbSongs.firstWhere((element) => element.id == id);
    favouritDatabase.add(FavouritSongModel(
        songName: song.songName,
        artist: song.artist,
        duration: song.duration,
        songUrl: song.songurl,
        id: song.id));
    showSnackBar(
        context: context,
        message: 'Added to Favourites',
        colors: colors,
        textColor: textColor);
  } else {
    int currentindex = favouriteSongs.indexWhere((element) => element.id == id);
    await favouritDatabase.deleteAt(currentindex);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).clearSnackBars();
    // ignore: use_build_context_synchronously
    showSnackBar(
        context: context,
        message: 'Removed from Favourites',
        colors: Colors.red,
        textColor: Colors.white);
  }
}

bool checkFavourite(int? songId, buildContext) {
  List<FavouritSongModel> favouritesongs = [];
  List<SongsModel> dbSongs = songsbox.values.toList();
  SongsModel song = dbSongs.firstWhere((element) => element.id == songId);
  FavouritSongModel value = FavouritSongModel(
      songName: song.songName,
      artist: song.artist,
      duration: song.duration,
      songUrl: song.songurl,
      id: song.id);

  favouritesongs = favouritDatabase.values.toList();
  bool isPresent =
      favouritesongs.where((element) => element.id == value.id).isEmpty;
  return isPresent;
}

Future<void> removeFav(int songId, BuildContext context) async {
  final favbox = FavouritBox.getInstance();
  List<FavouritSongModel> favouriteSongs = favbox.values.toList();
  int currentindex =
      favouriteSongs.indexWhere((element) => element.id == songId);
  if (currentindex >= 0) {
    await favouritDatabase.deleteAt(currentindex);
  }
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).clearSnackBars();

  // ignore: use_build_context_synchronously
  showSnackBar(
      context: context,
      message: 'Removed from Favourite',
      colors: Colors.red,
      textColor: Colors.white);
}

deletefav(
    {required int index,
    required BuildContext context,
    required String message,
    required colors,
    required textColor}) async {
  await favouritDatabase.deleteAt(favouritDatabase.length - index - 1);
  // ignore: use_build_context_synchronously
  showSnackBar(
      context: context, message: message, colors: colors, textColor: textColor);
}
