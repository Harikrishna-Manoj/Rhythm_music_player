import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rythm1/database/models/favourit_song_model.dart';
import 'package:rythm1/database/models/most_played_song_model.dart';
import 'package:rythm1/database/models/recent_song_model.dart';
import 'package:rythm1/database/models/song_model.dart';
import 'package:rythm1/rentering_items/common_widgets/common.dart';
import 'package:rythm1/rentering_items/screens/category_screens/category_page.dart';
import 'package:rythm1/rentering_items/screens/music_list_screen/widgets/music_list-widget.dart';
import 'package:page_transition/page_transition.dart';
import '../explore_screen/explore_recend_page.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({super.key});
  static int? index = 0;
  static ValueNotifier<int> currentValue = ValueNotifier<int>(index!);

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

final favBox = FavouritBox.getInstance();
final mostBox = MostPlayedSongBox.getInstance();
final songsbox = SongBox.getInstance();
final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
final List<MostPlayedSongModel> mostDbSongs = mostBox.values.toList();
List<Audio> convertAudios = [];

class _MusicListPageState extends State<MusicListPage> {
  final box = SongBox.getInstance();
  List<Audio> convertAudios = [];

  // AssetsAudioPlayer player = AssetsAudioPlayer();
  @override
  void initState() {
    List<SongsModel> songDataBase = box.values.toList();

    for (var dbSongs in songDataBase) {
      convertAudios.add(
        Audio.file(
          dbSongs.songurl!,
          metas: Metas(
            title: dbSongs.songName,
            artist: dbSongs.artist,
            id: dbSongs.id.toString(),
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: const ExplorePages(),
                    ),
                  ),
              iconSize: 15,
              color: const Color(0xFF879AFB),
              icon: const Icon(Icons.arrow_back_ios_new)),
          centerTitle: true,
          title: allMusicHeading('All Music'),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            ValueListenableBuilder<Box<FavouritSongModel>>(
              valueListenable: favBox.listenable(),
              builder: (context, Box<FavouritSongModel> favSong, child) {
                return ValueListenableBuilder<Box<SongsModel>>(
                  valueListenable: box.listenable(),
                  builder: ((context, Box<SongsModel> allSongBox, child) {
                    List<SongsModel> songsDB = allSongBox.values.toList();
                    return ListView.builder(
                      itemBuilder: ((context, index) {
                        RecentSongModel? recentSong;
                        return allMusicList(
                          convertedAudios: convertAudios,
                          mostSongs: mostDbSongs,
                          songs: songsDB[index],
                          image: songsDB[index].id!,
                          songName: songsDB[index].songName!,
                          artist: songsDB[index].artist!,
                          songIndex: index,
                          context: context,
                          recentSong: recentSong,
                        );
                      }),
                      physics: const BouncingScrollPhysics(),
                      itemCount: songsDB.length,
                    );
                  }),
                );
              },
            ),
            Positioned(
                top: height * .8,
                left: width * .34,
                child: FloatingActionButton.extended(
                    backgroundColor: const Color(0xFF879AFB),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const CategoryPage(),
                              type: PageTransitionType.rightToLeft));
                    },
                    label: exploreFloatingButtonText('Explore')))
          ],
        ),
      ),
    );
  }
}
