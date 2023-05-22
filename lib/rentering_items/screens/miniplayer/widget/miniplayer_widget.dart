import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../styles_images/utils.dart';
import '../../category_screens/favourit_page/favourit_page.dart';

Widget bottomDetails(context) {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  final size = MediaQuery.of(context).size;
  final height = size.height;
  final width = size.width;
  return player.builderCurrent(
      builder: (context, playing) => Column(
            children: [
              ListTile(
                leading: QueryArtworkWidget(
                  id: int.parse(playing.audio.audio.metas.id!),
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
                  player.getCurrentAudioTitle,
                  mode: TextScrollMode.endless,
                  velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                  style: safeGoogleFont('Poppins',
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                subtitle: Text(
                  player.getCurrentAudioArtist,
                  style: safeGoogleFont('Poppins',
                      fontWeight: FontWeight.w500, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: SizedBox(
                  width: 155,
                  height: 70,
                  child: Row(
                    children: [
                      PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isPlaying) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => player.previous(),
                              icon: const Icon(Icons.skip_previous_outlined),
                              iconSize: 35,
                              color: Colors.white,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: IconButton(
                                  onPressed: () async {
                                    if (isPlaying) {
                                      await player.pause();
                                    } else {
                                      await player.play();
                                    }
                                  },
                                  icon: (isPlaying)
                                      ? const Icon(
                                          Icons.pause,
                                          color: Color(0xFF879AFB),
                                          size: 25,
                                        )
                                      : const Icon(
                                          Icons.play_arrow,
                                          color: Color(0xFF879AFB),
                                          size: 25,
                                        )),
                            ),
                            IconButton(
                              onPressed: () {
                                player.next();
                              },
                              icon: const Icon(Icons.skip_next_outlined),
                              iconSize: 35,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 30, left: 20),
                child: progressBar(
                    player: player, duration: duration, position: position),
              )
            ],
          ));
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
        barHeight: 5,
        progress: position,
        total: duration,
        onSeek: (duration) async {
          await player.seek(duration);
        },
      );
    },
  );
}
