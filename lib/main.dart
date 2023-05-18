import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rythm1/database/models/most_played_song_model.dart';
import 'package:rythm1/database/models/playlist_song_model.dart';
import 'package:rythm1/database/models/recent_song_model.dart';
import 'package:rythm1/database/models/song_model.dart';
import 'package:rythm1/rentering_items/screens/explore_screen/explore_recend_page.dart';
import 'package:rythm1/rentering_items/screens/splash_screen/splash_page.dart';
import 'database/database_functions/db_function.dart';
import 'database/models/favourit_song_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SongsModelAdapter());
  await Hive.openBox<SongsModel>('AllSongs');

  Hive.registerAdapter(FavouritSongModelAdapter());
  openFavouritDatabase();

  Hive.registerAdapter(RecentSongModelAdapter());
  openRecentDatabase();

  Hive.registerAdapter(MostPlayedSongModelAdapter());
  openMostDatabase();

  Hive.registerAdapter(PlaylistSongModelAdapter());
  openPlayListDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'RYTHM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // scrollBehavior: MyCustomScrollBehavior(),
        home: const SplashScreen(),
        routes: {
          'explore': (context) => const ExplorePages(),
        });
  }
}
