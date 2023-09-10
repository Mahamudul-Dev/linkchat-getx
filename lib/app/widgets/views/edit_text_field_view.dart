// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkchat/app/style/app_color.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/style/style.dart';

class EditTextFieldView extends GetView {
  EditTextFieldView({this.controller, this.hintText, this.labelText, this.keyboardType, required this.iconData, this.suffixIcon, this.readOnly = false, this.obscureText, this.onTap, this.validator, this.onChanged,  Key? key}) : super(key: key);
  @override
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final IconData iconData;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool? obscureText;
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
      obscureText: obscureText ?? false,
      validator: validator,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        icon: Icon(iconData, color: white),
        hintText: hintText,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: white,
            width: 2
          )
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: white,
            width: 1
          )
        ),
        
        suffixIcon: suffixIcon,
        labelText: labelText,
        labelStyle: const TextStyle(color: white)
      ),
    );
  }
}
