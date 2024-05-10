import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.color,
      required this.textInputType,
      required this.labelText});

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Color? color;
  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(borderSide: BorderSide(color: color!)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color!, width: 2))),
        validator: (value) {
          if (value!.isEmpty) {
            return "Field is mandatory";
          }

          if (textInputType == TextInputType.emailAddress) {
            if (!value.isEmail) {
              return "Invalid email address";
            }
          }

          if (textInputType == TextInputType.phone) {
            if (!value.isPhoneNumber) {
              return "Invalid Phone number";
            }
          }
        },
      ),
    );
  }
}
