// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemModelAdapter extends TypeAdapter<ItemModel> {
  @override
  final int typeId = 2;

  @override
  ItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemModel()
      .._itemName = fields[0] as String?
      .._itemCategoryName = fields[1] as String?
      .._itemQuantity = fields[2] as String?
      .._itemQuantityAmount = fields[3] as num?
      .._itemPurchasePlace = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._itemName)
      ..writeByte(1)
      ..write(obj._itemCategoryName)
      ..writeByte(2)
      ..write(obj._itemQuantity)
      ..writeByte(3)
      ..write(obj._itemQuantityAmount)
      ..writeByte(4)
      ..write(obj._itemPurchasePlace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
