import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/allmusic_bloc/allmusic_bloc.dart';
import 'package:rythm1/presentation/common_widgets/common.dart';
import 'package:rythm1/presentation/screens/category_screens/category_page.dart';
import 'package:rythm1/presentation/screens/music_list_screen/widgets/music_list-widget.dart';
import 'package:page_transition/page_transition.dart';
import '../explore_screen/explore_recend_page.dart';

class MusicListPage extends StatelessWidget {
  const MusicListPage({super.key});
  static int? index = 0;
  static ValueNotifier<int> currentValue = ValueNotifier<int>(index!);

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
                      child: ExplorePages(),
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
            BlocBuilder<AllmusicBloc, AllmusicState>(
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: ((context, index) {
                    final music = state.allSongs[index];
                    return allMusicList(
                      convertedAudio: state.convertedAudio,
                      songs: music,
                      image: music.id!,
                      songName: music.songName!,
                      artist: music.artist!,
                      songIndex: index,
                      context: context,
                    );
                  }),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.allSongs.length,
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
                              child: CategoryPage(),
                              type: PageTransitionType.bottomToTop));
                    },
                    label: exploreFloatingButtonText('Explore')))
          ],
        ),
      ),
    );
  }
}
