import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './app/database/database.dart';
import './app/style/style.dart';
import 'app/routes/app_pages.dart';
import 'app/services/socket_io_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          ThemeProvider().isSavedLightMood().value ? brightWhite : solidMate));
  await ObjectBoxSingleton().initObjectBox();
  await GetStorage.init();
  SocketIOService.initSocket();
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
