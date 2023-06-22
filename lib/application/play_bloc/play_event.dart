part of 'play_bloc.dart';

@immutable
abstract class PlayEvent {}

class ShuffleSongs extends PlayEvent {
  final bool shuffle;

  ShuffleSongs(this.shuffle);
}

class PauseOrPlay extends PlayEvent {
  final bool playPause;

  PauseOrPlay(this.playPause);
}

class LoopSongs extends PlayEvent {
  final bool loop;

  LoopSongs(this.loop);
}
