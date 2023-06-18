import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/favourite_bloc/favourite_bloc.dart';
import 'package:rythm1/presentation/screens/category_screens/category_page.dart';
import 'package:rythm1/presentation/screens/miniplayer/mini_player.dart';
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
  var size = MediaQuery.of(context).size;
  var height = size.height;
  var width = size.width;
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
    child: ListTile(
      leading: QueryArtworkWidget(
        id: songImage,
        type: ArtworkType.AUDIO,
        quality: 100,
        artworkQuality: FilterQuality.high,
        artworkHeight: height * .07,
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
              BlocProvider.of<FavouriteBloc>(context).add(
                  RemoveSongFromFavouritePage(
                      index: index,
                      context: context,
                      message: 'Removed from Favourites',
                      colors: Colors.red,
                      textColor: Colors.white));
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CategoryPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ));
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
  );
}

Center noFavouritWidget() {
  return Center(
      child: Text(
    'No Favourites yet :(',
    style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
  ));
}
