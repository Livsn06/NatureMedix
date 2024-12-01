// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remedy_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RemedyInfoAdapter extends TypeAdapter<RemedyInfo> {
  @override
  final int typeId = 1;

  @override
  RemedyInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RemedyInfo(
      remedyName: fields[0] as String,
      remedyType: fields[1] as String,
      treatment: fields[2] as String,
      description: fields[3] as String,
      remedyImages: (fields[4] as List).cast<String>(),
      ingredients: (fields[5] as List).cast<String>(),
      steps: (fields[6] as List).cast<String>(),
      usage: (fields[7] as List).cast<String>(),
      bookmarkedAt: fields[8] as DateTime?,
      rating: fields[9] as double,
      sideEffects: fields[10] as List<String>,
    );
  }

  @override
  void write(BinaryWriter writer, RemedyInfo obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.remedyName)
      ..writeByte(1)
      ..write(obj.remedyType)
      ..writeByte(2)
      ..write(obj.treatment)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.remedyImages)
      ..writeByte(5)
      ..write(obj.ingredients)
      ..writeByte(6)
      ..write(obj.steps)
      ..writeByte(7)
      ..write(obj.usage)
      ..writeByte(8)
      ..write(obj.bookmarkedAt)
      ..writeByte(9)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemedyInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
