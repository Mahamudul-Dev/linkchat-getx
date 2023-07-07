import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkchat/app/modules/call_list/controllers/call_list_controller.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:star_menu/star_menu.dart';
import 'package:linkchat/app/widgets/views/round_button_view.dart';
import 'package:get/get.dart';

class CallMenuButtonView extends GetView<CallListController> {
  const CallMenuButtonView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return const RoundButtonView(
    icon: Icons.call_rounded,
  ).addStarMenu(
      params: StarMenuParameters.dropdown(context),
      controller: controller.starMenuController,
      items: <Widget>[
        const RoundButtonView(icon: Icons.call_rounded),
        RoundButtonView(
          icon: FontAwesomeIcons.video,
          iconSize: 10,
          onTap: () => Get.toNamed(Routes.CALL, arguments: {
            'uid': controller.getUserInfo(index).uid
          }),
        ),
        const RoundButtonView(icon: Icons.screen_share_rounded),
      ],
      onItemTapped: (index, controller) {
        if (index == 1) {
          controller.closeMenu;
          controller.dispose();
        } else {
          controller.closeMenu;
          controller.dispose();
        }
      });
  }
}
