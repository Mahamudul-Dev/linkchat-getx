import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../style/style.dart';

class SearchBarView extends GetView implements PreferredSizeWidget{
  const SearchBarView({Key? key, required this.height, required this.hint, this.onChanged}) : super(key: key);
  final double height;
  final String hint;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          color: ThemeProvider().isSavedLightMood().value ? white : darkAsh,
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
            fontSize: 16.sp,
            color: ThemeProvider().isSavedLightMood().value ? black : white),
        cursorColor: ThemeProvider().isSavedLightMood().value ? black : white,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: ThemeProvider().isSavedLightMood().value ? accentColor : white,
            ),
            hintText: hint,
            border: InputBorder.none,
            hintStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: ThemeProvider().isSavedLightMood().value ? black : white,
                fontSize: 14.sp)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
