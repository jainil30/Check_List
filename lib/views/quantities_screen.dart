import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/widgets/custom_quantity_list_item.dart';

import '../common/functions.dart';
import '../controllers/quantity_controller.dart';
import '../models/QuantityModel.dart';
import '../widgets/drawer_widget.dart';

class QuantityScreen extends StatelessWidget {
  QuantityScreen({super.key});
  var quantityController = Get.put(QuantityController());
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Text("quantities"),
        ),
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: quantityController.quantityTextEditingController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == "") {
                      return "Quantity name is mandatory";
                    }
                  },
                ),
              ),
              Obx(
                () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder()),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (quantityController.isEditMode.value) {
                          quantityController.editQuantity();
                        } else {
                          quantityController.addQuantity(QuantityModel(
                              quantityName: quantityController
                                  .quantityTextEditingController.text));
                        }
                        quantityController.quantityTextEditingController.text =
                            "";
                      }
                    },
                    child: Text(quantityController.isEditMode.value
                        ? "Update"
                        : "Save")),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                height: getHeight(0.7, context),
                width: double.infinity,
                child: Obx(
                  () => (quantityController.quantities.length != 0)
                      ? ListView.builder(
                          primary: true,
                          itemBuilder: (context, index) {
                            return CustomQuantityListTileWidget(
                              index: index,
                            );
                          },
                          itemCount: quantityController.quantities.length,
                        )
                      : Text("No quantities"),
                ),
              )
            ],
          ),
        ));
  }
}
