import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:rythm1/rentering_items/screens/music_operation_screen/vol_controller/volume.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../styles_images/utils.dart';

RotationTransition rotatingImage(
    {required Animation<double> animation, required Playing playing}) {
  return RotationTransition(
    turns: animation,
    child: ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(200),
      child: QueryArtworkWidget(
        id: int.parse(playing.audio.audio.metas.id!),
        type: ArtworkType.AUDIO,
        quality: 100,
        artworkQuality: FilterQuality.high,
        artworkHeight: 300,
        artworkWidth: 300,
        artworkBorder: BorderRadius.circular(15),
        artworkFit: BoxFit.cover,
        nullArtworkWidget: Image.asset(
          'assets/images/head1.png',
          height: 300,
          width: 300,
        ),
      ),
    ),
  );
}

PlayerBuilder skipTime({required AssetsAudioPlayer player}) {
  return PlayerBuilder.isPlaying(
    player: player,
    builder: (context, isPlaying) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => player.seekBy(const Duration(seconds: -10)),
            icon: const Icon(Icons.replay_10, color: Colors.white),
            iconSize: 35,
          ),
          IconButton(
            onPressed: () => player.seekBy(const Duration(seconds: 10)),
            icon: const Icon(
              Icons.forward_10,
              color: Colors.white,
            ),
            iconSize: 35,
          )
        ],
      );
    },
  );
}

PlayerBuilder progressBar(
    {required AssetsAudioPlayer player,
    required Duration duration,
    required Duration position}) {
  return PlayerBuilder.realtimePlayingInfos(
    player: player,
    builder: (context, realtimePlayingInfos) {
      duration = realtimePlayingInfos.current!.audio.duration;
      position = realtimePlayingInfos.currentPosition;
      return ProgressBar(
        timeLabelTextStyle:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        baseBarColor: const Color.fromRGBO(217, 217, 217, 1),
        thumbColor: const Color.fromARGB(255, 154, 165, 220),
        progressBarColor: const Color.fromARGB(255, 55, 68, 135),
        thumbRadius: 5,
        barHeight: 10,
        progress: position,
        total: duration,
        onSeek: (duration) async {
          await player.seek(duration);
        },
      );
    },
  );
}

TextScroll songNameArtist({
  required String songNameArtist,
  required double fontSize,
  required Color color,
}) {
  return TextScroll(
    songNameArtist,
    mode: TextScrollMode.endless,
    velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
    style: safeGoogleFont('Poppins',
        fontWeight: FontWeight.bold, fontSize: fontSize, color: color),
  );
}

Future openDialoge(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const Dialog(
        child: VolumeController(),
      );
    },
  );
}
