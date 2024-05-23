import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:master_list/common/colors.dart';
import 'package:master_list/controllers/category_controller.dart';
import 'package:master_list/controllers/drawer_controller.dart';
import 'package:master_list/controllers/item_controller.dart';
import 'package:master_list/controllers/quantity_controller.dart';
import 'package:master_list/models/ItemModel.dart';
import 'package:master_list/widgets/drawer_widget.dart';
import 'package:master_list/widgets/text_form_field.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../common/functions.dart';
import '../constants/string_constants.dart';
import '../widgets/custom_item_list_tile_widget.dart';

class ItemListScreen extends StatelessWidget {
  ItemListScreen({super.key});
  final _flutterContactPicker = FlutterContactPicker();
  final _formKey = GlobalKey<FormState>();
  final _path = "/storage/emulated/0/Download";
  String _filename = "";
  @override
  Widget build(BuildContext context) {
    var itemController = Get.put(ItemController());
    var drawerController = Get.put(DrawerIndexController());
    var categoryController = Get.put(CategoryController());
    var quantityController = Get.put(QuantityController());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Items"),
          backgroundColor: Theme.of(context).primaryColorLight,
          actions: [
            if (itemController.items.isNotEmpty)
              IconButton(
                  onPressed: () async {
                    Contact? contact =
                        await _flutterContactPicker.selectContact();
                    print(contact!.phoneNumbers);

                    String list = "--- *List Of Requirements* ---\n";
                    for (ItemModel item in itemController.items) {
                      list += "______________________\n";
                      list += "Name : ${item.itemName}\n";
                      list += "Category : ${item.itemCategoryName} \n";
                      list +=
                          "Quantity : ${item.itemQuantityAmount} ${item.itemQuantity} \n";
                      list += "Place : ${item.itemPurchasePlace} \n";
                    }
                    list += "------------------------------------";

                    final link = WhatsAppUnilink(
                      phoneNumber: contact.phoneNumbers![0],
                      text: list,
                    );
                    // Convert the WhatsAppUnilink instance to a Uri.
                    // The "launch" method is part of "url_launcher".
                    await launchUrlString(link.toString());
                  },
                  icon: const Icon(Icons.share))
          ],
        ),
        drawer: DrawerWidget(),
        body: Container(
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: AlignmentDirectional.topStart,
          //         end: AlignmentDirectional.bottomEnd,
          //         colors: [
          //       Colors.deepOrange,
          //       Colors.deepOrangeAccent,
          //       Colors.orange,
          //       Colors.orangeAccent
          //     ])),
          padding: EdgeInsets.all(16),
          height: getHeight(0.9, context),
          width: double.infinity,
          child: Obx(
            () => (itemController.items.length != 0)
                ? ListView.builder(
                    primary: true,
                    itemBuilder: (context, index) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              spacing: 10,
                              icon: Icons.edit,
                              backgroundColor: Colors.blueAccent,
                              onPressed: (context) {
                                itemController.isEditMode.value = true;
                                itemController.editIndex.value = index;

                                itemController.itemNameController.text =
                                    itemController.items[index].itemName
                                        .toString();
                                // itemController.itemCategoryNameController.text =
                                //     itemController.items[index].itemCategoryName
                                //         .toString();
                                itemController
                                        .itemQuantityAmountController.text =
                                    itemController
                                        .items[index].itemQuantityAmount
                                        .toString();
                                // itemController.itemQuantityController.text =
                                //     itemController.items[index].itemQuantity
                                //         .toString();
                                itemController
                                        .itemPurchasePlaceController.text =
                                    itemController
                                        .items[index].itemPurchasePlace
                                        .toString();

                                categoryController.selectedValue.value =
                                    itemController.items[index].itemCategoryName
                                        .toString();

                                quantityController.selectedValue.value =
                                    itemController.items[index].itemQuantity
                                        .toString();

                                print(categoryController.selectedValue.value);
                                print(quantityController.selectedValue.value);

                                drawerController.setCurrentDrawerItemIndex = 3;
                              },
                            ),
                            SlidableAction(
                              icon: Icons.delete_forever,
                              backgroundColor: Colors.redAccent,
                              onPressed: (context) {
                                itemController.deleteItem(index!);
                              },
                            ),
                          ],
                        ),
                        child: CustomItemListTileWidget(
                          index: index,
                          itemName:
                              itemController.items[index].itemName.toString(),
                          itemCategory: itemController
                              .items[index].itemCategoryName
                              .toString(),
                          itemPurchasePlace: itemController
                              .items[index].itemPurchasePlace
                              .toString(),
                          itemQuantity: itemController.items[index].itemQuantity
                              .toString(),
                          itemQuantityAmount: itemController
                              .items[index].itemQuantityAmount
                              .toString(),
                        ),
                      );
                    },
                    itemCount: itemController.items.length,
                  )
                : Center(
                    child: const Text(
                    EMPTY_LIST_NOTE,
                    textAlign: TextAlign.center,
                  )),
          ),
        ),
        floatingActionButton: (itemController.items.isNotEmpty)
            ? FloatingActionButton(
                child: Icon(Icons.print),
                onPressed: () async {
                  final PdfDocument document = PdfDocument();
                  final PdfPage page = document.pages.add();
                  final PdfGrid grid = PdfGrid();

                  grid.columns.add(count: 4);
                  final PdfGridRow headerRow = grid.headers.add(1)[0];
                  headerRow.cells[0].value = "Item Name";
                  headerRow.cells[1].value = "Item Category";
                  headerRow.cells[2].value = "Item Quanty";
                  headerRow.cells[3].value = "Purchase Place";

                  for (var item in itemController.items) {
                    PdfGridRow row = grid.rows.add();
                    row.cells[0].value = item.itemName!;
                    row.cells[1].value = item.itemCategoryName!;
                    row.cells[2].value =
                        "${item.itemQuantityAmount!} ${item.itemQuantity!}";
                    row.cells[3].value = item.itemPurchasePlace!;
                  }

                  grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
                  grid.draw(
                      page: page,
                      bounds: Rect.fromLTWH(0, 0, page.getClientSize().width,
                          page.getClientSize().height));

                  // var directory = await getExternalStorageDirectory();
                  // File("${directory!.path}/master_list.pdf")
                  //     .writeAsBytes(await document.save());

                  var filenameController = TextEditingController();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        children: [
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextFormField(
                                    controller: filenameController,
                                    hintText: 'Filename',
                                    labelText: "Filename",
                                    textInputType: TextInputType.text,
                                    color: PRIMARY_COLOR,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: BeveledRectangleBorder()),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _filename =
                                            "${filenameController.text}.pdf";

                                        Get.snackbar("Saved ${_filename}",
                                            "Locatoin : ${_path}");
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.save,
                                          color: PRIMARY_COLOR,
                                        ),
                                        Text(
                                          "Save",
                                          style:
                                              TextStyle(color: PRIMARY_COLOR),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  print("Path : ${_path}/${_filename}");
                  File("${_path}/${_filename}")
                      .writeAsBytes(await document.save());

                  // print(directory.path);
                  print("Doc Info : ${document.documentInformation.isBlank}");
                  document.dispose();
                },
              )
            : null);
  }
}
