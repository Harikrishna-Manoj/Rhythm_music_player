import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rythm1/presentation/common_widgets/common.dart';

import '../../../domain/models/most_played_song_model.dart';
import '../../../domain/models/playlist_song_model.dart';
import '../../../domain/models/song_model.dart';

createPlaylist({required String playlistName}) {
  final playBox = PlayListSongBox.getInstance();
  List<SongsModel> playSongs = [];
  playBox.add(
      PlaylistSongModel(playlistName: playlistName, playlistSongs: playSongs));
}

editPlayList({required String name, required int index}) {
  final playBox = PlayListSongBox.getInstance();
  List<PlaylistSongModel> playSongs = playBox.values.toList();
  playBox.putAt(
      index,
      PlaylistSongModel(
          playlistName: name, playlistSongs: playSongs[index].playlistSongs));
}

addToPlaylist(int songIndex, int index, BuildContext context) {
  final songBox = SongBox.getInstance();
  final playBox = PlayListSongBox.getInstance();
  List<PlaylistSongModel> playDbSongs = playBox.values.toList();

  PlaylistSongModel? playSongs = playBox.getAt(index);
  List<dynamic> playListDb = playSongs!.playlistSongs!;
  List<SongsModel> songdb = songBox.values.toList();

  playListDb.add(SongsModel(
      id: songdb[songIndex].id,
      songName: songdb[songIndex].songName,
      artist: songdb[songIndex].artist,
      duration: songdb[songIndex].duration,
      songurl: songdb[songIndex].songurl));

  playBox.putAt(
      index,
      PlaylistSongModel(
          playlistName: playDbSongs[index].playlistName,
          playlistSongs: playListDb));
  Navigator.pop(context);
  showSnackBar(
      context: context,
      message: 'Song added',
      colors: const Color(0xFF879AFB),
      textColor: Colors.white);
}

searchToPlaylist(int songIndex, int index, BuildContext context,
    List<SongsModel> serchSongList) {
  final playBox = PlayListSongBox.getInstance();
  List<PlaylistSongModel> playDbSongs = playBox.values.toList();

  PlaylistSongModel? playSongs = playBox.getAt(index);
  List<dynamic> playListDb = playSongs!.playlistSongs!;

  playListDb.add(SongsModel(
      id: serchSongList[songIndex].id,
      songName: serchSongList[songIndex].songName,
      artist: serchSongList[songIndex].artist,
      duration: serchSongList[songIndex].duration,
      songurl: serchSongList[songIndex].songurl));

  playBox.putAt(
      index,
      PlaylistSongModel(
          playlistName: playDbSongs[index].playlistName,
          playlistSongs: playListDb));
  Navigator.pop(context);
  showSnackBar(
      context: context,
      message: 'Song added',
      colors: const Color(0xFF879AFB),
      textColor: Colors.white);
}

mostAddToPlaylist(
    int songIndex, int index, BuildContext context, listedMostSongs) {
  final playBox = PlayListSongBox.getInstance();
  List<PlaylistSongModel> playDbSongs = playBox.values.toList();

  PlaylistSongModel? playSongs = playBox.getAt(index);
  List playListDb = playSongs!.playlistSongs!;
  bool isallReadyAdded =
      playListDb.any((element) => element.id == listedMostSongs[songIndex].id);

  if (!isallReadyAdded) {
    playListDb.add(SongsModel(
      id: listedMostSongs[songIndex].id,
      songName: listedMostSongs[songIndex].songName,
      artist: listedMostSongs[songIndex].artist,
      duration: listedMostSongs[songIndex].duration,
      songurl: listedMostSongs[songIndex].songurl,
    ));
  }
  // log('added');
  playBox.putAt(
      index,
      PlaylistSongModel(
          playlistName: playDbSongs[index].playlistName,
          playlistSongs: playListDb));
  Navigator.pop(context);
  showSnackBar(
      context: context,
      message: 'Song added',
      colors: const Color(0xFF879AFB),
      textColor: Colors.white);
}

deletePlaylist(int index) {
  final playBox = PlayListSongBox.getInstance();
  playBox.deleteAt(index);
}

bool checkingExistance(String value) {
  final playBox = PlayListSongBox.getInstance();
  List<PlaylistSongModel> playListNames = playBox.values.toList();
  bool isAlreadyExists = playListNames
      .where((element) =>
          element.playlistName?.toLowerCase() == value.trim().toLowerCase())
      .isNotEmpty;
  return isAlreadyExists;
}

