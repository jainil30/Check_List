import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:master_list/common/functions.dart';
import 'package:master_list/common/lists.dart';
import 'package:master_list/controllers/drawer_controller.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  var drawerController = Get.put(DrawerIndexController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: CircleAvatar(
              foregroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSB9oF0K9m3KZbFrOm1s3GTB57LyEpOX2Rd9jFy91GDrw&s"),
              maxRadius: 100,
            ),
          ),
          Container(
            height: getHeight(0.7, context),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: drawerItems[index]["icon"] as Widget,
                    title: Text(drawerItems[index]["title"].toString()),
                    onTap: () {
                      drawerController.currentDrawerItemIndex.value = index;
                    },
                  );
                },
                itemCount: drawerItems.length),
          )
        ],
      ),
    );
  }
}
