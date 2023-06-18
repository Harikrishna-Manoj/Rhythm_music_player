import 'package:hive_flutter/hive_flutter.dart';
part 'playlist_song_model.g.dart';

@HiveType(typeId: 4)
class PlaylistSongModel {
  @HiveField(0)
  String? playlistName;
  @HiveField(1)
  List? playlistSongs;
  PlaylistSongModel({required this.playlistName, required this.playlistSongs});
}

class PlayListSongBox {
  static Box<PlaylistSongModel>? box;
  static Box<PlaylistSongModel> getInstance() {
    return box ??= Hive.box('playlist');
  }
}
