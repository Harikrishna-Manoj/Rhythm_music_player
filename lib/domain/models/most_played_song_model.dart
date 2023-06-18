import 'package:hive_flutter/hive_flutter.dart';
part 'most_played_song_model.g.dart';

@HiveType(typeId: 3)
class MostPlayedSongModel {
  @HiveField(0)
  int id;

  @HiveField(1)
  String songName;

  @HiveField(2)
  String artist;

  @HiveField(3)
  int duration;

  @HiveField(4)
  String songurl;

  @HiveField(5)
  int count;

  MostPlayedSongModel({
    required this.id,
    required this.songName,
    required this.artist,
    required this.duration,
    required this.songurl,
    required this.count,
  });
}

class MostPlayedSongBox {
  static Box<MostPlayedSongModel>? box;
  static Box<MostPlayedSongModel> getInstance() {
    return box ??= Hive.box('MostPlayed');
  }
}
