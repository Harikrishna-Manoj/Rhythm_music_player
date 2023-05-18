import 'package:rythm1/database/models/most_played_song_model.dart';

addMostSong(int index, MostPlayedSongModel value) {
  final box = MostPlayedSongBox.getInstance();
  List<MostPlayedSongModel> list = box.values.toList();
  // log('$list');
  bool isNot =
      list.where((element) => element.songName == value.songName).isEmpty;
  if (isNot == true) {
    box.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songName == value.songName);
    box.deleteAt(index);
    box.put(index, value);
  }
  int count = value.count;
  value.count = count + 1;
}
