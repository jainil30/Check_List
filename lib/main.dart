import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:master_list/common/lists.dart';
import 'package:master_list/constants/string_constants.dart';
import 'package:master_list/controllers/drawer_controller.dart';
import 'package:master_list/models/CategoryModel.dart';
import 'package:master_list/models/ItemModel.dart';
import 'package:master_list/models/QuantityModel.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(QuantityModelAdapter());
  Hive.registerAdapter(ItemModelAdapter());

  await Hive.openBox<CategoryModel>(CATEGORY_HIVE_BOX);
  await Hive.openBox<QuantityModel>(QUANTITY_HIVE_BOX);
  await Hive.openBox<ItemModel>(ITEM_HIVE_BOX);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var drawerController = Get.put(DrawerIndexController());
    return GetMaterialApp(
      title: 'Check List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        primaryColor: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: Obx(() => drawerItems[drawerController.getCurrentDrawerItemIndex]
          ["screen"] as Widget),
    );
  }
}
