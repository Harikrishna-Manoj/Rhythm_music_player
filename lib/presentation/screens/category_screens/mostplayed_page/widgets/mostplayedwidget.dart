import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../../../application/favourite_bloc/favourite_bloc.dart';
import '../../../../../domain/models/most_played_song_model.dart';
import '../../../../../infrastructure/database_functions/favourit_function/favourit_functions.dart';
import '../../../../styles_images/utils.dart';
import '../../../miniplayer/mini_player.dart';
import '../../playlist_page/widgets/playlistwidget.dart';

Column mostGrid({
  required List<MostPlayedSongModel> listedMostSongs,
  required AssetsAudioPlayer audioplayer,
  required List<Audio> mostAudios,
  required BuildContext context,
  required int index,
  required String artist,
  required String songName,
  required int image,
  required int time,
}) {
  final size = MediaQuery.of(context).size;
  final height = size.height;
  final width = size.width;
  final audioPlayer = AssetsAudioPlayer.withId('0');

  return Column(
    children: [
      Stack(
        children: [
          InkWell(
            onTap: () {
              audioPlayer.open(Playlist(audios: mostAudios, startIndex: index),
                  showNotification: true,
                  headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug);
              showBottomSheet(
                  context: context,
                  builder: (context) => bottomSheet(
                        context,
                      ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: QueryArtworkWidget(
                keepOldArtwork: true,
                artworkBorder: BorderRadius.circular(10),
                artworkHeight: height * 0.15,
                artworkWidth: width * 0.45,
                artworkFit: BoxFit.fill,
                id: image,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: SizedBox.fromSize(
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/images/head1.png',
                      height: height * 0.15,
                      width: width * 0.45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 110,
            child: Column(
              children: [
                BlocBuilder<FavouriteBloc, FavouriteState>(
                  builder: (context, state) {
                    return IconButton(
                      icon: (checkFavourite(image, BuildContext))
                          ? const Icon(
                              Icons.favorite_border,
                              color: Color(0xFF879AFB),
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Color(0xFF879AFB),
                            ),
                      onPressed: () {
                        BlocProvider.of<FavouriteBloc>(context).add(
                            AddOrRemoveFavourite(
                                id: image,
                                colors: const Color(0xFF879AFB),
                                textColor: Colors.white,
                                context: context));
                      },
                    );
                  },
                ),
                IconButton(
                    onPressed: () => showMostPagePlayListBottomSheet(
                        listedMostSongs: listedMostSongs,
                        context: context,
                        songIndex: index),
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                      color: Color(0xFF879AFB),
                    )),
              ],
            ),
          ),
        ],
      ),
      SizedBox(
        width: 140,
        child: TextScroll(
          mode: TextScrollMode.endless,
          velocity: const Velocity(pixelsPerSecond: Offset(20, 0)),
          songName,
          style: safeGoogleFont('Poppins',
              fontSize: 13, fontWeight: FontWeight.w500),
        ),
      )
    ],
  );
}

Center noMostWidget() {
  return Center(
      child: Text(
    'You have no most played song :(',
    style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
  ));
}
