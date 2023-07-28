import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/database/database.dart';
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
    return NavigationDrawer(
        backgroundColor: Theme.of(context).primaryColor,
        children: [
      GestureDetector(
        onTap: () => Get.toNamed(Routes.PROFILE, arguments: {
          'uid': DatabaseHelper().getUserData().uid
        }),
        child: DrawerHeader(

            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: darkAsh,
                  backgroundImage: CachedNetworkImageProvider(DatabaseHelper().getUserData().photo ?? PLACEHOLDER_IMAGE),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        DatabaseHelper().getUserData().name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text('@${DatabaseHelper().getUserData().uid.toString()}', style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  ),
                )
              ],
            )
          ],
        )),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: ListView(
          children: [
            ListTile(
              onTap: () {},
              leading: const Icon(
                CupertinoIcons.group_solid,
                size: 25,
              ),
              title: Text('Followers', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.history,
                size: 25,
              ),
              title: Text('Call History', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),


            ListTile(
              onTap: () {

              },
              leading: const Icon(
                Icons.screen_share_rounded,
                size: 25,
              ),
              title: Text('Screen Mirror', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),

            ListTile(
              onTap: () {},
              leading: const Icon(
                FontAwesomeIcons.heart,
                size: 25,
              ),
              title: Text('Match', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),

            ListTile(
              onTap: () {},
              leading: const Icon(
                FontAwesomeIcons.robot,
                size: 25,
              ),
              title: Text('Jarvis', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading:  const Icon(
                Icons.ads_click,
                size: 25,
              ),
              title: Text('Branding', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () => Get.toNamed(Routes.SETTINGS),
              leading: const Icon(
                CupertinoIcons.settings,
                size: 25,
              ),
              title: Text('Settings', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                CupertinoIcons.info_circle,
                size: 25,
              ),
              title: Text('About Us', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                CupertinoIcons.doc_text,
                size: 25,
              ),
              title: Text('Terms & Conditions', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.privacy_tip_outlined,
                size: 25,
              ),
              title: Text('Privacy Policy', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(
                Icons.headset_mic_rounded,
                size: 25,
              ),
              title: Text('Support', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp)),
              trailing: const Icon(CupertinoIcons.forward),
            ),
          ],
        ),
      )
    ]);
  }
}
