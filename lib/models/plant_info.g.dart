// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantDataAdapter extends TypeAdapter<PlantData> {
  @override
  final int typeId = 0;

  @override
  PlantData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlantData(
      plantName: fields[0] as String,
      scientificName: fields[1] as String,
      plantImages: (fields[2] as List).cast<String>(),
      description: fields[3] as String,
      treatments: (fields[4] as List).cast<String>(),
      remedyList: (fields[5] as List).cast<RemedyInfo>(),
      bookmarkedAt: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, PlantData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.plantName)
      ..writeByte(1)
      ..write(obj.scientificName)
      ..writeByte(2)
      ..write(obj.plantImages)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.treatments)
      ..writeByte(5)
      ..write(obj.remedyList)
      ..writeByte(6)
      ..write(obj.bookmarkedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
