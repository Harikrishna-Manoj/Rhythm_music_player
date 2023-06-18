import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/favourite_bloc/favourite_bloc.dart';
import 'package:rythm1/presentation/screens/category_screens/favourit_page/widgets/favouritwidget.dart';
import '../../../common_widgets/common.dart';
import '../../../styles_images/utils.dart';

class FavouritSongPage extends StatelessWidget {
  FavouritSongPage({super.key});

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<FavouriteBloc>(context).add(GetAllFavouriteSongs());
    });
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body:
          BlocBuilder<FavouriteBloc, FavouriteState>(builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: height * .015, left: width * .035, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      mainHeading("FAVOURIT"),
                      Padding(
                        padding: EdgeInsets.only(left: width * .24),
                        child: (state.favouriteSongs.isEmpty)
                            ? const Icon(Icons.favorite_outline)
                            : const Icon(Icons.favorite_outlined,
                                color: Color(0xFF879AFB)),
                      )
                    ],
                  ),
                  Text(
                    '${state.favouriteSongs.length} Songs',
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
                padding: EdgeInsets.only(top: height * .085),
                child: (state.favouriteSongs.isNotEmpty)
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.favouriteSongs.length,
                        itemBuilder: (context, index) => songListFavourite(
                            artist: state.favouriteSongs[index].artist!,
                            favourtiAudio: state.favouriteAudio,
                            audioPlayer: player,
                            songName: state.favouriteSongs[index].songName!,
                            songImage: state.favouriteSongs[index].id!,
                            songDuration: state.favouriteSongs[index].duration!,
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
