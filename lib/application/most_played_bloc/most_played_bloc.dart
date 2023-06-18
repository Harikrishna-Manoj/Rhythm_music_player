import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'most_played_event.dart';
part 'most_played_state.dart';

class MostPlayedBloc extends Bloc<MostPlayedEvent, MostPlayedState> {
  MostPlayedBloc() : super(MostPlayedInitial()) {
    on<MostPlayedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
