import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/style/style.dart';

import 'app/routes/app_pages.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          ThemeProvider().isSavedLightMood() ? white : solidMate,
      statusBarBrightness: ThemeProvider().isSavedLightMood()
          ? Brightness.light
          : Brightness.dark,
      statusBarColor: Colors.transparent));
  runApp(const Link());
}

class Link extends StatelessWidget {
  const Link({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Link",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: ThemeProvider().getThemeMode(),
        );
      },
    );
  }
}
