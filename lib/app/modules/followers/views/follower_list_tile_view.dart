import 'package:flutter/material.dart';
import 'package:linkchat/app/modules/call_list/views/call_menu_button_view.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';

class FollowerListTileView extends GetView<FollowersController> {
  const FollowerListTileView({Key? key, required this.index, required this.isChat}) : super(key: key);
  final int index;
  final bool isChat;
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
                        controller.followers[index]
                        .userProfilePic),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 13,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller
                            .followers[index]
                            .isActive
                        ? Colors.green
                        : null,
                  ),
                ),
              )
            ],
          ),
        ),
        title: Text(
          '${controller.followers[index].userName.split(' ')[0]} ${controller.followers[index].userName.split(' ')[1]}',
          overflow: TextOverflow.ellipsis,
        ),
        subtitle:
            Text(controller.followers[index].userEmail),
        trailing: isChat
            ? RoundButtonView(
                icon: isChat ? Icons.send : Icons.call,
                onTap: () {
                  Get.toNamed(Routes.MESSAGE, arguments: {
                    'uid':
                        controller.followers[index].uid
                  });
                })
            : CallMenuButtonView(index: index));
  }
}
