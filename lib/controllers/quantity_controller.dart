import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/models/QuantityModel.dart';
import 'package:master_list/services/hive_services.dart';

class QuantityController extends GetxController {
  var quantities = <QuantityModel>[].obs;
  var hiveService;
  var isEditMode = false.obs;
  var quantityTextEditingController = TextEditingController();
  var editIndex = 0.obs;
  var selectedValue = "".obs;
  QuantityController() {
    hiveService = HiveServices();
    fetchAllquantities();
  }

  void addQuantity(QuantityModel newQuantity) {
    hiveService.addQuantity(newQuantity);
    fetchAllquantities();
  }

  void fetchAllquantities() {
    quantities.assignAll(hiveService.getAllQuantities());
  }

  void deleteQuantity(int index) {
    hiveService.deleteQuantity(index);
    fetchAllquantities();
  }

  void editQuantity() {
    hiveService.editQuantity(
        editIndex.value, quantityTextEditingController.text);

    fetchAllquantities();
    isEditMode.value = false;
  }
}
