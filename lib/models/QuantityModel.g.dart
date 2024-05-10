// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuantityModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuantityModelAdapter extends TypeAdapter<QuantityModel> {
  @override
  final int typeId = 1;

  @override
  QuantityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuantityModel().._quantityName = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, QuantityModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._quantityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuantityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
