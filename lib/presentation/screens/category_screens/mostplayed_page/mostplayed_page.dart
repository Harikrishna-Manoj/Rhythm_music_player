import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rythm1/application/most_played_bloc/most_played_bloc.dart';
import 'package:rythm1/presentation/screens/category_screens/mostplayed_page/widgets/mostplayedwidget.dart';
import '../../../common_widgets/common.dart';

class MostSong extends StatelessWidget {
  MostSong({super.key});

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<MostPlayedBloc>(context).add(GetAllMostPlayedSongs());
    });
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: height * .015, left: width * .035, bottom: 20),
            child: mainHeading("MOST PLAYED"),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.065),
            child: BlocBuilder<MostPlayedBloc, MostPlayedState>(
                builder: (context, state) {
              return (state.mostPlayedSongs.isNotEmpty)
                  ? GridView.count(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(
                        state.mostPlayedSongs.length,
                        (index) => mostGrid(
                          listedMostSongs: state.mostPlayedSongs,
                          audioplayer: audioPlayer,
                          mostAudios: state.mostAudio,
                          index: index,
                          context: context,
                          artist: state.mostPlayedSongs[index].artist,
                          songName: state.mostPlayedSongs[index].songName,
                          image: state.mostPlayedSongs[index].id,
                          time: state.mostPlayedSongs[index].duration,
                        ),
                      ),
                    )
                  : noMostWidget();
            }),
          ),
        ],
      ),
    );
  }
}
