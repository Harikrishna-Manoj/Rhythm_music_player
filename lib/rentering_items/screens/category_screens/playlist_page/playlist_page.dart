import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rythm1/database/models/playlist_song_model.dart';
import 'package:rythm1/rentering_items/screens/category_screens/playlist_page/playlist_songs.dart';
import 'package:rythm1/rentering_items/screens/category_screens/playlist_page/widgets/playlistwidget.dart';
import 'package:page_transition/page_transition.dart';
import '../../../common_widgets/common.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  final playBox = PlayListSongBox.getInstance();
  late List<PlaylistSongModel> playListSongs = playBox.values.toList();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * .015,
              left: width * .035,
              bottom: 20,
              right: width * .035,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mainHeading("PLAY LIST"),
                IconButton(
                    tooltip: 'Create Playlist',
                    onPressed: () => showcreatePlayList(context),
                    icon: const Icon(
                      Icons.add,
                      color: Color(0xFF879AFB),
                      size: 35,
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.095),
            child: ValueListenableBuilder<Box<PlaylistSongModel>>(
                valueListenable: playBox.listenable(),
                builder: (context, Box<PlaylistSongModel> playSong, child) {
                  List<PlaylistSongModel> playListSongs =
                      playSong.values.toList();
                  return (playListSongs.isNotEmpty)
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      child: PlayListSong(
                                          playIndex: index,
                                          playListName: playListSongs[index]
                                              .playlistName),
                                      type: PageTransitionType.rightToLeft),
                                );
                              },
                              child: songListPlaylist(
                                  playListImage: 'assets/images/playlist.png',
                                  playListName:
                                      playListSongs[index].playlistName!,
                                  numberofSongs: playListSongs[index]
                                      .playlistSongs!
                                      .length,
                                  context: context,
                                  index: index),
                            );
                          },
                          itemCount: playListSongs.length,
                        )
                      : noPlaylistWidget(Colors.black);
                }),
          ),
        ],
      ),
    );
  }
}
