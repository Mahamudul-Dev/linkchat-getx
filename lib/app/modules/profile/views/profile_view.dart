import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../profile/views/about_card_view.dart';
import '../../profile/views/follower_card_view.dart';
import '../../profile/views/profile_card_view.dart';
import '../../home/controllers/home_controller.dart';
import '../../../style/style.dart';
import '../../../widgets/widgets.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  final uid = Get.arguments['uid'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RoundButtonView(
          onTap: () => Navigator.pop(context),
          icon: Icons.arrow_back_rounded,
        ),
        actions: [
          uid == Get.find<HomeController>().currentUser.data!.first.uid
              ? RoundButtonView(
                  onTap: () {},
                  icon: Icons.edit,
                )
              : const SizedBox.shrink()
        ],
        backgroundColor:
            ThemeProvider().isSavedLightMood() ? accentColor : black,
      ),
      body: ListView(
        children: [
          ProfileCardView(uid: uid,),
          AboutCardView(uid: uid),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Followers',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
          ),
          const FollowerCardView()
        ],
      ),
    );
  }


Widget buildView(BuildContext context, dynamic uid,  ScrollController? scrollController) {
  return ListView(
    controller: scrollController,
    shrinkWrap: true,
    children: [
      ProfileCardView(uid: uid,),
      AboutCardView(uid:uid),
    ],
  );
}

}
