import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rythm1/application/allmusic_bloc/allmusic_bloc.dart';
import 'package:rythm1/application/favourite_bloc/favourite_bloc.dart';
import 'package:rythm1/application/search_bloc/search_bloc.dart';

import 'package:rythm1/presentation/screens/explore_screen/explore_recend_page.dart';
import 'package:rythm1/presentation/screens/splash_screen/splash_page.dart';
import 'domain/models/favourit_song_model.dart';
import 'domain/models/most_played_song_model.dart';
import 'domain/models/playlist_song_model.dart';
import 'domain/models/recent_song_model.dart';
import 'domain/models/song_model.dart';
import 'infrastructure/database_functions/db_function.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => AllmusicBloc(),
          ),
          BlocProvider(
            create: (context) => FavouriteBloc(),
          ),
          BlocProvider(
            create: (context) => SearchBloc(),
          )
        ],
        child: MaterialApp(
            title: 'RYTHM',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // scrollBehavior: MyCustomScrollBehavior(),
            home: const SplashScreen(),
            routes: {
              'explore': (context) => const ExplorePages(),
            }));
  }
}
