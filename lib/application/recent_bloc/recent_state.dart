part of 'recent_bloc.dart';

@immutable
abstract class RecentState {
  final List<RecentSongModel> recentSongs;
  final List<Audio> recentAudio;
  const RecentState({required this.recentAudio, required this.recentSongs});
}

class RecentInitial extends RecentState {
  const RecentInitial({required super.recentAudio, required super.recentSongs});
}

class DisplayRecentSongs extends RecentState {
  const DisplayRecentSongs(
      {required super.recentAudio, required super.recentSongs});
}
