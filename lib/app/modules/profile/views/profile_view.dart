import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/routes/app_pages.dart';

import '../../../style/style.dart';
import '../../../widgets/widgets.dart';
import '../../profile/views/about_card_view.dart';
import '../../profile/views/follower_card_view.dart';
import '../../profile/views/profile_card_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final sId = Get.arguments['sId'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RoundButtonView(
          onTap: () => Navigator.pop(context),
          icon: Icons.arrow_back_rounded,
        ),
        actions: [
          sId == controller.getCurrentProfile.serverId
              ? RoundButtonView(
                  onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
                  icon: Icons.edit,
                )
              : const SizedBox.shrink()
        ],
        backgroundColor:
            ThemeProvider().isSavedLightMood().value ? accentColor : black,
      ),
      body: ListView(
        controller: controller.scrollController,
        children: [
          ProfileCardView(
            sId: sId,
          ),
          AboutCardView(
            sId: sId,
          ),
          sId == controller.getCurrentProfile.serverId
              ? controller.getCurrentProfile.followersCount != 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Followers',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
          const SizedBox(height: 10),
          sId == controller.getCurrentProfile.serverId
              ? controller.getCurrentProfile.followersCount != 0
                  ? const FollowerCardView()
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
