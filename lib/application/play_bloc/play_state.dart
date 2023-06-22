part of 'play_bloc.dart';

class PlayState {
  final bool shuffle;
  final bool? pauseorplay;
  final bool loop;

  PlayState(this.pauseorplay, {required this.shuffle, required this.loop});
}
