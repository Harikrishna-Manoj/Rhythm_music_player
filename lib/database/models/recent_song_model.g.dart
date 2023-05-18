// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_song_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentSongModelAdapter extends TypeAdapter<RecentSongModel> {
  @override
  final int typeId = 2;

  @override
  RecentSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentSongModel(
      id: fields[0] as int?,
      songName: fields[1] as String?,
      artist: fields[2] as String?,
      duration: fields[3] as int?,
      songUrl: fields[4] as String?,
      index: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentSongModel obj) {
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
      ..write(obj.songUrl)
      ..writeByte(5)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
