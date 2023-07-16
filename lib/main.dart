import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linkchat/app/database/database_helper.dart';
import 'package:linkchat/app/style/style.dart';

import 'app/routes/app_pages.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await GetStorage.init();
  await DatabaseHelper.create();
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