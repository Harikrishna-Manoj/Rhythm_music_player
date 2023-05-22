import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rythm1/rentering_items/screens/category_screens/favourit_page/widgets/switch.dart';
import 'package:rythm1/rentering_items/screens/search_screen/widgets/search_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../database/models/song_model.dart';
import '../../styles_images/utils.dart';
import '../category_screens/playlist_page/widgets/playlistwidget.dart';
import '../explore_screen/explore_recend_page.dart';
import '../miniplayer/mini_player.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
final TextEditingController searchcontroller = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  late List<SongsModel> dataBaseSongs = [];
  List<Audio> searchSongs = [];

  late List<SongsModel> searchList = List.from(dataBaseSongs);

  final box = SongBox.getInstance();
  @override
  void initState() {
    dataBaseSongs = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: width * .040,
              top: height * .008,
              right: width * .040,
              bottom: height * .01,
            ),
            child: SizedBox(
              height: height * 0.05,
              child: TextFormField(
                controller: searchcontroller,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Image.asset(
                      'assets/images/search.png',
                      scale: 4,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        searchcontroller.clear();
                        Navigator.pop(context);
                      },
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 219, 222, 235),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                        fontSize: 15, height: 1.5, color: Colors.black)),
                onChanged: (value) {
                  updateSearch(value);
                },
              ),
            ),
          ),
          Expanded(
              child: searchList.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchList.length,
                      itemBuilder: ((context, songIndex) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              onTap: () {
                                player.open(
                                  Audio.file(searchList[songIndex].songurl!,
                                      metas: Metas(
                                          title: searchList[songIndex].songName,
                                          artist: searchList[songIndex].artist,
                                          id: searchList[songIndex]
                                              .id
                                              .toString())),
                                  showNotification: true,
                                );
                                showBottomSheet(
                                  context: context,
                                  builder: (context) => bottomSheet(
                                    context,
                                  ),
                                );
                              },
                              leading: QueryArtworkWidget(
                                id: searchList[songIndex].id!,
                                type: ArtworkType.AUDIO,
                                quality: 100,
                                artworkQuality: FilterQuality.high,
                                artworkBorder: BorderRadius.circular(15),
                                artworkFit: BoxFit.cover,
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'assets/images/head1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: TextScroll(
                                mode: TextScrollMode.endless,
                                velocity: const Velocity(
                                    pixelsPerSecond: Offset(30, 0)),
                                searchList[songIndex].songName!,
                                style: safeGoogleFont('Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                    color: Colors.black),
                              ),
                              subtitle: Text(
                                searchList[songIndex].artist!,
                                style: safeGoogleFont('Poppins',
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    SwitchCase(
                                        id: searchList[songIndex].id!,
                                        colr: const Color(0xFF879AFB),
                                        textcolor: Colors.white),
                                    IconButton(
                                        onPressed: () {
                                          showPlayListBottomSheet(
                                              context: context,
                                              songIndex: songIndex);
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          )))
                  : noSearchWidget())
        ],
      ),
    ));
  }

  updateSearch(String value) {
    setState(() {
      searchList = dataBaseSongs
          .where((element) =>
              element.songName!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
