import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:rythm1/rentering_items/common_widgets/common.dart';
import 'package:rythm1/rentering_items/screens/category_screens/favourit_page/favourit_page.dart';
import 'package:rythm1/rentering_items/screens/category_screens/playlist_page/playlist_page.dart';
import 'package:rythm1/rentering_items/screens/category_screens/mostplayed_page/mostplayed_page.dart';
import 'package:rythm1/rentering_items/screens/search_screen/search_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../../database/models/song_model.dart';
import '../explore_screen/explore_recend_page.dart';
import '../music_list_screen/music_list_page.dart';
import '../search_screen/widgets/search_widget.dart';
import '../settings_screen/setting_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

final audioPlayer = AssetsAudioPlayer.withId('0');
final box = SongBox.getInstance();

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: const Color(0xFF879AFB),
        child: ListView(
          padding: const EdgeInsets.only(left: 10.0, top: 50),
          children: [settingsItems(context)],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 110),
              child: ListView(
                children: [
                  DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: TabBar(
                            indicator: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(50), // Creates border
                                color: const Color(0xFF879AFB)),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            tabs: [
                              Tab(child: tabHeading('Favourite')),
                              Tab(child: tabHeading('Most Plyed')),
                              Tab(child: tabHeading('Playlist'))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 610,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Flexible(
                                child: TabBarView(
                                  children: [
                                    FavouritSongPage(),
                                    MostSong(),
                                    PlayList(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        IconButton(
                          padding: const EdgeInsets.only(right: 10),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: const ExplorePages(),
                                type: PageTransitionType.topToBottom),
                          ),
                          iconSize: 15,
                        ),
                        InkWell(
                            onTap: () => Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: const SearchScreen(),
                                      type: PageTransitionType.topToBottom),
                                ),
                            child: searchWidget())
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, right: 20, left: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 30,
                            child: InkWell(
                              child: Image.asset(
                                'assets/images/setting.png',
                              ),
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: InkWell(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: const MusicListPage(),
                                    type: PageTransitionType.leftToRight),
                              ),
                              child: Image.asset(
                                'assets/images/head.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
