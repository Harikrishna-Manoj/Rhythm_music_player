// ignore_for_file: depend_on_referenced_packages

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  PlayBloc() : super(PlayState(true, shuffle: false, loop: false)) {
    final player = AssetsAudioPlayer.withId('0');

    on<ShuffleSongs>((event, emit) {
      if (event.shuffle == false) {
        player.toggleShuffle();
        emit(PlayState(state.pauseorplay, shuffle: true, loop: state.loop));
      } else {
        player.toggleShuffle();
        emit(PlayState(state.pauseorplay, shuffle: false, loop: state.loop));
      }
    });
    on<LoopSongs>((event, emit) {
      if (event.loop == false) {
        emit(PlayState(state.pauseorplay, shuffle: state.shuffle, loop: true));
      } else if (event.loop == true) {
        emit(PlayState(state.pauseorplay, shuffle: state.shuffle, loop: false));
      }
    });
  }
}
