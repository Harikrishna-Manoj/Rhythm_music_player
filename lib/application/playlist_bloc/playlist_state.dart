part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistState {
  final List<PlaylistSongModel> playList;
  const PlaylistState({required this.playList});
}

class PlaylistInitial extends PlaylistState {
  const PlaylistInitial({required super.playList});
}

class DisplayPlaylist extends PlaylistState {
  const DisplayPlaylist({required super.playList});
}
