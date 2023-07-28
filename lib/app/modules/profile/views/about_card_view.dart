import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/profile/controllers/profile_controller.dart';
import '../../followers/controllers/followers_controller.dart';
import '../../../style/style.dart';

class AboutCardView extends GetView <ProfileController> {
  const AboutCardView({Key? key, required this.uid}) : super(key: key);
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Bio',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          uid == controller.getProfile.uid ? controller.getProfile.bio ?? 'No Information Available' : Get.find<FollowersController>().followers.singleWhere((element) => element.uid.toString() == uid).bio ?? 'No Information Available',
          textAlign: TextAlign.justify,
          style: TextStyle(color: ThemeProvider().isSavedLightMood().value ? black : brightWhite),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            controller.getProfile.uid != uid
                ? ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(accentColor)),
                    onPressed: () {},
                    icon: const Icon(Icons.no_accounts_rounded, color: brightWhite),
                    label: const Text('Unfollow',style: TextStyle(color: brightWhite, fontWeight: FontWeight.w600)))
                : const SizedBox.shrink(),
            controller.getProfile.uid != uid
                ? ElevatedButton.icon(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(accentColor)),
                    onPressed: () {},
                    icon: const Icon(Icons.chat_bubble, color: brightWhite,),
                    label: const Text('Message',style: TextStyle(color: brightWhite, fontWeight: FontWeight.w600)))
                : const SizedBox.shrink()
          ],
        )
      ],
    ),
  );
  }
}
