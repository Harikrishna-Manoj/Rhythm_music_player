import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:rythm1/database/database_functions/favourit_function/favourit_functions.dart';
import 'package:rythm1/rentering_items/screens/miniplayer/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../../styles_images/utils.dart';

InkWell songListFavourite({
  required List<Audio> favourtiAudio,
  required AssetsAudioPlayer audioPlayer,
  required String songName,
  required int songImage,
  required String artist,
  required int songDuration,
  required int index,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      audioPlayer.open(Playlist(audios: favourtiAudio, startIndex: index),
          showNotification: true,
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
          loopMode: LoopMode.playlist);
      showBottomSheet(
          context: context,
          builder: (context) => bottomSheet(
                context,
              ));
    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: QueryArtworkWidget(
          id: songImage,
          type: ArtworkType.AUDIO,
          quality: 100,
          artworkQuality: FilterQuality.high,
          artworkBorder: BorderRadius.circular(15),
          artworkFit: BoxFit.cover,
          nullArtworkWidget: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/head1.png',
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
                deletefav(
                    index: index,
                    context: context,
                    message: 'Removed from Favourites',
                    colors: Colors.red,
                    textColor: Colors.white);
              },
              icon: const Icon(
                Icons.favorite,
                color: Color(0xFF879AFB),
              ),
              iconSize: 25,
            )
          ],
        ),
      ),
    ),
  );
}

Center noFavouritWidget() {
  return Center(
      child: Text(
    'No Favourites yet :(',
    style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
  ));
}
