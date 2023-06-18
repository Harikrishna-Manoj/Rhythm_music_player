// ignore_for_file: depend_on_referenced_packages

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../domain/models/favourit_song_model.dart';
import '../../domain/models/song_model.dart';
import '../../infrastructure/database_functions/db_function.dart';
import '../../presentation/common_widgets/common.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc()
      : super(const FavouriteInitial(favouriteAudio: [], favouriteSongs: [])) {
    on<GetAllFavouriteSongs>((event, emit) {
      List<Audio> favouritAudios = [];

      final favouriteDataBase = FavouritBox.getInstance();
      final favouriteSongs = favouriteDataBase.values.toList();
      for (var favourit in favouriteSongs) {
        favouritAudios.add(
          Audio.file(favourit.songUrl.toString(),
              metas: Metas(
                  artist: favourit.artist,
                  title: favourit.songName,
                  id: favourit.id.toString())),
        );
      }
      emit(DisPlayFavourite(
          favouriteSongs: favouriteSongs, favouriteAudio: favouritAudios));
    });
    on<AddOrRemoveFavourite>((event, emit) async {
      final songsbox = SongBox.getInstance();
      List<SongsModel> dbSongs = songsbox.values.toList();
      List<FavouritSongModel> favouriteSongs = favouritDatabase.values.toList();
      bool isPresent = favouriteSongs.any((element) => element.id == event.id);
      if (!isPresent) {
        SongsModel song =
            dbSongs.firstWhere((element) => element.id == event.id);
        favouritDatabase.add(FavouritSongModel(
            songName: song.songName,
            artist: song.artist,
            duration: song.duration,
            songUrl: song.songurl,
            id: song.id));
        showSnackBar(
            context: event.context,
            message: 'Added to Favourites',
            colors: event.colors,
            textColor: event.textColor);
      } else {
        int currentindex =
            favouriteSongs.indexWhere((element) => element.id == event.id);
        await favouritDatabase.deleteAt(currentindex);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(event.context).clearSnackBars();
        // ignore: use_build_context_synchronously
        showSnackBar(
            context: event.context,
            message: 'Removed from Favourites',
            colors: Colors.red,
            textColor: Colors.white);
      }
      add(GetAllFavouriteSongs());
    });
    on<RemoveFromFavourite>((event, emit) async {
      final favbox = FavouritBox.getInstance();
      List<FavouritSongModel> favouriteSongs = favbox.values.toList();
      int currentindex =
          favouriteSongs.indexWhere((element) => element.id == event.songId);
      if (currentindex >= 0) {
        await favouritDatabase.deleteAt(currentindex);
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(event.context).clearSnackBars();

      // ignore: use_build_context_synchronously
      showSnackBar(
          context: event.context,
          message: 'Removed from Favourite',
          colors: Colors.red,
          textColor: Colors.white);
      add(GetAllFavouriteSongs());
    });
    on<RemoveSongFromFavouritePage>((event, emit) async {
      await favouritDatabase.deleteAt(event.index);

      // ignore: use_build_context_synchronously
      showSnackBar(
          context: event.context,
          message: event.message,
          colors: event.colors,
          textColor: event.textColor);
      add(GetAllFavouriteSongs());
    });
  }
}