checkingSongExistance(int index, int songIndex, BuildContext context) {
  final playBox = PlayListSongBox.getInstance();
  final box = SongBox.getInstance();
  List<SongsModel> dbSongList = box.values.toList();
  PlaylistSongModel? value = playBox.getAt(index);
  List<dynamic> playListSongs = value!.playlistSongs!;
  bool isSongExists = playListSongs
      .where((element) => element.id == dbSongList[songIndex].id)
      .isNotEmpty;
  if (isSongExists) {
    showSnackBar(
        context: context,
        message: 'You already added this song',
        colors: Colors.red,
        textColor: Colors.white);
  } else {
    addToPlaylist(songIndex, index, context);
  }
}

checkingSearchSongExistance(int index, int songIndex, BuildContext context,
    List<SongsModel> serchSongList) {
  final playBox = PlayListSongBox.getInstance();
  final box = SongBox.getInstance();
  List<SongsModel> dbSongList = box.values.toList();
  PlaylistSongModel? value = playBox.getAt(index);
  List<dynamic> playListSongs = value!.playlistSongs!;
  bool isSongExists = playListSongs
      .where((element) => element.id == dbSongList[songIndex].id)
      .isNotEmpty;
  if (isSongExists) {
    showSnackBar(
        context: context,
        message: 'You already added this song',
        colors: Colors.red,
        textColor: Colors.white);
  } else {
    searchToPlaylist(songIndex, index, context, serchSongList);
  }
}

checkingMostSongExistance(
  int index,
  int songIndex,
  BuildContext context,
  List<MostPlayedSongModel> listedMostSongs,
) {
  final playBox = PlayListSongBox.getInstance();
  PlaylistSongModel? value = playBox.getAt(index);
  List playListSongs = value!.playlistSongs!;
  bool isSongExists = playListSongs
      .where((element) => element.id == listedMostSongs[songIndex].id)
      .isNotEmpty;
  log("$listedMostSongs");
  log(listedMostSongs[songIndex].songName);
  log('$songIndex');
  if (isSongExists) {
    showSnackBar(
        context: context,
        message: 'You already added this song',
        colors: Colors.red,
        textColor: Colors.white);
  } else {
    mostAddToPlaylist(songIndex, index, context, listedMostSongs);
  }
}

checkCurrentPlayingToPlaylist(
    {required int playlistIndex,
    required int songId,
    required BuildContext context}) {
  final playBox = PlayListSongBox.getInstance();
  PlaylistSongModel? selectedPlaylist = playBox.getAt(playlistIndex);
  List<dynamic> playlistSongs = selectedPlaylist!.playlistSongs!;
  bool isExist =
      playlistSongs.where((element) => element.id == songId).isNotEmpty;
  if (isExist) {
    showSnackBar(
        context: context,
        message: 'You already added this song',
        colors: Colors.red,
        textColor: Colors.white);
  } else {
    currentPlayingAddtoPlaylist(
        songId: songId, context: context, playlistIndex: playlistIndex);
  }
}

currentPlayingAddtoPlaylist({
  required int songId,
  required BuildContext context,
  required int playlistIndex,
}) {
  final playBox = PlayListSongBox.getInstance();
  final songBox = SongBox.getInstance();
  List<SongsModel> allSongs = songBox.values.toList();
  PlaylistSongModel? selectedPlaylist = playBox.getAt(playlistIndex);
  List<dynamic> playDbSongs = selectedPlaylist!.playlistSongs!;
  SongsModel selectedSong =
      allSongs.firstWhere((element) => element.id == songId);
  log('${selectedPlaylist.playlistName}');
  playDbSongs.add(SongsModel(
      id: selectedSong.id,
      songName: selectedSong.songName,
      artist: selectedSong.artist,
      duration: selectedSong.duration,
      songurl: selectedSong.songurl));
  playBox.putAt(
      playlistIndex,
      PlaylistSongModel(
          playlistName: selectedPlaylist.playlistName,
          playlistSongs: playDbSongs));
  showSnackBar(
      context: context,
      message: 'Song Added',
      colors: const Color(0xFF879AFB),
      textColor: Colors.white);
}
