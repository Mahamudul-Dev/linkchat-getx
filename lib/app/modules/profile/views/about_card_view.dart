import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../followers/controllers/followers_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../../style/style.dart';

class AboutCardView extends GetView {
  const AboutCardView({Key? key, required this.uid}) : super(key: key);
  final int uid;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Bio',
          style: TextStyle(
              fontSize: 16.sp, fontWeight: FontWeight.bold, color: brightWhite),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          uid == Get.find<HomeController>().currentUser.uid ? Get.find<HomeController>().currentUser.bio.toString() : Get.find<FollowersController>().followers.singleWhere((element) => element.uid == uid).bio.toString(),
          textAlign: TextAlign.justify,
          style: TextStyle(color: ThemeProvider().isSavedLightMood() ? black : brightWhite),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Get.find<HomeController>().currentUser.uid != uid
                ? ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(accentColor)),
                    onPressed: () {},
                    icon: const Icon(Icons.no_accounts_rounded),
                    label: const Text('Unfollow'))
                : const SizedBox.shrink(),
            Get.find<HomeController>().currentUser.uid != uid
                ? ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(accentColor)),
                    onPressed: () {},
                    icon: const Icon(Icons.chat_bubble),
                    label: const Text('Message'))
                : const SizedBox.shrink(),
            ElevatedButton.icon(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(accentColor)),
                onPressed: () {},
                icon: const Icon(Icons.share, color: brightWhite,),
                label: const Text('Share', style: TextStyle(color: brightWhite, fontWeight: FontWeight.w600),))
          ],
        )
      ],
    ),
  );
  }
}
