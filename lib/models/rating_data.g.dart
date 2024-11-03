// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RatingDataAdapter extends TypeAdapter<RatingData> {
  @override
  final int typeId = 2;

  @override
  RatingData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RatingData(
      plantName: fields[0] as String,
      userId: fields[1] as String,
      rating: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RatingData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.plantName)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
