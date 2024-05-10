import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quantity_controller.dart';

class CustomQuantityListTileWidget extends StatelessWidget {
  CustomQuantityListTileWidget({super.key, required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    var quantityController = Get.put(QuantityController());
    return Card(
      elevation: 0.4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: Text(
              quantityController.quantities[index].quantityName.toString(),
              style: TextStyle(fontSize: 20),
            )),
            GestureDetector(
              child: Icon(
                Icons.edit,
                size: 30,
              ),
              onTap: () {
                quantityController.isEditMode.value = true;
                quantityController.quantityTextEditingController.text =
                    quantityController.quantities[index!].quantityName
                        .toString();

                quantityController.editIndex.value = index;
              },
            ),
            GestureDetector(
              child: Icon(
                Icons.delete,
                size: 30,
              ),
              onTap: () {
                quantityController.deleteQuantity(index);
              },
            )
          ],
        ),
      ),
    );
  }
}
