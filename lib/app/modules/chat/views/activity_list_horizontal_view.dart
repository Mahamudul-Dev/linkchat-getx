import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

class ActivityListHorizontalView extends GetView <ChatController> {
  const ActivityListHorizontalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 10) {
            return RoundButtonView(
              widget: Lottie.asset(AssetManager.ARROW_RIGHT_OUTLINE_ANIM,
                  width: 30),
            );
          } else {
            return buildCircleAvater(index);
          }
        },
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemCount: controller.activeUser.length >= 5
            ? 6
            : controller.activeUser.length,
      ),
    );
  }

  Widget buildCircleAvater(int index) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(96, 0, 0, 0),
                blurRadius: 17.54,
                offset: Offset(10.32, 12.38),
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0x00292f3f), Color(0xcc292f3f)],
            ),
          ),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    ThemeProvider().isSavedLightMood() ? brightWhite : black,
                backgroundImage: CachedNetworkImageProvider(
                    controller
                        .activeUser[index]
                        .userProfilePic),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 13,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
              )
            ],
          )),
      const SizedBox(
        height: 3,
      ),
      SizedBox(
        width: 55,
        child: Text(
          controller.activeUser[index].userName,
          style: TextStyle(
              color: ThemeProvider().isSavedLightMood() ? black : brightWhite,
              fontSize: 10.sp),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}

}
