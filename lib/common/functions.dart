import 'package:flutter/cupertino.dart';

double getHeight(double heightPercentage, BuildContext context) {
  return MediaQuery.of(context).size.height * heightPercentage;
}

double getWidth(double widthPercentage, BuildContext context) {
  return MediaQuery.of(context).size.width * widthPercentage;
}
