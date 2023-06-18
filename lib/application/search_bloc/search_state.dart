part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  final List<SongsModel> searchList;
  const SearchState({required this.searchList});
}

class SearchInitial extends SearchState {
  const SearchInitial({required super.searchList});
}
