// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_screen_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailScreenModelAdapter extends TypeAdapter<DetailScreenModel> {
  @override
  final int typeId = 2;

  @override
  DetailScreenModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailScreenModel(
      voteAverage: fields[0] as num,
      releaseDate: fields[1] as String,
      title: fields[2] as String,
      posterPath: fields[3] as String,
      backdropPath: fields[4] as String,
      overview: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DetailScreenModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.voteAverage)
      ..writeByte(1)
      ..write(obj.releaseDate)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.backdropPath)
      ..writeByte(5)
      ..write(obj.overview);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailScreenModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
