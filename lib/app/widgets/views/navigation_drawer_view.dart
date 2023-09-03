import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/database.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';

class NavigationDrawerView extends GetView {
  const NavigationDrawerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
        backgroundColor: Theme.of(context).primaryColor,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.PROFILE,
                arguments: {'sId': DatabaseHelper().getUserData().serverId}),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              height: 130.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35.w,
                        backgroundColor: darkAsh,
                        backgroundImage: CachedNetworkImageProvider(
                            DatabaseHelper().getUserData().photo ??
                                PLACEHOLDER_IMAGE),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(DatabaseHelper().getUserData().name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              '@${DatabaseHelper().getUserData().uid.toString()}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              children: [
                ListTile(
                  onTap: () => Get.toNamed(Routes.FOLLOWERS),
                  leading: const Icon(
                    CupertinoIcons.group_solid,
                    size: 25,
                  ),
                  title: Text('People',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
                ListTile(
                  onTap: () =>
                      Get.toNamed(Routes.LINK_LIST, arguments: {'index': 1}),
                  leading: const Icon(
                    Icons.add_link_rounded,
                    size: 25,
                  ),
                  title: Text('Link Requests',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.history,
                    size: 25,
                  ),
                  title: Text('Call Log',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.MATCH),
                  leading: const Icon(
                    CupertinoIcons.heart_circle_fill,
                    size: 25,
                  ),
                  title: Text('Match',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
                ListTile(
                  onTap: () => Get.toNamed(Routes.SETTINGS),
                  leading: const Icon(
                    CupertinoIcons.settings,
                    size: 25,
                  ),
                  title: Text('Settings',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    CupertinoIcons.info_circle,
                    size: 25,
                  ),
                  title: Text('About Us',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    CupertinoIcons.doc_text,
                    size: 25,
                  ),
                  title: Text('Terms & Conditions',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.privacy_tip_outlined,
                    size: 25,
                  ),
                  title: Text('Privacy Policy',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(
                    Icons.headset_mic_rounded,
                    size: 25,
                  ),
                  title: Text('Support',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontSize: 12.sp)),
                ),
              ],
            ),
          )
        ]);
  }
}
