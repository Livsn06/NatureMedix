// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientDataAdapter extends TypeAdapter<ClientData> {
  @override
  final int typeId = 3;

  @override
  ClientData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientData(
      title: fields[0] as String,
      description: fields[1] as String,
      imagePaths: (fields[2] as List).cast<String>(),
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ClientData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.imagePaths)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
