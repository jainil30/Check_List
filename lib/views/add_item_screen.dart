import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/controllers/category_controller.dart';
import 'package:master_list/controllers/drawer_controller.dart';
import 'package:master_list/controllers/item_controller.dart';
import 'package:master_list/controllers/quantity_controller.dart';
import 'package:master_list/widgets/text_form_field.dart';

import '../widgets/drawer_widget.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});
  var _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var itemController = Get.put(ItemController());
    var categoryController = Get.put(CategoryController());
    var quantityController = Get.put(QuantityController());
    var drawerController = Get.put(DrawerIndexController());
    categoryController.selectedValue.value =
        categoryController.categories[0].categoryName.toString();
    quantityController.selectedValue.value =
        quantityController.quantities[0].quantityName.toString();

    return Scaffold(
        appBar: AppBar(),
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: itemController.itemNameController,
                    hintText: "Item Name",
                    textInputType: TextInputType.text,
                    labelText: "Item Name",
                    color: Colors.blueAccent,
                  ),
                  Obx(() {
                    print(categoryController.categories);
                    return DropdownButton(
                      padding: EdgeInsets.all(8),
                      isExpanded: true,
                      icon: Icon(Icons.category),
                      borderRadius: BorderRadius.circular(10),
                      value: categoryController.selectedValue.value,
                      items: categoryController.categories
                          .map((element) => DropdownMenuItem(
                                value: element.categoryName,
                                child: Text(element.categoryName.toString()),
                              ))
                          .toSet()
                          .toList(),
                      hint: const Text("Category"),
                      onChanged: (value) {
                        categoryController.selectedValue.value =
                            value.toString();
                        itemController.itemCategoryNameController.text =
                            value.toString();
                      },
                    );
                  }),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller:
                              itemController.itemQuantityAmountController,
                          hintText: "Quantity",
                          textInputType:
                              TextInputType.numberWithOptions(decimal: true),
                          labelText: "Quantity",
                          color: Colors.blueAccent,
                        ),
                      ),
                      Obx(() {
                        print(quantityController.quantities);
                        return DropdownButton(
                          value: quantityController.selectedValue.value,
                          enableFeedback: true,
                          items: quantityController.quantities
                              .map((element) => DropdownMenuItem(
                                    value: element.quantityName,
                                    child:
                                        Text(element.quantityName.toString()),
                                  ))
                              .toSet()
                              .toList(),
                          hint: const Text("Quantity"),
                          onChanged: (value) {
                            quantityController.selectedValue.value =
                                value.toString();

                            itemController.itemQuantityController.text =
                                value.toString();
                          },
                        );
                      }),
                    ],
                  ),
                  CustomTextFormField(
                    controller: itemController.itemPurchasePlaceController,
                    hintText: "Place",
                    textInputType: TextInputType.text,
                    labelText: "Place",
                    color: Colors.blueAccent,
                  ),
                  Obx(
                    () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder()),
                        onPressed: () {
                          if (_formState.currentState!.validate()) {
                            if (itemController.isEditMode.value) {
                              itemController.editItem();
                            } else {
                              itemController.addItem();
                            }
                            itemController.itemPurchasePlaceController.text =
                                "";
                            itemController.itemNameController.text = "";
                            itemController.itemQuantityAmountController.text =
                                "";
                            itemController.itemQuantityController.text = "";
                            itemController.itemCategoryNameController.text = "";

                            drawerController.setCurrentDrawerItemIndex = 0;
                          }
                        },
                        child: Text(categoryController.isEditMode.value
                            ? "Update"
                            : "Save")),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
