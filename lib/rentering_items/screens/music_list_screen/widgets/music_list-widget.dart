// ignore_for_file: file_names

import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:rythm1/database/database_functions/most_function/most_function.dart';
import 'package:rythm1/database/models/most_played_song_model.dart';
import 'package:rythm1/rentering_items/screens/category_screens/favourit_page/widgets/switch.dart';
import 'package:rythm1/rentering_items/screens/category_screens/playlist_page/widgets/playlistwidget.dart';
import 'package:rythm1/rentering_items/screens/miniplayer/mini_player.dart';
import 'package:rythm1/rentering_items/screens/music_list_screen/music_list_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../../database/database_functions/recent_function/recent_fun.dart';
import '../../../../database/models/recent_song_model.dart';
import '../../../../database/models/song_model.dart';
import '../../../styles_images/utils.dart';
import '../../music_operation_screen/music_operation_page.dart';

InkWell allMusicList({
  RecentSongModel? recentSong,
  required List<Audio> convertedAudios,
  required List<MostPlayedSongModel> mostSongs,
  required SongsModel songs,
  required int image,
  required String songName,
  required String artist,
  required int songIndex,
  required BuildContext context,
}) {
  var size = MediaQuery.of(context).size;
  var height = size.height;
  var width = size.width;
  return InkWell(
    onTap: () {
      audioPlayer.open(
        Playlist(audios: convertedAudios, startIndex: songIndex),
        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
        showNotification: true,
        autoStart: true,
      );
      log('data passed');
      MusicPlay.currentvalue.value = songIndex;
      log('$convertedAudios');
      MusicListPage.currentValue.value = songIndex;
      log('$songIndex');

      audioPlayer.setLoopMode(LoopMode.playlist);
      recentSong = RecentSongModel(
          id: songs.id,
          index: songIndex,
          artist: songs.artist,
          duration: songs.duration,
          songName: songs.songName,
          songUrl: songs.songurl);
      addToRecent(recentSong!);
      log('$mostSongs');
      addMostSong(songIndex, mostSongs[songIndex]);
      log('bottom');
      showBottomSheet(
        context: context,
        builder: (context) => bottomSheet(
          context,
        ),
      );
    },
    child: ListTile(
      leading: QueryArtworkWidget(
        id: image,
        type: ArtworkType.AUDIO,
        quality: 100,
        artworkQuality: FilterQuality.high,
        artworkHeight: height * 0.07,
        artworkWidth: width * .150,
        artworkBorder: BorderRadius.circular(15),
        artworkFit: BoxFit.cover,
        nullArtworkWidget: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/images/head1.png',
            height: height * .07,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: TextScroll(
        mode: TextScrollMode.endless,
        velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
        songName,
        style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        artist,
        style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              showPlayListBottomSheet(context: context, songIndex: songIndex);
            },
            icon: const Icon(Icons.add),
            color: Colors.black,
            iconSize: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          SwitchCase(
            colr: const Color(0xFF879AFB),
            textcolor: Colors.white,
            id: image,
          )
        ],
      ),
    ),
  );
}
