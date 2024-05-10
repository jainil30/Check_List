import 'package:hive/hive.dart';

/// categoryName : "Grocery"

part "CategoryModel.g.dart";

@HiveType(typeId: 0)
class CategoryModel {
  CategoryModel({
    String? categoryName,
  }) {
    _categoryName = categoryName;
  }

  CategoryModel.fromJson(dynamic json) {
    _categoryName = json['categoryName'];
  }
  @HiveField(0)
  String? _categoryName;
  CategoryModel copyWith({
    String? categoryName,
  }) =>
      CategoryModel(
        categoryName: categoryName ?? _categoryName,
      );
  String? get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryName'] = _categoryName;
    return map;
  }
}
