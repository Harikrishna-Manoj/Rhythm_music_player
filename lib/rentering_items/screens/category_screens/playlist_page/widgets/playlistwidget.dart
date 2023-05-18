import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rythm1/database/database_functions/playlist_functios/playlist_fun.dart';
import 'package:rythm1/database/models/playlist_song_model.dart';
import 'package:rythm1/rentering_items/common_widgets/common.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../../../database/models/most_played_song_model.dart';
import '../../../../styles_images/utils.dart';
import '../../../miniplayer/mini_player.dart';
import '../playlist_songs.dart';

ListTile songListPlaylist(
    {required String playListImage,
    required String playListName,
    required int numberofSongs,
    required int index,
    required BuildContext context}) {
  return ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(20), // Image border
      child: SizedBox.fromSize(
        size: const Size.fromRadius(30), // Image radius
        child: Image.asset(playListImage, fit: BoxFit.cover),
      ),
    ),
    title: TextScroll(
      mode: TextScrollMode.endless,
      velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
      playListName,
      style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
    ),
    subtitle: Text(
      "$numberofSongs Songs",
      style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
    ),
    trailing: PopupMenuButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      onSelected: (value) {
        if (value == 1) {
          showConfirmationDialog(context, index);
        } else if (value == 2) {
          showeditPlayList(context, index);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
            value: 1,
            child: Text(
              'Delete Playlist',
              style: safeGoogleFont('Poppins',
                  fontWeight: FontWeight.w500, fontSize: 15),
            )),
        PopupMenuItem(
            value: 2,
            child: Text(
              'Edit Playlist',
              style: safeGoogleFont('Poppins',
                  fontWeight: FontWeight.w500, fontSize: 15),
            ))
      ],
    ),
  );
}

ListTile playListSongsList(
    {required int songImage,
    required String songName,
    required AssetsAudioPlayer audioPlayer,
    required List<Audio> playConvertedAudio,
    required String artist,
    required List<dynamic> playlistSongs,
    required List<PlaylistSongModel> playlistName,
    required int index,
    required String playName,
    required int playIndex,
    required Box<PlaylistSongModel> playBox,
    required BuildContext context}) {
  return ListTile(
    onTap: () {
      audioPlayer.open(Playlist(audios: playConvertedAudio, startIndex: index),
          showNotification: true,
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug);
      showBottomSheet(
          context: context,
          builder: (context) => bottomSheet(
                context,
              ));
    },
    leading: QueryArtworkWidget(
      id: songImage,
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
      velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
      songName,
      style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
    ),
    subtitle: Text(
      artist,
      style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            playlistSongs.removeAt(index);
            playlistName.removeAt(playIndex);
            showSnackBar(
                context: context,
                message: 'Removed from playList $playName ',
                colors: Colors.red,
                textColor: Colors.white);
            playBox.putAt(
                playIndex,
                PlaylistSongModel(
                    playlistName: playName, playlistSongs: playlistSongs));
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      PlayListSong(
                          playIndex: playIndex, playListName: playName),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ));
          },
          icon: const Icon(
            Icons.remove_circle_outline,
            color: Colors.black,
          ),
          iconSize: 25,
        )
      ],
    ),
  );
}

showConfirmationDialog(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      backgroundColor: const Color(0xFF879AFB),
      title: Text(
        'Are you sure ?',
        style: safeGoogleFont(
          'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Colors.white,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'No',
              style: safeGoogleFont(
                'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: Colors.white,
              ),
            )),
        TextButton(
            onPressed: () {
              deletePlaylist(index);
              Navigator.pop(context);
              showSnackBar(
                  context: context,
                  message: 'Playlist deleted',
                  colors: const Color(0xFF879AFB),
                  textColor: Colors.white);
            },
            child: Text(
              'Yes',
              style: safeGoogleFont(
                'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: Colors.white,
              ),
            ))
      ],
    ),
  );
}

