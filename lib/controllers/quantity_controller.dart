import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/common/lists.dart';
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
    if (quantities.isEmpty) {
      for (var quantity in quantityList) {
        hiveService
            .addQuantity(QuantityModel(quantityName: quantity["quantityName"]));
      }
    }
    fetchAllquantities();
  }

  void addQuantity(QuantityModel newQuantity) {
    if (quantities
        .where((element) => element.quantityName == newQuantity.quantityName)
        .isEmpty) {
      hiveService.addQuantity(newQuantity);
    } else {
      Get.snackbar(
          "${newQuantity.quantityName} is already present in Quantities",
          "Try adding some other quantity",
          icon: Icon(Icons.discount));
    }
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
