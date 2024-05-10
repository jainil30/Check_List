import 'package:hive/hive.dart';

/// quantityName : "Kilogram "
part "QuantityModel.g.dart";

@HiveType(typeId: 1)
class QuantityModel {
  QuantityModel({
    String? quantityName,
  }) {
    _quantityName = quantityName;
  }

  QuantityModel.fromJson(dynamic json) {
    _quantityName = json['quantityName'];
  }

  @HiveField(0)
  String? _quantityName;
  QuantityModel copyWith({
    String? quantityName,
  }) =>
      QuantityModel(
        quantityName: quantityName ?? _quantityName,
      );
  String? get quantityName => _quantityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantityName'] = _quantityName;
    return map;
  }
}
