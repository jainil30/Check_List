import 'package:hive/hive.dart';

/// itemName : "Rice"
/// itemCategoryName : "Category 1"
/// itemQuantity : "Kilograms"
/// itemQuantityAmount : 100.50
/// itemPurchasePlace : "Bhavnagar"
part "ItemModel.g.dart";

@HiveType(typeId: 2)
class ItemModel {
  ItemModel({
    String? itemName,
    String? itemCategoryName,
    String? itemQuantity,
    num? itemQuantityAmount,
    String? itemPurchasePlace,
  }) {
    _itemName = itemName;
    _itemCategoryName = itemCategoryName;
    _itemQuantity = itemQuantity;
    _itemQuantityAmount = itemQuantityAmount;
    _itemPurchasePlace = itemPurchasePlace;
  }

  ItemModel.fromJson(dynamic json) {
    _itemName = json['itemName'];
    _itemCategoryName = json['itemCategoryName'];
    _itemQuantity = json['itemQuantity'];
    _itemQuantityAmount = json['itemQuantityAmount'];
    _itemPurchasePlace = json['itemPurchasePlace'];
  }

  @HiveField(0)
  String? _itemName;
  @HiveField(1)
  String? _itemCategoryName;
  @HiveField(2)
  String? _itemQuantity;
  @HiveField(3)
  num? _itemQuantityAmount;
  @HiveField(4)
  String? _itemPurchasePlace;
  ItemModel copyWith({
    String? itemName,
    String? itemCategoryName,
    String? itemQuantity,
    num? itemQuantityAmount,
    String? itemPurchasePlace,
  }) =>
      ItemModel(
        itemName: itemName ?? _itemName,
        itemCategoryName: itemCategoryName ?? _itemCategoryName,
        itemQuantity: itemQuantity ?? _itemQuantity,
        itemQuantityAmount: itemQuantityAmount ?? _itemQuantityAmount,
        itemPurchasePlace: itemPurchasePlace ?? _itemPurchasePlace,
      );
  String? get itemName => _itemName;
  String? get itemCategoryName => _itemCategoryName;
  String? get itemQuantity => _itemQuantity;
  num? get itemQuantityAmount => _itemQuantityAmount;
  String? get itemPurchasePlace => _itemPurchasePlace;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemName'] = _itemName;
    map['itemCategoryName'] = _itemCategoryName;
    map['itemQuantity'] = _itemQuantity;
    map['itemQuantityAmount'] = _itemQuantityAmount;
    map['itemPurchasePlace'] = _itemPurchasePlace;
    return map;
  }
}
