// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkchat/app/style/app_color.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/style/style.dart';

class EditTextFieldView extends GetView {
  EditTextFieldView({this.controller, this.hintText, this.labelText, this.keyboardType, required this.iconData, this.suffixIcon, this.readOnly = false, this.onTap, this.validator, this.onChanged,  Key? key}) : super(key: key);
  @override
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final IconData iconData;
  final Widget? suffixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String?)? onChanged;
  String? Function(String?)? validator;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        icon: Icon(iconData, color: accentColor),
        hintText: hintText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ThemeProvider().isSavedLightMood() ? accentColor : white,
            width: 2
          )
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ThemeProvider().isSavedLightMood() ? accentColor : white,
            width: 1
          )
        ),
        
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: TextStyle(color: ThemeProvider().isSavedLightMood() ? accentColor : white)
      ),
    );
  }
}
