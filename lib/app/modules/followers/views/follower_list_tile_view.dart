import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/widgets.dart';

class FollowerListTileView extends GetView {
  const FollowerListTileView(
      {Key? key,
      required this.serverId,
      required this.userName,
      required this.profilePic,
      required this.country,
      required this.isActive,
      this.isChat = false})
      : super(key: key);
  final String serverId;
  final String userName;
  final String profilePic;
  final String country;
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
                backgroundColor: ThemeProvider().isSavedLightMood().value
                    ? brightWhite
                    : black,
                backgroundImage: CachedNetworkImageProvider(profilePic),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 13,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? Colors.green : null,
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
        subtitle: Text(country),
        trailing: isChat
            ? RoundButtonView(
                icon: Icons.send,
                onTap: () {
                  Get.toNamed(Routes.MESSAGE, arguments: {'id': serverId});
                })
            : const SizedBox.shrink());
  }
}
