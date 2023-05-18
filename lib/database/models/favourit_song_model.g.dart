// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourit_song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritSongModelAdapter extends TypeAdapter<FavouritSongModel> {
  @override
  final int typeId = 1;

  @override
  FavouritSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritSongModel(
      id: fields[0] as int?,
      songName: fields[1] as String?,
      artist: fields[2] as String?,
      duration: fields[3] as int?,
      songUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritSongModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songName)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.songUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
