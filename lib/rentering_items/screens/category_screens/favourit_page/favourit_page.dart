import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rythm1/database/models/favourit_song_model.dart';
import 'package:rythm1/rentering_items/screens/category_screens/favourit_page/widgets/favouritwidget.dart';
import '../../../common_widgets/common.dart';
import '../../../styles_images/utils.dart';

class FavouritSongPage extends StatefulWidget {
  const FavouritSongPage({super.key});

  @override
  State<FavouritSongPage> createState() => _FavouritSongPageState();
}

final player = AssetsAudioPlayer.withId('0');

class _FavouritSongPageState extends State<FavouritSongPage> {
  final favBox = FavouritBox.getInstance();
  List<Audio> favouritAudios = [];
  @override
  void initState() {
    final List<FavouritSongModel> favouritSongs =
        favBox.values.toList().reversed.toList();
    for (var favourit in favouritSongs) {
      favouritAudios.add(
        Audio.file(favourit.songUrl.toString(),
            metas: Metas(
                artist: favourit.artist,
                title: favourit.songName,
                id: favourit.id.toString())),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box<FavouritSongModel>>(
          valueListenable: favBox.listenable(),
          builder: (context, Box<FavouritSongModel> fav, child) {
            List<FavouritSongModel> favouriteSongs =
                fav.values.toList().reversed.toList();
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          mainHeading("FAVOURIT"),
                          Padding(
                            padding: const EdgeInsets.only(left: 82),
                            child: (favouriteSongs.isEmpty)
                                ? const Icon(Icons.favorite_outline)
                                : const Icon(Icons.favorite_outlined,
                                    color: Color(0xFF879AFB)),
                          )
                        ],
                      ),
                      Text(
                        '${favouriteSongs.length} Songs',
                        style: safeGoogleFont(
                          'Poppins',
                          fontWeight: FontWeight.w600,
                          // color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 65),
                    child: (favouriteSongs.isNotEmpty)
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: favouriteSongs.length,
                            itemBuilder: (context, index) => songListFavourite(
                                artist: favouriteSongs[index].artist!,
                                favourtiAudio: favouritAudios,
                                audioPlayer: player,
                                songName: favouriteSongs[index].songName!,
                                songImage: favouriteSongs[index].id!,
                                songDuration: favouriteSongs[index].duration!,
                                index: index,
                                context: context),
                          )
                        : noFavouritWidget())
              ],
            );
          }),
    );
  }
}
