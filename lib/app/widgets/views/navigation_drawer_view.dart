import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkchat/app/modules/home/controllers/home_controller.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:lottie/lottie.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class NavigationDrawerView extends GetView {
  const NavigationDrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(children: [
      DrawerHeader(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: CachedNetworkImageProvider(
                    Get.find<HomeController>().currentUser.userProfilePic),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      Get.find<HomeController>().currentUser.userName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ThemeProvider().isSavedLightMood()
                              ? black
                              : brightWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text('@${Get.find<HomeController>().currentUser.uid}')
                  ],
                ),
              )
            ],
          )
        ],
      )),
      SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: ListView(
          children: [
            ListTile(
              onTap: () => Get.toNamed(Routes.PROFILE, arguments: {
                'uid': Get.find<HomeController>().currentUser.uid
              }),
              leading: const Icon(
                CupertinoIcons.profile_circled,
                size: 25,
              ),
              title: const Text('Profile'),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: Lottie.asset(AssetManager.JARVIS_ICON,
                  height: 45, width: 30, fit: BoxFit.cover, repeat: true),
              title: const Text('Jarvis Ai'),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () => Get.toNamed(Routes.SETTINGS),
              leading: const Icon(
                CupertinoIcons.settings,
                size: 25,
              ),
              title: const Text('Settings'),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                CupertinoIcons.info_circle,
                size: 25,
              ),
              title: const Text('About Us'),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                CupertinoIcons.doc_text,
                size: 25,
              ),
              title: const Text('Terms & Conditions'),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.privacy_tip_outlined,
                size: 25,
              ),
              title: const Text('Privacy Policy'),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: Lottie.asset(AssetManager.CUSTOMER_SUPPORT_ICON,
                  height: 30, fit: BoxFit.cover, repeat: true),
              title: const Text('Support'),
              trailing: const Icon(CupertinoIcons.forward),
            ),
          ],
        ),
      )
    ]);
  }
}
