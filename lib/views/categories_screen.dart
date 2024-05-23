import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/common/functions.dart';
import 'package:master_list/controllers/category_controller.dart';
import 'package:master_list/models/CategoryModel.dart';
import 'package:master_list/widgets/custom_listile_widget.dart';

import '../widgets/drawer_widget.dart';
import '../widgets/text_form_field.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  var categoryController = Get.put(CategoryController());
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: Text("Categories"),
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
                child: CustomTextFormField(
                  controller: categoryController.categoryTextEditingController,
                  hintText: "Category Name",
                  textInputType: TextInputType.text,
                  labelText: "Category Name",
                  color: Colors.blueAccent,
                ),
              ),
              Obx(
                () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: BeveledRectangleBorder()),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (categoryController.isEditMode.value) {
                          categoryController.editCategory();
                        } else {
                          categoryController.addCategory(CategoryModel(
                              categoryName: categoryController
                                  .categoryTextEditingController.text));
                        }
                        categoryController.categoryTextEditingController.text =
                            "";
                      }
                    },
                    child: Text(categoryController.isEditMode.value
                        ? "Update"
                        : "Save")),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 20),
                height: getHeight(0.7, context),
                width: double.infinity,
                child: Obx(
                  () => (categoryController.categories.length != 0)
                      ? ListView.builder(
                          primary: true,
                          // physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CustomListTileWidget(
                              index: index,
                            );
                          },
                          itemCount: categoryController.categories.length,
                        )
                      : Text("No Categories"),
                ),
              )
            ],
          ),
        ));
  }
}
