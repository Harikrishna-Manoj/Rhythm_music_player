import 'package:hive/hive.dart';
part 'song_model.g.dart';

@HiveType(typeId: 0)
class SongsModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? songName;

  @HiveField(2)
  String? artist;

  @HiveField(3)
  int? duration;

  @HiveField(4)
  String? songurl;

  SongsModel({
    required this.id,
    required this.songName,
    required this.artist,
    required this.duration,
    required this.songurl,
  });
}

class SongBox {
  static Box<SongsModel>? _box;
  static Box<SongsModel> getInstance() {
    return _box ??= Hive.box('AllSongs');
  }
}
