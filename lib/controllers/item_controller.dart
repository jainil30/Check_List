import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/models/ItemModel.dart';
import 'package:master_list/services/hive_services.dart';

class ItemController extends GetxController {
  var items = <ItemModel>[].obs;
  var hiveService;
  var isEditMode = false.obs;
  var itemNameController = TextEditingController();
  var itemQuantityController = TextEditingController();
  var itemQuantityAmountController = TextEditingController();
  var itemCategoryNameController = TextEditingController();
  var itemPurchasePlaceController = TextEditingController();

  var editIndex = 0.obs;

  ItemController() {
    hiveService = HiveServices();
    fetchAllItems();
  }

  void addItem() {
    hiveService.addItem(ItemModel(
        itemName: itemNameController.text,
        itemCategoryName: itemCategoryNameController.text,
        itemQuantity: itemQuantityController.text,
        itemQuantityAmount: double.parse(itemQuantityAmountController.text),
        itemPurchasePlace: itemPurchasePlaceController.text));

    itemNameController.text = "";
    itemQuantityController.text = "";
    itemQuantityAmountController.text = "";
    itemCategoryNameController.text = "";
    itemPurchasePlaceController.text = "";

    fetchAllItems();
  }

  void fetchAllItems() {
    items.assignAll(hiveService.getAllItems());
  }

  void deleteItem(int index) {
    hiveService.deleteItem(index);
    fetchAllItems();
  }

  void editItem() {
    hiveService.editItem(
        editIndex.value,
        ItemModel(
            itemName: itemNameController.text,
            itemCategoryName: itemCategoryNameController.text,
            itemQuantity: itemQuantityController.text,
            itemQuantityAmount: double.parse(itemQuantityAmountController.text),
            itemPurchasePlace: itemPurchasePlaceController.text));

    itemNameController.text = "";
    itemQuantityController.text = "";
    itemQuantityAmountController.text = "";
    itemCategoryNameController.text = "";
    itemPurchasePlaceController.text = "";
    fetchAllItems();
    isEditMode.value = false;
  }
}
