part of 'recent_bloc.dart';

@immutable
abstract class RecentEvent {}

class GetAllRecentSongs extends RecentEvent {}

class AddToRecent extends RecentEvent {
  final RecentSongModel recentSong;

  AddToRecent({required this.recentSong});
}