showcreatePlayList(BuildContext context) {
  final textController = TextEditingController();
  showDialog(
    context: context,
    builder: ((ctx) => AlertDialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: const Color(0xFF879AFB),
          title: Text(
            'Create Playlist',
            style: safeGoogleFont(
              'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          content: SizedBox(
            height: 40,
            child: TextFormField(
              controller: textController,
              cursorColor: const Color(0xFF879AFB),
              style: safeGoogleFont(
                'Poppins',
                fontSize: 15,
                height: 1.5,
                color: const Color(0xFF879AFB),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ctx);
                textController.clear();
              },
              child: Text(
                'Cancel',
                style: safeGoogleFont(
                  'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
                valueListenable: textController,
                builder: ((context, controller, child) {
                  return TextButton(
                      onPressed: textController.text.isEmpty
                          ? () => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Playlist Name is Empty'),
                                dismissDirection: DismissDirection.down,
                                behavior: SnackBarBehavior.floating,
                                elevation: 30,
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.red,
                              ))
                          : !checkingExistance(textController.text)
                              ? () async {
                                  log('list created');
                                  createPlaylist(
                                      playlistName: textController.text);
                                  Navigator.pop(context);
                                  textController.clear();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Playlist Created'),
                                    dismissDirection: DismissDirection.down,
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 30,
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Color(0xFF879AFB),
                                  ));
                                }
                              : () async {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('This Playlist already exists'),
                                    dismissDirection: DismissDirection.down,
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 30,
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                  ));
                                  Navigator.pop(context);
                                },
                      child: Text(
                        'Create',
                        style: safeGoogleFont(
                          'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          color: Colors.white,
                        ),
                      ));
                })),
          ],
        )),
  );
}

showeditPlayList(BuildContext context, int index) {
  final playListBox = PlayListSongBox.getInstance();
  List<PlaylistSongModel> playListSongs = playListBox.values.toList();
  final textEditController =
      TextEditingController(text: playListSongs[index].playlistName);
  log(playListSongs[index].playlistName!);
  showDialog(
    context: context,
    builder: ((ctx) => AlertDialog(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: const Color(0xFF879AFB),
          title: Text(
            'Update Playlist',
            style: safeGoogleFont(
              'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Colors.white,
            ),
          ),
          content: SizedBox(
            height: 40,
            child: TextFormField(
              controller: textEditController,
              cursorColor: const Color(0xFF879AFB),
              style: safeGoogleFont(
                'Poppins',
                fontSize: 15,
                height: 1.5,
                color: const Color(0xFF879AFB),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(ctx),
              child: Text(
                'Cancel',
                style: safeGoogleFont(
                  'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
                valueListenable: textEditController,
                builder: ((context, controller, child) {
                  return TextButton(
                      onPressed: textEditController.text.isEmpty
                          ? () => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Playlist Name is Empty'),
                                dismissDirection: DismissDirection.down,
                                behavior: SnackBarBehavior.floating,
                                elevation: 30,
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.red,
                              ))
                          : !checkingExistance(textEditController.text)
                              ? () async {
                                  log('updated');
                                  editPlayList(
                                      name: textEditController.text,
                                      index: index);

                                  Navigator.pop(context);
                                  textEditController.clear();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Playlist Updated'),
                                    dismissDirection: DismissDirection.down,
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 30,
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Color(0xFF879AFB),
                                  ));
                                }
                              : () async {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('This Playlist already exists'),
                                    dismissDirection: DismissDirection.down,
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 30,
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                  ));
                                  Navigator.pop(context);
                                },
                      child: Text(
                        'Update',
                        style: safeGoogleFont(
                          'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          color: Colors.white,
                        ),
                      ));
                })),
          ],
        )),
  );
}

showPlayListBottomSheet(
    {required BuildContext context, required int songIndex}) {
  final playBox = PlayListSongBox.getInstance();
  showBottomSheet(
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 135, 154, 251),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'My PlayLists',
                style: safeGoogleFont('Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    showcreatePlayList(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ))
            ],
          ),
          Expanded(
              child: ValueListenableBuilder<Box<PlaylistSongModel>>(
            valueListenable: playBox.listenable(),
            builder: (context, Box<PlaylistSongModel> playSong, child) {
              List<PlaylistSongModel> playlistSong = playSong.values.toList();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: playlistSong.length,
                itemBuilder: ((context, index) {
                  return playListSongTile(
                      playListName: playlistSong[index].playlistName!,
                      playSong: playSong,
                      index: index,
                      songIndex: songIndex,
                      playlistSong: playlistSong,
                      context: context);
                }),
              );
            },
          ))
        ],
      ),
    ),
  );
}

showMostPagePlayListBottomSheet({
  required BuildContext context,
  required int songIndex,
  required List<MostPlayedSongModel> listedMostSongs,
}) {
  final playBox = PlayListSongBox.getInstance();
  showBottomSheet(
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 135, 154, 251),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'My PlayLists',
                style: safeGoogleFont('Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    showcreatePlayList(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ))
            ],
          ),
          Expanded(
              child: ValueListenableBuilder<Box<PlaylistSongModel>>(
            valueListenable: playBox.listenable(),
            builder: (context, Box<PlaylistSongModel> playSong, child) {
              List<PlaylistSongModel> playlistSong = playSong.values.toList();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: playlistSong.length,
                itemBuilder: ((context, index) {
                  return mostPlayListSongTile(
                      listedMostSongs: listedMostSongs,
                      playListName: playlistSong[index].playlistName!,
                      playSong: playSong,
                      index: index,
                      songIndex: songIndex,
                      playlistSong: playlistSong,
                      context: context);
                }),
              );
            },
          ))
        ],
      ),
    ),
  );
}

