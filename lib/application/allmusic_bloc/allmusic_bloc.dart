// ignore_for_file: depend_on_referenced_packages

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/models/song_model.dart';

part 'allmusic_event.dart';
part 'allmusic_state.dart';

class AllmusicBloc extends Bloc<AllmusicEvent, AllmusicState> {
  AllmusicBloc()
      : super(const AllmusicInitial(allSongs: [], convertedAudio: [])) {
    on<GetAllSongs>((event, emit) {
      final songDb = SongBox.getInstance();
      List<SongsModel> songsList = songDb.values.toList();
      List<Audio> convertAudios = [];

      for (var dbSongs in songsList) {
        convertAudios.add(
          Audio.file(
            dbSongs.songurl!,
            metas: Metas(
              title: dbSongs.songName,
              artist: dbSongs.artist,
              id: dbSongs.id.toString(),
            ),
          ),
        );
      }
      emit(AllmusicInitial(allSongs: songsList, convertedAudio: convertAudios));
    });
  }
}
