part of 'most_played_bloc.dart';

@immutable
abstract class MostPlayedState {}

class MostPlayedInitial extends MostPlayedState {
  MostPlayedInitial();
}

class DisplayMostPlayedSongs extends MostPlayedState {}
