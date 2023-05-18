import 'package:rythm1/database/database_functions/db_function.dart';
import 'package:rythm1/database/models/recent_song_model.dart';

addToRecent(RecentSongModel value) {
  List<RecentSongModel> recentList = recentDatabase.values.toList();
  bool isAdd = recentList.where((element) => element.id == value.id).isEmpty;
  if (isAdd == true) {
    recentDatabase.add(value);
  } else {
    int position = recentList.indexWhere((element) => element.id == value.id);
    recentDatabase.deleteAt(position);
    recentDatabase.add(value);
  }
}
