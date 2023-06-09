import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/playlist_bloc/playlist_bloc.dart';
import 'package:rythm1/presentation/screens/category_screens/playlist_page/widgets/playlistwidget.dart';
import '../../../../domain/models/playlist_song_model.dart';
import '../../../styles_images/utils.dart';

// ignore: must_be_immutable
class PlayListSong extends StatefulWidget {
  PlayListSong(
      {super.key, required this.playIndex, required this.playListName});

  int? playIndex;
  String? playListName;

  @override
  State<PlayListSong> createState() => _PlayListSongState();
}

class _PlayListSongState extends State<PlayListSong> {
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> playListAudio = [];
  @override
  void initState() {
    final playBox = PlayListSongBox.getInstance();
    List<PlaylistSongModel> playListSongs = playBox.values.toList();
    for (var playList in playListSongs[widget.playIndex!].playlistSongs!) {
      playListAudio.add(Audio.file(playList.songurl!,
          metas: Metas(
              title: playList.songName,
              id: playList.id.toString(),
              artist: playList.artist)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF879AFB),
                      size: 15,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: width * .17),
                  child: Text(
                    'Playlist Songs',
                    style: safeGoogleFont(
                      'Poppins',
                      fontSize: 20,
                      color: const Color(0xFF879AFB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, state) {
                final playBox = PlayListSongBox.getInstance();
                List<PlaylistSongModel> playListName = playBox.values.toList();
                List<dynamic>? playListPageSongs =
                    state.playList[widget.playIndex!].playlistSongs;
                return playListPageSongs!.isNotEmpty
                    ? ListView.builder(
                        itemCount: playListPageSongs.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return playListSongsList(
                              songImage: playListPageSongs[index].id!,
                              songName: playListPageSongs[index].songName!,
                              audioPlayer: audioPlayer,
                              playConvertedAudio: playListAudio,
                              artist: playListPageSongs[index].artist!,
                              playlistSongs: playListPageSongs,
                              playlistName: playListName,
                              index: index,
                              playName: widget.playListName!,
                              playIndex: widget.playIndex!,
                              playBox: playBox,
                              context: context);
                        },
                      )
                    : noPlaylistSongWidget();
              }),
            )
          ],
        ),
      ),
    );
  }
}
