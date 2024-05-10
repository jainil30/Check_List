import 'package:flutter/material.dart';
import 'package:master_list/views/add_item_screen.dart';
import 'package:master_list/views/categories_screen.dart';
import 'package:master_list/views/items_list_screen.dart';
import 'package:master_list/views/quantities_screen.dart';

var drawerItems = [
  {
    "title": "Items",
    "icon": Icon(Icons.list_alt_sharp),
    "screen": ItemListScreen()
  },
  {
    "title": "Categories",
    "icon": Icon(Icons.category),
    "screen": CategoryScreen()
  },
  {
    "title": "Quantities",
    "icon": Icon(Icons.production_quantity_limits),
    "screen": QuantityScreen()
  },
  {"title": "Add Items", "icon": Icon(Icons.add), "screen": AddItemScreen()},
];
