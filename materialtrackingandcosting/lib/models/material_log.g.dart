// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaterialLogAdapter extends TypeAdapter<MaterialLog> {
  @override
  final int typeId = 0;

  @override
  MaterialLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MaterialLog(
      id: fields[0] as String,
      materialName: fields[1] as String,
      quantity: fields[2] as double,
      cost: fields[3] as double,
      date: fields[4] as DateTime,
      notes: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MaterialLog obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.materialName)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.cost)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
