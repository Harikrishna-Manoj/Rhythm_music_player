import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/playlist_bloc/playlist_bloc.dart';
import 'package:rythm1/presentation/screens/category_screens/playlist_page/playlist_songs.dart';
import 'package:rythm1/presentation/screens/category_screens/playlist_page/widgets/playlistwidget.dart';
import 'package:page_transition/page_transition.dart';
import '../../../common_widgets/common.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<PlaylistBloc>(context).add(GetAllPlaylist());
    });
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
            child: BlocBuilder<PlaylistBloc, PlaylistState>(
                builder: (context, state) {
              return (state.playList.isNotEmpty)
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: PlayListSong(
                                      playIndex: index,
                                      playListName:
                                          state.playList[index].playlistName),
                                  type: PageTransitionType.rightToLeft),
                            );
                          },
                          child: songListPlaylist(
                              playListImage: 'assets/images/playlist.png',
                              playListName: state.playList[index].playlistName!,
                              numberofSongs:
                                  state.playList[index].playlistSongs!.length,
                              context: context,
                              index: index),
                        );
                      },
                      itemCount: state.playList.length,
                    )
                  : noPlaylistWidget(Colors.black);
            }),
          ),
        ],
      ),
    );
  }
}
