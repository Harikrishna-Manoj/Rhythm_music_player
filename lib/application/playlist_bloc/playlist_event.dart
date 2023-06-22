part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class GetAllPlaylist extends PlaylistEvent {}

class CreatePlaylist extends PlaylistEvent {
  final String playlistName;

  CreatePlaylist({required this.playlistName});
}

class EditPlayList extends PlaylistEvent {
  final int index;
  final String name;

  EditPlayList({required this.index, required this.name});
}

class AddToPlaylist extends PlaylistEvent {
  final int songIndex;
  final int index;
  final BuildContext context;

  AddToPlaylist(
      {required this.songIndex, required this.index, required this.context});
}

class SearchToPlaylist extends PlaylistEvent {
  final int songIndex;
  final int index;
  final BuildContext context;
  final List<SongsModel> serchSongList;

  SearchToPlaylist(
      {required this.songIndex,
      required this.index,
      required this.context,
      required this.serchSongList});
}

class MostAddToPlaylist extends PlaylistEvent {
  final int songIndex;
  final int index;
  final BuildContext context;
  final List<MostPlayedSongModel> listedMostSongs;

  MostAddToPlaylist(
      {required this.songIndex,
      required this.index,
      required this.context,
      required this.listedMostSongs});
}

class CurrentPlayingAddtoPlaylist extends PlaylistEvent {
  final int songId;
  final int playlistIndex;
  final BuildContext context;
  CurrentPlayingAddtoPlaylist(
      {required this.songId,
      required this.context,
      required this.playlistIndex});
}

class DeletePlaylist extends PlaylistEvent {
  final int index;

  DeletePlaylist({required this.index});
}

class DeletePlaylistSong extends PlaylistEvent {
  final int index;
  final int playIndex;
  final List<PlaylistSongModel> playName;
  final List<dynamic> playsongs;

  DeletePlaylistSong(
      {required this.index,
      required this.playIndex,
      required this.playName,
      required this.playsongs});
}
