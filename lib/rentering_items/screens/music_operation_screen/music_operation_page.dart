import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rythm1/database/models/song_model.dart';
import 'package:rythm1/database/database_functions/favourit_function/favourit_functions.dart';
import 'package:rythm1/rentering_items/screens/category_screens/playlist_page/widgets/playlistwidget.dart';
import 'package:rythm1/rentering_items/screens/music_operation_screen/widgets/music_operation_widget.dart';

class MusicPlay extends StatefulWidget {
  const MusicPlay({super.key});
  static int? index = 0;
  static ValueNotifier<int> currentvalue = ValueNotifier<int>(index!);
  static List listNotifier = SongBox.getInstance().values.toList();
  // static ValueNotifier<List> currentList = ValueNotifier<List>(listNotifier);
  @override
  State<MusicPlay> createState() => _MusicPlayState();
}

// ignore: prefer_typing_uninitialized_variables
var orientation, size, height, width;

class _MusicPlayState extends State<MusicPlay> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  final player = AssetsAudioPlayer.withId('0');
  final box = SongBox.getInstance();

//for_volume_controller

  bool isShuffling = false;
  bool isLoop = false;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    animationController.repeat();
    super.initState();
  }

  // ignore: annotate_overrides
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration.zero;
    Duration position = Duration.zero;
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF879AFB),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    animationController.stop();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: MusicPlay.currentvalue,
              builder: (BuildContext context, int value, child) {
                return ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder:
                      (BuildContext context, Box<SongsModel> allSongs, child) {
                    return player.builderCurrent(
                      builder: (context, playing) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showcurrentPlayListBottomSheet(
                                          context: context,
                                          songId: int.parse(
                                              playing.audio.audio.metas.id!));
                                    },
                                    icon: const Icon(
                                      Icons.playlist_add,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                  icon: (checkFavourite(
                                          int.parse(
                                              playing.audio.audio.metas.id!),
                                          BuildContext))
                                      ? Icon(
                                          Icons.favorite_outlined,
                                          color: Colors.white.withOpacity(0.8),
                                        )
                                      : Icon(
                                          Icons.favorite_outlined,
                                          color: Colors.red.withOpacity(0.8),
                                        ),
                                  onPressed: () {
                                    if (checkFavourite(
                                        int.parse(
                                            playing.audio.audio.metas.id!),
                                        BuildContext)) {
                                      addFavourites(
                                          int.parse(
                                              playing.audio.audio.metas.id!),
                                          context,
                                          Colors.white,
                                          const Color(0xFF879AFB));
                                    } else if (!checkFavourite(
                                        int.parse(
                                            playing.audio.audio.metas.id!),
                                        BuildContext)) {
                                      removeFav(
                                          int.parse(
                                              playing.audio.audio.metas.id!),
                                          context);
                                    }
                                    setState(() {
                                      checkFavourite(
                                              int.parse(playing
                                                  .audio.audio.metas.id!),
                                              BuildContext) !=
                                          checkFavourite(
                                              int.parse(playing
                                                  .audio.audio.metas.id!),
                                              BuildContext);
                                    });
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      openDialoge(context);
                                    },
                                    icon: const Icon(
                                      Icons.volume_up,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: height * .04,
                            ),
                            rotatingImage(
                                animation: animation, playing: playing),
                            SizedBox(
                              height: height * .04,
                            ),
                            songNameArtist(
                              songNameArtist: player.getCurrentAudioTitle,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                            songNameArtist(
                              songNameArtist: player.getCurrentAudioArtist,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * .05),
                              child: Column(
                                children: [
                                  skipTime(player: player),
                                  progressBar(
                                      player: player,
                                      duration: duration,
                                      position: position),
                                  PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, isPlaying) => Padding(
                                      padding:
                                          EdgeInsets.only(top: height * .03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              player.toggleShuffle();

                                              setState(() {
                                                isShuffling = !isShuffling;
                                              });
                                            },
                                            icon: (isShuffling)
                                                ? const Icon(
                                                    Icons.shuffle_on_outlined,
                                                    color: Colors.white,
                                                  )
                                                : const Icon(
                                                    Icons.shuffle,
                                                    color: Colors.white,
                                                  ),
                                            iconSize: 30,
                                          ),
                                          IconButton(
                                            onPressed: () => player.previous(),
                                            icon: const Icon(
                                                Icons.skip_previous_outlined),
                                            iconSize: 35,
                                            color: Colors.white,
                                          ),
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: IconButton(
                                                onPressed: () async {
                                                  if (isPlaying) {
                                                    await player.pause();
                                                    animationController.stop();
                                                  } else {
                                                    await player.play();
                                                    animationController
                                                        .repeat();
                                                  }
                                                  setState(() {
                                                    isPlaying = !isPlaying;
                                                  });
                                                },
                                                icon: (isPlaying)
                                                    ? const Icon(
                                                        Icons.pause,
                                                        color:
                                                            Color(0xFF879AFB),
                                                        size: 30,
                                                      )
                                                    : const Icon(
                                                        Icons.play_arrow,
                                                        color:
                                                            Color(0xFF879AFB),
                                                        size: 30,
                                                      )),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              player.next();
                                            },
                                            icon: const Icon(
                                                Icons.skip_next_outlined),
                                            iconSize: 35,
                                            color: Colors.white,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (isLoop) {
                                                    player.setLoopMode(
                                                        LoopMode.none);
                                                    isLoop = false;
                                                  } else {
                                                    player.setLoopMode(
                                                        LoopMode.single);
                                                    isLoop = true;
                                                  }
                                                });
                                              },
                                              icon: (isLoop)
                                                  ? const Icon(
                                                      Icons.repeat_on_rounded,
                                                      color: Colors.white,
                                                      size: 35,
                                                    )
                                                  : const Icon(
                                                      Icons.repeat,
                                                      color: Colors.white,
                                                      size: 35,
                                                    ))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
