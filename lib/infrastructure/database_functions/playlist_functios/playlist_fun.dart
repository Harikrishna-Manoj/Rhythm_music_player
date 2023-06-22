import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/playlist_bloc/playlist_bloc.dart';
import 'package:rythm1/presentation/common_widgets/common.dart';

import '../../../domain/models/most_played_song_model.dart';
import '../../../domain/models/playlist_song_model.dart';
import '../../../domain/models/song_model.dart';

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
  } else {}
  BlocProvider.of<PlaylistBloc>(context)
      .add(AddToPlaylist(songIndex: songIndex, index: index, context: context));
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
    BlocProvider.of<PlaylistBloc>(context).add(SearchToPlaylist(
        songIndex: songIndex,
        index: index,
        context: context,
        serchSongList: serchSongList));
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
    BlocProvider.of<PlaylistBloc>(context).add(MostAddToPlaylist(
        songIndex: songIndex,
        index: index,
        context: context,
        listedMostSongs: listedMostSongs));
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
    BlocProvider.of<PlaylistBloc>(context).add(CurrentPlayingAddtoPlaylist(
        songId: songId, context: context, playlistIndex: playlistIndex));
  }
}
