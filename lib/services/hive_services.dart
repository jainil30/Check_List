import 'package:master_list/models/CategoryModel.dart';
import 'package:master_list/models/ItemModel.dart';

import '../Utils/boxes.dart';
import '../models/QuantityModel.dart';

class HiveServices {
  final categoryBox = Boxes.getCategoryBox();
  final quantityBox = Boxes.getQuantityBox();
  final itemBox = Boxes.getItemBox();

  void addCategory(CategoryModel category) {
    print("Added CateGory :  ${category.categoryName}");
    categoryBox.add(category);
  }

  List<CategoryModel> getAllCategories() {
    return categoryBox.values.toList();
  }

  void editCategory(int index, String categoryName) {
    print(categoryName);
    categoryBox.putAt(index, CategoryModel(categoryName: categoryName));
  }

  void deleteCategory(int index) {
    categoryBox.deleteAt(index);
  }

//Quantity Services
  void addQuantity(QuantityModel quantity) {
    print("Added Quantity :  ${quantity.quantityName}");
    quantityBox.add(quantity);
  }

  List<QuantityModel> getAllQuantities() {
    return quantityBox.values.toList();
  }

  void editQuantity(int index, String quantityName) {
    print(quantityName);
    quantityBox.putAt(index, QuantityModel(quantityName: quantityName));
  }

  void deleteQuantity(int index) {
    quantityBox.deleteAt(index);
  }

//Item Services
  void addItem(ItemModel item) {
    itemBox.add(item);
  }

  List<ItemModel> getAllItems() {
    return itemBox.values.toList();
  }

  void editItem(int index, ItemModel item) {
    print("Edit Index: ${index}");
    itemBox.putAt(index, item);
  }

  void deleteItem(int index) {
    itemBox.deleteAt(index);
  }
}
