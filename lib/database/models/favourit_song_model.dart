import 'package:hive_flutter/hive_flutter.dart';
part 'favourit_song_model.g.dart';

@HiveType(typeId: 1)
class FavouritSongModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? songName;

  @HiveField(2)
  String? artist;

  @HiveField(3)
  int? duration;

  @HiveField(4)
  String? songUrl;

  FavouritSongModel(
      {required this.id,
      required this.songName,
      required this.artist,
      required this.duration,
      required this.songUrl});
}

class FavouritBox {
  static Box<FavouritSongModel>? _box;
  static Box<FavouritSongModel> getInstance() {
    return _box ??= Hive.box('favouritsongs');
  }
}
