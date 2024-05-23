import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/common/colors.dart';
import 'package:master_list/controllers/category_controller.dart';
import 'package:master_list/controllers/drawer_controller.dart';
import 'package:master_list/controllers/item_controller.dart';
import 'package:master_list/controllers/quantity_controller.dart';
import 'package:master_list/widgets/text_form_field.dart';

import '../widgets/drawer_widget.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({super.key});
  final _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var itemController = Get.put(ItemController());
    var categoryController = Get.put(CategoryController());
    var quantityController = Get.put(QuantityController());
    var drawerController = Get.put(DrawerIndexController());
    if (categoryController.selectedValue.value == "") {
      categoryController.selectedValue.value =
          categoryController.categories[0].categoryName.toString();
    }

    if (quantityController.selectedValue.value == "") {
      quantityController.selectedValue.value =
          quantityController.quantities[0].quantityName.toString();
    }

    print(
        "categoryController.selectedValue.value : ${categoryController.selectedValue.value}");
    print(
        "categoryController.categories[0].categoryName.toString() : ${categoryController.categories[0].categoryName.toString()}");

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Item"),
          centerTitle: true,
        ),
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
                    return DropdownButtonFormField(
                      padding: EdgeInsets.all(8),
                      isExpanded: true,
                      iconEnabledColor: PRIMARY_COLOR,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: PRIMARY_COLOR, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                      ),
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
                      validator: (value) {
                        if (itemController.itemCategoryNameController.text ==
                            "") {
                          return "Select Category";
                        }
                      },
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
                          disabledHint: Text("Select Quantity"),
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
                          if (_formState.currentState!.validate() &&
                              itemController.itemCategoryNameController.text !=
                                  "" &&
                              itemController.itemQuantityController.text !=
                                  "") {
                            if (itemController.isEditMode.value) {
                              itemController.itemCategoryNameController.text =
                                  categoryController.selectedValue.value;
                              itemController.itemQuantityController.text =
                                  quantityController.selectedValue.value;
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
                          } else {
                            Get.snackbar("Empty Fields",
                                "Please select category or quantity");
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
