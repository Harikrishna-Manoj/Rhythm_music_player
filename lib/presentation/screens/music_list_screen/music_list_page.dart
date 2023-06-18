import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/allmusic_bloc/allmusic_bloc.dart';
import 'package:rythm1/application/favourite_bloc/favourite_bloc.dart';
import 'package:rythm1/presentation/common_widgets/common.dart';
import 'package:rythm1/presentation/screens/category_screens/category_page.dart';
import 'package:rythm1/presentation/screens/music_list_screen/widgets/music_list-widget.dart';
import 'package:page_transition/page_transition.dart';
import '../../../domain/models/favourit_song_model.dart';
import '../../../domain/models/most_played_song_model.dart';
import '../../../domain/models/recent_song_model.dart';
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
final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
final List<MostPlayedSongModel> mostDbSongs = mostBox.values.toList();

class _MusicListPageState extends State<MusicListPage> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AllmusicBloc>(context).add(GetAllSongs());
    });
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
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
            BlocBuilder<FavouriteBloc, FavouriteState>(
              builder: (context, state) {
                return BlocBuilder<AllmusicBloc, AllmusicState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemBuilder: ((context, index) {
                        final music = state.allSongs[index];
                        RecentSongModel? recentSong;
                        return allMusicList(
                          convertedAudio: state.convertedAudio,
                          mostSongs: mostDbSongs,
                          songs: music,
                          image: music.id!,
                          songName: music.songName!,
                          artist: music.artist!,
                          songIndex: index,
                          context: context,
                          recentSong: recentSong,
                        );
                      }),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.allSongs.length,
                    );
                  },
                );
              },
            ),
            Positioned(
                top: height * .8,
                left: width * .34,
                child: FloatingActionButton.extended(
                    backgroundColor: const Color(0xFF879AFB),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const CategoryPage(),
                              type: PageTransitionType.bottomToTop));
                    },
                    label: exploreFloatingButtonText('Explore')))
          ],
        ),
      ),
    );
  }
}
