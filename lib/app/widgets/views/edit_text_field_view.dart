// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkchat/app/style/app_color.dart';

import 'package:get/get.dart';

class EditTextFieldView extends GetView {
  EditTextFieldView({this.controller, this.hintText, this.labelText, this.keyboardType, required this.iconData, this.suffixIcon, this.readOnly = false, this.onTap, this.validator, Key? key}) : super(key: key);
  @override
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final IconData iconData;
  final Widget? suffixIcon;
  final bool readOnly;
  final void Function()? onTap;
  String? Function(String?)? validator;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      style: TextStyle(
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        icon: Icon(iconData, color: accentColor),
        hintText: hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: accentColor,
            width: 2
          )
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: accentColor,
            width: 1
          )
        ),
        
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: const TextStyle(color: accentColor)
      ),
    );
  }
}
