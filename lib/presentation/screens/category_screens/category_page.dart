import 'package:flutter/material.dart';
import 'package:rythm1/presentation/common_widgets/common.dart';
import 'package:rythm1/presentation/screens/category_screens/favourit_page/favourit_page.dart';
import 'package:rythm1/presentation/screens/category_screens/playlist_page/playlist_page.dart';
import 'package:rythm1/presentation/screens/category_screens/mostplayed_page/mostplayed_page.dart';
import 'package:rythm1/presentation/screens/explore_screen/explore_recend_page.dart';
import 'package:rythm1/presentation/screens/search_screen/search_page.dart';
import 'package:page_transition/page_transition.dart';
import '../music_list_screen/music_list_page.dart';
import '../search_screen/widgets/search_widget.dart';
import '../settings_screen/setting_page.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: const Color(0xFF879AFB),
        child: ListView(
          padding: EdgeInsets.only(left: width * .01, top: height * .05),
          children: [settingsItems(context)],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * .14),
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
                        SizedBox(
                          height: 610,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Flexible(
                                child: TabBarView(
                                  children: [
                                    FavouritSongPage(),
                                    MostSong(),
                                    const PlayList(),
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
                    height: height * .06,
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.only(right: width * .02),
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  child: ExplorePages(),
                                  type: PageTransitionType.leftToRight)),
                          iconSize: 15,
                        ),
                        InkWell(
                            onTap: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      child: const SearchScreen(),
                                      type: PageTransitionType.topToBottom),
                                ),
                            child: searchWidget(context))
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * .015,
                        right: width * .04,
                        left: width * .03,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 25,
                            child: InkWell(
                              child: Image.asset(
                                'assets/images/settings.png',
                              ),
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: InkWell(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: const MusicListPage(),
                                    type: PageTransitionType.rightToLeft),
                              ),
                              child: Image.asset(
                                'assets/images/all_songs.png',
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
