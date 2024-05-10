import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/controllers/category_controller.dart';

class CustomListTileWidget extends StatelessWidget {
  CustomListTileWidget({super.key, required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.put(CategoryController());
    return Card(
      elevation: 0.4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: Text(
              categoryController.categories[index!].categoryName.toString(),
              style: TextStyle(fontSize: 20),
            )),
            GestureDetector(
              child: Icon(
                Icons.edit,
                size: 30,
              ),
              onTap: () {
                categoryController.isEditMode.value = true;
                categoryController.categoryTextEditingController.text =
                    categoryController.categories[index!].categoryName
                        .toString();

                categoryController.editIndex.value = index;
              },
            ),
            GestureDetector(
              child: Icon(
                Icons.delete,
                size: 30,
              ),
              onTap: () {
                categoryController.deleteCategory(index);
              },
            )
          ],
        ),
      ),
    );
  }
}
