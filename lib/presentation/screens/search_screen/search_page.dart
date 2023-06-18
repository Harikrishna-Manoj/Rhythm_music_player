import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/search_bloc/search_bloc.dart';
import 'package:rythm1/presentation/screens/search_screen/widgets/search_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../application/favourite_bloc/favourite_bloc.dart';
import '../../../infrastructure/database_functions/favourit_function/favourit_functions.dart';
import '../../styles_images/utils.dart';
import '../category_screens/playlist_page/widgets/playlistwidget.dart';
import '../miniplayer/mini_player.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SearchBloc>(context).add(SearchQuery(quey: ''));
    });
    final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
    final TextEditingController searchcontroller = TextEditingController();
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
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchQuery(quey: value));
                },
              ),
            ),
          ),
          Expanded(child: BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              return BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.searchList.isEmpty) {
                    return noSearchWidget();
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: ((context, songIndex) {
                      final music = state.searchList[songIndex];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          onTap: () {
                            player.open(
                              Audio.file(music.songurl!,
                                  metas: Metas(
                                      title: music.songName,
                                      artist: music.artist,
                                      id: music.id.toString())),
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
                            id: music.id!,
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
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(30, 0)),
                            music.songName!,
                            style: safeGoogleFont('Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            music.artist!,
                            style: safeGoogleFont('Poppins',
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: (checkFavourite(music.id, BuildContext))
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
                                            id: music.id!,
                                            colors: const Color(0xFF879AFB),
                                            textColor: Colors.white,
                                            context: context));
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      showSearchPlayListBottomSheet(
                                          serchSongList: state.searchList,
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
                      );
                    }),
                    itemCount: state.searchList.length,
                  );
                },
              );
            },
          ))
        ],
      ),
    ));
  }
}
