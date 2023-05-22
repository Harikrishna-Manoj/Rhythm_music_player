import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rythm1/database/models/playlist_song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import '../../rentering_items/screens/music_list_screen/music_list_page.dart';
import '../models/favourit_song_model.dart';
import '../models/most_played_song_model.dart';
import '../models/recent_song_model.dart';
import '../models/song_model.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();
final box = SongBox.getInstance();
final mostBox = MostPlayedSongBox.getInstance();
List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];
List<RecentSongModel> recentSongs = recentDatabase.values.toList();
Future<void> enterToExplore(BuildContext context) async {
  await Future.delayed(
    const Duration(seconds: 2),
  );
  (recentSongs.isEmpty)
      // ignore: use_build_context_synchronously
      ? Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const MusicListPage(),
          ),
        )
      :
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('explore');
}

Future<void> storagePermission() async {
  if (!kIsWeb) {
    bool status = await _audioQuery.permissionsStatus();
    if (!status) {
      await _audioQuery.permissionsRequest();
      fetchSongs = await _audioQuery.querySongs();
      for (var fetch in fetchSongs) {
        allSongs.add(fetch);
      }
      for (var all in allSongs) {
        await box.add(SongsModel(
          id: all.id,
          songName: all.title,
          artist: all.artist,
          duration: all.duration,
          songurl: all.uri,
        ));
      }
      for (var most in allSongs) {
        mostBox.add(MostPlayedSongModel(
            id: most.id,
            songName: most.title,
            artist: most.artist!,
            duration: most.duration!,
            songurl: most.uri!,
            count: 0));
      }
    }
  }
}

late Box<FavouritSongModel> favouritDatabase;
openFavouritDatabase() async {
  favouritDatabase = await Hive.openBox<FavouritSongModel>('favouritsongs');
}

late Box<RecentSongModel> recentDatabase;
openRecentDatabase() async {
  recentDatabase = await Hive.openBox<RecentSongModel>('recentsong');
}

late Box<MostPlayedSongModel> mostDatabase;
openMostDatabase() async {
  mostDatabase = await Hive.openBox<MostPlayedSongModel>('MostPlayed');
}

late Box<PlaylistSongModel> playListDatabase;
openPlayListDatabase() async {
  playListDatabase = await Hive.openBox<PlaylistSongModel>('playlist');
}
