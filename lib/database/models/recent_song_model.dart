import 'package:hive_flutter/hive_flutter.dart';
part 'recent_song_model.g.dart';

@HiveType(typeId: 2)
class RecentSongModel {
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
  @HiveField(5)
  int? index;
  RecentSongModel(
      {required this.id,
      this.songName,
      this.artist,
      this.duration,
      this.songUrl,
      required this.index});
}

class RecentBox {
  static Box<RecentSongModel>? _box;
  static Box<RecentSongModel> getInstance() {
    return _box ??= Hive.box('recentsong');
  }
}