showcurrentPlayListBottomSheet(
    {required BuildContext context, required int songId}) {
  final playBox = PlayListSongBox.getInstance();
  showBottomSheet(
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'My PlayLists',
                style: safeGoogleFont('Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 135, 154, 251)),
              ),
              IconButton(
                  onPressed: () {
                    showcreatePlayList(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 135, 154, 251),
                    size: 28,
                  ))
            ],
          ),
          Expanded(
              child: ValueListenableBuilder<Box<PlaylistSongModel>>(
            valueListenable: playBox.listenable(),
            builder: (context, Box<PlaylistSongModel> playSong, child) {
              List<PlaylistSongModel> playlistSong = playSong.values.toList();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: playlistSong.length,
                itemBuilder: ((context, index) {
                  return currentplayListSongTile(
                      playListName: playlistSong[index].playlistName!,
                      playSong: playSong,
                      index: index,
                      songId: songId,
                      playlistSong: playlistSong,
                      context: context);
                }),
              );
            },
          ))
        ],
      ),
    ),
  );
}

currentplayListSongTile(
    {required String playListName,
    required Box<PlaylistSongModel> playSong,
    required int index,
    required int songId,
    required List<PlaylistSongModel> playlistSong,
    required BuildContext context}) {
  return ListTile(
    onTap: () {
      checkCurrentPlayingToPlaylist(
          playlistIndex: index, songId: songId, context: context);
    },
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(20), // Image border
      child: SizedBox.fromSize(
        size: const Size.fromRadius(20), // Image radius
        child: Image.asset('assets/images/playlist.png', fit: BoxFit.cover),
      ),
    ),
    title: Text(
      playlistSong[index].playlistName!,
      style: safeGoogleFont('Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 135, 154, 251)),
    ),
    trailing: IconButton(
      onPressed: () {
        deletePlaylist(index);
      },
      icon: const Icon(Icons.remove_circle_outline),
      color: const Color.fromARGB(255, 135, 154, 251),
    ),
  );
}

playListSongTile(
    {required String playListName,
    required Box<PlaylistSongModel> playSong,
    required int index,
    required int songIndex,
    required List<PlaylistSongModel> playlistSong,
    required BuildContext context}) {
  return ListTile(
    onTap: () {
      checkingSongExistance(index, songIndex, context);
    },
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(20), // Image border
      child: SizedBox.fromSize(
        size: const Size.fromRadius(20), // Image radius
        child: Image.asset('assets/images/playlist.png', fit: BoxFit.cover),
      ),
    ),
    title: Text(
      playlistSong[index].playlistName!,
      style: safeGoogleFont('Poppins',
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    ),
    trailing: IconButton(
      onPressed: () {
        deletePlaylist(index);
      },
      icon: const Icon(Icons.remove_circle_outline),
      color: Colors.white,
    ),
  );
}

mostPlayListSongTile(
    {required String playListName,
    required List<MostPlayedSongModel> listedMostSongs,
    required Box<PlaylistSongModel> playSong,
    required int index,
    required int songIndex,
    required List<PlaylistSongModel> playlistSong,
    required BuildContext context}) {
  return ListTile(
    onTap: () {
      checkingMostSongExistance(index, songIndex, context, listedMostSongs);
    },
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(20), // Image border
      child: SizedBox.fromSize(
        size: const Size.fromRadius(20), // Image radius
        child: Image.asset('assets/images/playlist.png', fit: BoxFit.cover),
      ),
    ),
    title: Text(
      playlistSong[index].playlistName!,
      style: safeGoogleFont('Poppins',
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    ),
    trailing: IconButton(
      onPressed: () {
        deletePlaylist(index);
      },
      icon: const Icon(Icons.remove_circle_outline),
      color: Colors.white,
    ),
  );
}

Center noPlaylistWidget() {
  return Center(
      child: Text(
    'You can create your own playlist :)',
    style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
  ));
}

Center noPlaylistSongWidget() {
  return Center(
      child: Text(
    'Add your songs :)',
    style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
  ));
}
