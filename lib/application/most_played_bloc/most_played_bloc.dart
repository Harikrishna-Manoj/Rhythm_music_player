// ignore_for_file: depend_on_referenced_packages

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rythm1/infrastructure/database_functions/db_function.dart';
import '../../domain/models/most_played_song_model.dart';

part 'most_played_event.dart';
part 'most_played_state.dart';

class MostPlayedBloc extends Bloc<MostPlayedEvent, MostPlayedState> {
  MostPlayedBloc()
      : super(const MostPlayedInitial(mostAudio: [], mostPlayedSongs: [])) {
    on<GetAllMostPlayedSongs>((event, emit) {
      List<MostPlayedSongModel> mostPSongs = mostDatabase.values.toList();
      List<MostPlayedSongModel> mostPlayedSongs = [];

      List<Audio> mostAudios = [];
      int i = 0;
      for (var most in mostPSongs) {
        if (most.count > 3) {
          mostPlayedSongs.insert(i, most);
          i++;
        }
      }
      for (var item in mostPlayedSongs) {
        mostAudios.add(Audio.file(item.songurl,
            metas: Metas(
                title: item.songName,
                artist: item.artist,
                id: item.id.toString())));
      }
      emit(DisplayMostPlayedSongs(
          mostPlayedSongs: mostPlayedSongs, mostAudio: mostAudios));
    });
    on<AddToMostPlayed>((event, emit) {
      final mostBox = MostPlayedSongBox.getInstance();
      List<MostPlayedSongModel> mostList = mostBox.values.toList();
      bool isNot = mostList
          .where((element) => element.songName == event.mostPlayedSong.songName)
          .isEmpty;
      if (isNot == true) {
        mostBox.add(event.mostPlayedSong);
      } else {
        int index = mostList.indexWhere(
            (element) => element.songName == event.mostPlayedSong.songName);
        mostBox.deleteAt(index);
        mostBox.put(index, event.mostPlayedSong);
      }
      int count = event.mostPlayedSong.count;
      event.mostPlayedSong.count = count + 1;
      add(GetAllMostPlayedSongs());
    });
  }
}
