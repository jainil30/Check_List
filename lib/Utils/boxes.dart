import 'package:hive/hive.dart';
import 'package:master_list/constants/string_constants.dart';
import 'package:master_list/models/ItemModel.dart';
import 'package:master_list/models/QuantityModel.dart';

import '../models/CategoryModel.dart';

class Boxes {
  static Box<CategoryModel>? _categoryBox;
  static Box<QuantityModel>? _quantityBox;
  static Box<ItemModel>? _itemBox;

  static Box<CategoryModel> getCategoryBox() {
    _categoryBox ??= Hive.box<CategoryModel>(CATEGORY_HIVE_BOX);
    return _categoryBox!;
  }

  static Box<QuantityModel> getQuantityBox() {
    _quantityBox ??= Hive.box<QuantityModel>(QUANTITY_HIVE_BOX);
    return _quantityBox!;
  }

  static Box<ItemModel> getItemBox() {
    _itemBox ??= Hive.box<ItemModel>(ITEM_HIVE_BOX);
    return _itemBox!;
  }
}
