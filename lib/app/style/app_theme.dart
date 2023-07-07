import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkchat/app/style/app_color.dart';

class AppTheme {
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: solidMate,
      useMaterial3: true,
      scaffoldBackgroundColor: white,
      appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: brightWhite,
          foregroundColor: black,
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.sp, color: black)));

  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: solidMate,
      useMaterial3: true,
      scaffoldBackgroundColor: solidMate,
      appBarTheme: AppBarTheme(
          backgroundColor: black,
          foregroundColor: white,
          elevation: 0,
          titleTextStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp)),
      iconTheme: const IconThemeData(color: white));
}
