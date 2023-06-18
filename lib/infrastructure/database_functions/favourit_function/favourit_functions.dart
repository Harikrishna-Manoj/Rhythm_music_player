import 'package:rythm1/infrastructure/database_functions/db_function.dart';
import '../../../domain/models/favourit_song_model.dart';
import '../../../domain/models/song_model.dart';

bool checkFavourite(int? songId, buildContext) {
  final songsbox = SongBox.getInstance();
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
