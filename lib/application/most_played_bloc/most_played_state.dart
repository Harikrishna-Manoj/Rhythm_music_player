part of 'most_played_bloc.dart';

@immutable
abstract class MostPlayedState {
  final List<MostPlayedSongModel> mostPlayedSongs;
  final List<Audio> mostAudio;

  const MostPlayedState(
      {required this.mostPlayedSongs, required this.mostAudio});
}

class MostPlayedInitial extends MostPlayedState {
  const MostPlayedInitial(
      {required super.mostPlayedSongs, required super.mostAudio});
}

class DisplayMostPlayedSongs extends MostPlayedState {
  const DisplayMostPlayedSongs(
      {required super.mostPlayedSongs, required super.mostAudio});
}
