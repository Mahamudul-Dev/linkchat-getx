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
          iconSize: 14,
          onTap: () => Get.toNamed(Routes.VIDEO_CALL, arguments: {
            'uid': controller.getUserInfo(index).data!.first.uid
          }),
        ),
        const RoundButtonView(icon: Icons.screen_share_rounded),
      ],
      onItemTapped: (btn, menuController) {
        switch (btn) {
          case 0:
            Get.offNamed(Routes.AUDIO_CALL);
            menuController.closeMenu;
            menuController.dispose();
            break;
          case 1:
            Get.offNamed(Routes.VIDEO_CALL, arguments: {
            'uid': controller.getUserInfo(index).data!.first.uid
          });
            menuController.closeMenu;
            menuController.dispose();
            break;
          case 2:
            menuController.closeMenu;
            menuController.dispose();
          default:
        }
      });
  }
}
