// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/models/most_played_song_model.dart';
import '../../domain/models/playlist_song_model.dart';
import '../../domain/models/song_model.dart';
import '../../presentation/common_widgets/common.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(const PlaylistInitial(playList: [])) {
    on<GetAllPlaylist>((event, emit) {
      final playListDb = PlayListSongBox.getInstance();
      List<PlaylistSongModel> playLists = playListDb.values.toList();
      emit(DisplayPlaylist(playList: playLists));
    });

    on<CreatePlaylist>((event, emit) {
      final playBox = PlayListSongBox.getInstance();
      List<SongsModel> playSongs = [];
      playBox.add(PlaylistSongModel(
          playlistName: event.playlistName, playlistSongs: playSongs));
      add(GetAllPlaylist());
    });
    on<EditPlayList>((event, emit) {
      final playBox = PlayListSongBox.getInstance();
      List<PlaylistSongModel> playSongs = playBox.values.toList();
      playBox.putAt(
          event.index,
          PlaylistSongModel(
              playlistName: event.name,
              playlistSongs: playSongs[event.index].playlistSongs));
      add(GetAllPlaylist());
    });
    on<AddToPlaylist>((event, emit) {
      final songBox = SongBox.getInstance();
      final playBox = PlayListSongBox.getInstance();
      List<PlaylistSongModel> playDbSongs = playBox.values.toList();

      PlaylistSongModel? playSongs = playBox.getAt(event.index);
      List<dynamic> playListDb = playSongs!.playlistSongs!;
      List<SongsModel> songdb = songBox.values.toList();

      playListDb.add(SongsModel(
          id: songdb[event.songIndex].id,
          songName: songdb[event.songIndex].songName,
          artist: songdb[event.songIndex].artist,
          duration: songdb[event.songIndex].duration,
          songurl: songdb[event.songIndex].songurl));

      playBox.putAt(
          event.index,
          PlaylistSongModel(
              playlistName: playDbSongs[event.index].playlistName,
              playlistSongs: playListDb));
      Navigator.pop(event.context);
      showSnackBar(
          context: event.context,
          message: 'Song added',
          colors: const Color(0xFF879AFB),
          textColor: Colors.white);
      add(GetAllPlaylist());
    });
    on<SearchToPlaylist>((event, emit) {
      final playBox = PlayListSongBox.getInstance();
      List<PlaylistSongModel> playDbSongs = playBox.values.toList();

      PlaylistSongModel? playSongs = playBox.getAt(event.index);
      List<dynamic> playListDb = playSongs!.playlistSongs!;

      playListDb.add(SongsModel(
          id: event.serchSongList[event.songIndex].id,
          songName: event.serchSongList[event.songIndex].songName,
          artist: event.serchSongList[event.songIndex].artist,
          duration: event.serchSongList[event.songIndex].duration,
          songurl: event.serchSongList[event.songIndex].songurl));

      playBox.putAt(
          event.index,
          PlaylistSongModel(
              playlistName: playDbSongs[event.index].playlistName,
              playlistSongs: playListDb));
      Navigator.pop(event.context);
      showSnackBar(
          context: event.context,
          message: 'Song added',
          colors: const Color(0xFF879AFB),
          textColor: Colors.white);
      add(GetAllPlaylist());
    });
    on<MostAddToPlaylist>((event, emit) {
      final playBox = PlayListSongBox.getInstance();
      List<PlaylistSongModel> playDbSongs = playBox.values.toList();

      PlaylistSongModel? playSongs = playBox.getAt(event.index);
      List playListDb = playSongs!.playlistSongs!;
      bool isallReadyAdded = playListDb.any(
          (element) => element.id == event.listedMostSongs[event.songIndex].id);

      if (!isallReadyAdded) {
        playListDb.add(SongsModel(
          id: event.listedMostSongs[event.songIndex].id,
          songName: event.listedMostSongs[event.songIndex].songName,
          artist: event.listedMostSongs[event.songIndex].artist,
          duration: event.listedMostSongs[event.songIndex].duration,
          songurl: event.listedMostSongs[event.songIndex].songurl,
        ));
      }
      playBox.putAt(
          event.index,
          PlaylistSongModel(
              playlistName: playDbSongs[event.index].playlistName,
              playlistSongs: playListDb));
      Navigator.pop(event.context);
      showSnackBar(
          context: event.context,
          message: 'Song added',
          colors: const Color(0xFF879AFB),
          textColor: Colors.white);
      add(GetAllPlaylist());
    });
    on<CurrentPlayingAddtoPlaylist>((event, emit) {
      final playBox = PlayListSongBox.getInstance();
      final songBox = SongBox.getInstance();
      List<SongsModel> allSongs = songBox.values.toList();
      PlaylistSongModel? selectedPlaylist = playBox.getAt(event.playlistIndex);
      List<dynamic> playDbSongs = selectedPlaylist!.playlistSongs!;
      SongsModel selectedSong =
          allSongs.firstWhere((element) => element.id == event.songId);
      playDbSongs.add(SongsModel(
          id: selectedSong.id,
          songName: selectedSong.songName,
          artist: selectedSong.artist,
          duration: selectedSong.duration,
          songurl: selectedSong.songurl));
      playBox.putAt(
          event.playlistIndex,
          PlaylistSongModel(
              playlistName: selectedPlaylist.playlistName,
              playlistSongs: playDbSongs));
      showSnackBar(
          context: event.context,
          message: 'Song Added',
          colors: const Color(0xFF879AFB),
          textColor: Colors.white);
      add(GetAllPlaylist());
    });
    on<DeletePlaylist>((event, emit) {
      final playBox = PlayListSongBox.getInstance();
      playBox.deleteAt(event.index);
      add(GetAllPlaylist());
    });
    on<DeletePlaylistSong>((event, emit) {
      event.playsongs.removeAt(event.index);
      event.playName.removeAt(event.playIndex);
      add(GetAllPlaylist());
    });
  }
}
