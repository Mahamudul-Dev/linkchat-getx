import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/style.dart';

class AppTheme {
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: solidMate,
      useMaterial3: true,
      scaffoldBackgroundColor: white,
      textTheme: TextTheme(

        bodyMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14.sp,
          color: black
        ),
        bodySmall: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 10.sp,
            color: black
        ),
        labelMedium: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: black
        ),
        titleMedium: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 22.sp,
          color: black
        ),


      ),
      appBarTheme: AppBarTheme(
          elevation: 0,
          titleTextStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
              color: black
          ),
          backgroundColor: brightWhite,
          foregroundColor: black));

  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: solidMate,
      useMaterial3: true,
      scaffoldBackgroundColor: solidMate,
      textTheme: TextTheme(
          bodyMedium: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14.sp,
              color: brightWhite
          ),
          bodySmall: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 10.sp,
              color: brightWhite
          ),
          labelMedium: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: brightWhite
          ),
          titleMedium: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
              color: brightWhite
          )
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
            color: brightWhite
        ),
          backgroundColor: black,
          foregroundColor: white,
          elevation: 0),
      iconTheme: const IconThemeData(color: white));
}
