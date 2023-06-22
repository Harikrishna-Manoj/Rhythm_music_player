part of 'most_played_bloc.dart';

@immutable
abstract class MostPlayedEvent {}

class GetAllMostPlayedSongs extends MostPlayedEvent {}

class AddToMostPlayed extends MostPlayedEvent {
  final MostPlayedSongModel mostPlayedSong;

  AddToMostPlayed({required this.mostPlayedSong});
}
