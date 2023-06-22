// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/models/song_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchInitial(searchList: [])) {
    on<SearchQuery>((event, emit) {
      final songDb = SongBox.getInstance();
      final serachedList = songDb.values
          .where((element) => element.songName!
              .toLowerCase()
              .contains(event.quey.toLowerCase().trim()))
          .toList();
      emit(SearchInitial(searchList: serachedList));
    });
  }
}
