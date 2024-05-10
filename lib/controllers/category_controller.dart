import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/models/CategoryModel.dart';
import 'package:master_list/services/hive_services.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var hiveService;
  var isEditMode = false.obs;
  var categoryTextEditingController = TextEditingController();
  var editIndex = 0.obs;
  var selectedValue = "".obs;

  CategoryController() {
    hiveService = HiveServices();
    fetchAllCategories();
  }

  void addCategory(CategoryModel newCategory) {
    hiveService.addCategory(newCategory);
    fetchAllCategories();
  }

  void fetchAllCategories() {
    categories.assignAll(hiveService.getAllCategories());
  }

  void deleteCategory(int index) {
    hiveService.deleteCategory(index);
    fetchAllCategories();
  }

  void editCategory() {
    hiveService.editCategory(
        editIndex.value, categoryTextEditingController.text);

    fetchAllCategories();
    isEditMode.value = false;
  }
}
