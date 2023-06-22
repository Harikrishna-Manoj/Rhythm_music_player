// ignore_for_file: depend_on_referenced_packages

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/models/recent_song_model.dart';
import '../../infrastructure/database_functions/db_function.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  RecentBloc() : super(const RecentInitial(recentSongs: [], recentAudio: [])) {
    on<GetAllRecentSongs>((event, emit) {
      List<Audio> recentAudios = [];
      final recentBox = RecentBox.getInstance();
      final List<RecentSongModel> recentSongs =
          recentBox.values.toList().reversed.toList();
      for (var recent in recentSongs) {
        recentAudios.add(Audio.file(recent.songUrl.toString(),
            metas: Metas(
                artist: recent.artist,
                title: recent.songName,
                id: recent.id.toString())));
      }
      emit(DisplayRecentSongs(
          recentAudio: recentAudios, recentSongs: recentSongs));
    });
    on<AddToRecent>((event, emit) {
      List<RecentSongModel> recentList = recentDatabase.values.toList();
      bool isAdd = recentList
          .where((element) => element.id == event.recentSong.id)
          .isEmpty;
      if (isAdd == true) {
        recentDatabase.add(event.recentSong);
      } else {
        int position = recentList
            .indexWhere((element) => element.id == event.recentSong.id);
        recentDatabase.deleteAt(position);
        recentDatabase.add(event.recentSong);
      }
      add(GetAllRecentSongs());
    });
  }
}
