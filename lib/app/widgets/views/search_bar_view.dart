import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';

import 'package:get/get.dart';

class SearchBarView extends GetView implements PreferredSizeWidget{
  const SearchBarView({Key? key, required this.height, required this.hint}) : super(key: key);
  final double height;
  final String hint;
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
          color: ThemeProvider().isSavedLightMood() ? white : blackAccent,
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        style: TextStyle(
            fontSize: 16.sp,
            color: ThemeProvider().isSavedLightMood() ? black : white),
        cursorColor: ThemeProvider().isSavedLightMood() ? black : white,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              color: ThemeProvider().isSavedLightMood() ? accentColor : white,
            ),
            hintText: hint,
            border: InputBorder.none,
            hintStyle: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: ThemeProvider().isSavedLightMood() ? black : white,
                fontSize: 14.sp)),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
