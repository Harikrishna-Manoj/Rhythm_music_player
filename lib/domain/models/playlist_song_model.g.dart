// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistSongModelAdapter extends TypeAdapter<PlaylistSongModel> {
  @override
  final int typeId = 4;

  @override
  PlaylistSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistSongModel(
      playlistName: fields[0] as String?,
      playlistSongs: (fields[1] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistSongModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.playlistSongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
