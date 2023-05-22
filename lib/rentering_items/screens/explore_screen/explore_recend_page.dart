import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rythm1/database/models/most_played_song_model.dart';
import 'package:rythm1/rentering_items/screens/search_screen/search_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../database/models/recent_song_model.dart';
import '../../styles_images/utils.dart';
import '../category_screens/category_page.dart';
import '../miniplayer/mini_player.dart';
import '../music_list_screen/music_list_page.dart';
import '../search_screen/widgets/search_widget.dart';
import '../settings_screen/setting_page.dart';

class ExplorePages extends StatefulWidget {
  const ExplorePages({super.key});

  @override
  State<ExplorePages> createState() => _ExplorePagesState();
}

class _ExplorePagesState extends State<ExplorePages> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final box = RecentBox.getInstance();
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> recentAudios = [];
  @override
  void initState() {
    late List<RecentSongModel> recentSongs =
        box.values.toList().reversed.toList();
    for (var recent in recentSongs) {
      recentAudios.add(Audio.file(recent.songUrl.toString(),
          metas: Metas(
              artist: recent.artist,
              title: recent.songName,
              id: recent.id.toString())));
    }
    super.initState();
  }

  List<MostPlayedSongModel> mostSongs = [];
  List<RecentSongModel> recentMusics = [];
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
        child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box<RecentSongModel> dbRecent, child) {
              recentMusics = dbRecent.values.toList().reversed.toList();

              return Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: width * .090, top: height * .008),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        PageTransition(
                            child: const SearchScreen(),
                            type: PageTransitionType.topToBottom),
                      ),
                      child: searchWidget(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * .015,
                      right: width * .04,
                      left: width * .04,
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
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: const MusicListPage(),
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/All songs Button.png',
                            scale: 7,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 197, top: 10),
                          child: Text(
                            "Find your  RYTHM",
                            style: safeGoogleFont(
                              'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: const Color.fromARGB(255, 183, 183, 183),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 155, top: 5),
                          child: Text(
                            "Recent Songs",
                            style: safeGoogleFont(
                              'Poppins',
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * .05),
                    child: SizedBox(
                        height: 400,
                        child: ScrollSnapList(
                          scrollPhysics: const BouncingScrollPhysics(),
                          dynamicItemSize: true,
                          itemBuilder: _buildListItem,
                          itemCount: recentMusics.length,
                          itemSize: width * .5555,
                          onItemFocus: (p0) {},
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * .05),
                    child: TextButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: const CategoryPage())),
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF879AFB),
                          foregroundColor: Colors.white,
                          fixedSize: Size(width * .8, height * .06),
                          shape: const StadiumBorder()),
                      child: Text(
                        "Explore",
                        style: safeGoogleFont('Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SizedBox(
      width: width * .5555,
      height: height * .2,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: const Color(0xFF879AFB),
        elevation: 15,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    audioPlayer.open(
                        Playlist(audios: recentAudios, startIndex: index),
                        showNotification: true,
                        headPhoneStrategy:
                            HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                        loopMode: LoopMode.playlist);
                    showBottomSheet(
                      context: context,
                      builder: (context) => bottomSheet(
                        context,
                      ),
                    );
                  },
                  child: QueryArtworkWidget(
                    id: recentMusics[index].id!,
                    type: ArtworkType.AUDIO,
                    quality: 100,
                    artworkQuality: FilterQuality.high,
                    artworkBorder: BorderRadius.circular(15),
                    artworkHeight: height * .3,
                    artworkWidth: width * .5555,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/head1.png',
                        fit: BoxFit.cover,
                        width: width * .5555,
                        height: height * .3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextScroll(
                  mode: TextScrollMode.endless,
                  velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                  recentMusics[index].songName!,
                  style: safeGoogleFont('Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: Colors.white),
                ),
                TextScroll(
                  mode: TextScrollMode.endless,
                  velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                  recentMusics[index].artist!,
                  style: safeGoogleFont('Poppins',
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: const Color.fromARGB(143, 221, 218, 218)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 10),
                  child: IconButton(
                    onPressed: () {
                      audioPlayer.open(
                          Playlist(audios: recentAudios, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          loopMode: LoopMode.playlist);
                      showBottomSheet(
                          context: context,
                          builder: (context) => bottomSheet(
                                context,
                              ));
                    },
                    icon: const Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
