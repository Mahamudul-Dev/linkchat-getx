import 'package:flutter/material.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/modules/call_list/views/call_menu_button_view.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/widgets/widgets.dart';
import 'package:linkchat/app/modules/followers/controllers/followers_controller.dart';

class FollowerListTileView extends GetView<FollowersController> {
  const FollowerListTileView({Key? key, required this.serverId, required this.userName, required this.profilePic, required this.uid, required this.isActive, this.isChat = false}) : super(key: key);
  final String serverId;
  final String userName;
  final String profilePic;
  final String uid;
  final bool isActive;
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
                    ThemeProvider().isSavedLightMood().value ? brightWhite : black,
                backgroundImage: CachedNetworkImageProvider(profilePic),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 13,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive
                        ? Colors.green
                        : null,
                  ),
                ),
              )
            ],
          ),
        ),
        title: Text(
          '${userName.split(' ')[0]} ${userName.split(' ')[1]}',
          overflow: TextOverflow.ellipsis,
        ),
        subtitle:
            Text(uid),
        trailing: isChat
            ? RoundButtonView(
                icon: isChat ? Icons.send : Icons.call,
                onTap: () {
                  Get.toNamed(Routes.MESSAGE, arguments: {
                    'id': serverId
                  });
                })
            : CallMenuButtonView(serverId: serverId));
  }
}
