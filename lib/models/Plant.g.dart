// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Plant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantAdapter extends TypeAdapter<Plant> {
  @override
  final int typeId = 1;

  @override
  Plant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plant(
      id: fields[4] as String,
      duration: fields[5] as String,
      isLiked: fields[6] as bool,
      image: fields[2] as String,
      name: fields[0] as String,
      time: fields[3] as String,
      tip: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Plant obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.tip)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
