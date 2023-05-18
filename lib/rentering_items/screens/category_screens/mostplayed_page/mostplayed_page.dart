import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rythm1/database/models/most_played_song_model.dart';
import 'package:rythm1/rentering_items/screens/category_screens/mostplayed_page/widgets/mostplayedwidget.dart';
import '../../../common_widgets/common.dart';

class MostSong extends StatefulWidget {
  const MostSong({super.key});

  @override
  State<MostSong> createState() => _MostSongState();
}

class _MostSongState extends State<MostSong> {
  final box = MostPlayedSongBox.getInstance();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> mostAudios = [];
  @override
  void initState() {
    List<MostPlayedSongModel> mostMusics = box.values.toList();
    int i = 0;
    for (var most in mostMusics) {
      if (most.count > 3) {
        mostPlayedSongs.insert(i, most);
        i++;
      }
    }
    for (var item in mostPlayedSongs) {
      mostAudios.add(Audio.file(item.songurl,
          metas: Metas(
              title: item.songName,
              artist: item.artist,
              id: item.id.toString())));
    }
    super.initState();
  }

  List<MostPlayedSongModel> mostPlayedSongs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 8, left: 15),
            child: mainHeading("MOST PLAYED"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ValueListenableBuilder<Box<MostPlayedSongModel>>(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  return (mostPlayedSongs.isNotEmpty)
                      ? GridView.count(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(
                            mostPlayedSongs.length,
                            (index) => mostGrid(
                              listedMostSongs: mostPlayedSongs,
                              audioplayer: audioPlayer,
                              mostAudios: mostAudios,
                              index: index,
                              context: context,
                              artist: mostPlayedSongs[index].artist,
                              songName: mostPlayedSongs[index].songName,
                              image: mostPlayedSongs[index].id,
                              time: mostPlayedSongs[index].duration,
                            ),
                          ),
                        )
                      : noMostWidget();
                }),
          ),
        ],
      ),
    );
  }
}
