import 'package:get/get.dart';

class DrawerIndexController extends GetxController {
  var currentDrawerItemIndex = 0.obs;

  set setCurrentDrawerItemIndex(int setIndex) {
    currentDrawerItemIndex.value = setIndex;
  }

  int get getCurrentDrawerItemIndex => currentDrawerItemIndex.value;
}
