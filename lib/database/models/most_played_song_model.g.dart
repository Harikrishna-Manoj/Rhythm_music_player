// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'most_played_song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MostPlayedSongModelAdapter extends TypeAdapter<MostPlayedSongModel> {
  @override
  final int typeId = 3;

  @override
  MostPlayedSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostPlayedSongModel(
      id: fields[0] as int,
      songName: fields[1] as String,
      artist: fields[2] as String,
      duration: fields[3] as int,
      songurl: fields[4] as String,
      count: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MostPlayedSongModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songName)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.songurl)
      ..writeByte(5)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostPlayedSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
