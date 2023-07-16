import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/call_list/controllers/call_list_controller.dart';
import 'package:linkchat/app/modules/call_list/views/call_menu_button_view.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';
import 'package:linkchat/app/modules/home/controllers/home_controller.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:timeago/timeago.dart' as timeago;

class CallListTileView extends GetView<CallListController> {
  const CallListTileView({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: SizedBox(
          height: 40,
          width: 40,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor:
                    ThemeProvider().isSavedLightMood() ? brightWhite : black,
                backgroundImage: CachedNetworkImageProvider(
                    controller
                        .getUserInfo(index)
                        .data!.first.profilePic!),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 13,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Get.find<FollowersController>()
                            .followers
                            .singleWhere((element) =>
                                element.data!.first.uid ==
                                controller
                                    .callHistory[index]
                                    .callerId)
                            .data!.first.isActive!
                        ? Colors.green
                        : null,
                  ),
                ),
              )
            ],
          ),
        ),
        title: Text(controller.getUserInfo(index).data!.first.userName!, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),),
        subtitle: Row(
          children: [
            Text(timeago.format(DateTime.parse(
                controller.callHistory[index].endTime)), style: TextStyle(fontSize: 12.sp),),
            const SizedBox(
              width: 5,
            ),
            const Text('||'),
            const SizedBox(
              width: 5,
            ),
            getStatus(index)
          ],
        ),
        trailing: CallMenuButtonView(index: index));
  }

  Widget getStatus(int index) {
    if (controller.callHistory[index].isComplete &&
        controller.callHistory[index].callerId ==
            Get.find<HomeController>().currentUser.data!.first.uid) {
      return Row(
        children: [
          const Icon(
            Icons.call_made_rounded,
            color: accentColor,
            size: 15,
          ),
          Text('Outgoing Call',
              style: TextStyle(color: accentColor, fontSize: 10.sp))
        ],
      );
    } else if (!controller.callHistory[index].isComplete &&
        controller.callHistory[index].receiverId ==
            Get.find<HomeController>().currentUser.data!.first.uid) {
      return Row(
        children: [
          const Icon(
            Icons.call_received_rounded,
            color: Colors.green,
            size: 20,
          ),
          Text('Incomming Call',
              style: TextStyle(color: Colors.green, fontSize: 14.sp))
        ],
      );
    } else if (controller.callHistory[index].isComplete &&
        controller.callHistory[index].callerId ==
            Get.find<HomeController>().currentUser.data!.first.uid) {
      return Row(
        children: [
          const Icon(
            Icons.call_missed_outgoing,
            color: accentColor,
            size: 20,
          ),
          Text('Missed Call',
              style: TextStyle(color: Colors.red, fontSize: 14.sp))
        ],
      );
    } else {
      return Row(
        children: [
          const Icon(Icons.call_missed, color: accentColor),
          Text('Missed Call',
              style: TextStyle(color: Colors.red, fontSize: 14.sp))
        ],
      );
    }
  }
}
