import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:linkchat/app/style/app_color.dart';
import 'package:linkchat/app/style/theme_provider.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/home/controllers/home_controller.dart';

class BottomNavBarView extends GetView<HomeController> {
  const BottomNavBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.width * .155,
      decoration: BoxDecoration(
        color:
            ThemeProvider().isSavedLightMood().value ? brightWhite : transparentBlack,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () => controller.changeIndex(0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: navBarItem(0, context)),
            InkWell(
                onTap: () => controller.changeIndex(1),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: navBarItem(1, context)),
            InkWell(
                onTap: () => controller.changeIndex(2),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: navBarItem(2, context)),
            InkWell(
                onTap: () => controller.changeIndex(3),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: navBarItem(3, context)),
          ],
        ),
      ),
    );
  }
  List<Widget> icons(BuildContext context, int index) {
  return [
    Obx(
      () => IconBadge(
        icon: Icon(
          Icons.chat,
          size: MediaQuery.of(context).size.width * .076,
          color:
              index == controller.currentIndex.value ? accentColor : null,
        ),
        itemCount: 6,
        badgeColor: accentColor,
        itemColor: brightWhite,
        hideZero: true,
      ),
    ),
    Obx(
      () => IconBadge(
        icon: Icon(
          Icons.call,
          size: MediaQuery.of(context).size.width * .076,
          color:
              index == controller.currentIndex.value ? accentColor : null,
        ),
        itemCount: 6,
        badgeColor: accentColor,
        itemColor: brightWhite,
        hideZero: true,
      ),
    ),
    Obx(
      () => Icon(
        Icons.call_merge_sharp,
        size: MediaQuery.of(context).size.width * .076,
        color: index == controller.currentIndex.value ? accentColor : null,
      ),
    ),
    Obx(() => Icon(
          Icons.dialpad_rounded,
          size: MediaQuery.of(context).size.width * .076,
          color:
              index == controller.currentIndex.value ? accentColor : null,
        ))
  ];
}

Widget navBarItem(int index, BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastLinearToSlowEaseIn,
            margin: EdgeInsets.only(
              bottom: index == controller.currentIndex.value
                  ? 0
                  : MediaQuery.of(context).size.width * .029,
              // right: MediaQuery.of(context).size.width * .0730,
              // left: MediaQuery.of(context).size.width * .0730,
            ),
            width: MediaQuery.of(context).size.width * .128,
            height: index == controller.currentIndex.value
                ? MediaQuery.of(context).size.width * .014
                : 0,
            decoration: const BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          )),
      icons(context, index)[index],
      SizedBox(height: MediaQuery.of(context).size.width * .03),
    ],
  );
}
}