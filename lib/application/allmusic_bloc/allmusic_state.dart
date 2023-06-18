part of 'allmusic_bloc.dart';

@immutable
abstract class AllmusicState {
  final List<SongsModel> allSongs;
  final List<Audio> convertedAudio;

  const AllmusicState({required this.convertedAudio, required this.allSongs});
}

class AllmusicInitial extends AllmusicState {
  const AllmusicInitial(
      {required super.convertedAudio, required super.allSongs});
}
